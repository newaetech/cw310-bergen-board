/* 
ChipWhisperer Bergen Target - Example of connections between example registers
and rest of system.

Copyright (c) 2021, NewAE Technology Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted without restriction. Note that modules within
the project may have additional restrictions, please carefully inspect
additional licenses.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

The views and conclusions contained in the software and documentation are those
of the authors and should not be interpreted as representing official policies,
either expressed or implied, of NewAE Technology Inc.
*/

`timescale 1ns / 1ps
`default_nettype none 

module cw310_top #(
    parameter pBYTECNT_SIZE = 7,
    parameter pUSB_ADDR_WIDTH = 20,
    parameter pPT_WIDTH = 128,
    parameter pCT_WIDTH = 128,
    parameter pKEY_WIDTH = 128,
    parameter pSRAM_ADDR_WIDTH = 20
)(
    // USB Interface
    input wire                          usb_clk,        // Clock
    inout wire [7:0]                    USB_D,          // Data for write/read
    input wire [pUSB_ADDR_WIDTH-1:0]    USB_A,          // Address
    input wire                          USB_nRD,        // !RD, low when addr valid for read
    input wire                          USB_nWR,        // !WR, low when data+addr valid for write
    input wire                          USB_nCE,        // !CE, active low chip enable
    input wire                          usb_trigger,    // High when trigger requested

    // Buttons/LEDs on Board
    input wire [7:0]                    USRDIP,         // DIP switch 0-7
    input wire                          USRSW2,     // Pushbutton SW4, connected to R1, used here as reset
    output wire [7:0]                   USRLED,

    // PLL
    input wire                          PLL_CLK1,       //PLL Clock Channel #1

    // 20-Pin Connector Stuff
    output wire                         CWIO_IO4,
    output wire                         CWIO_HS1,
    input  wire                         CWIO_HS2,

    input  wire                         vauxp0,
    input  wire                         vauxn0,
    input  wire                         vauxp1,
    input  wire                         vauxn1,
    input  wire                         vauxp8,
    input  wire                         vauxn8,

    // SRAM
    output wire [pSRAM_ADDR_WIDTH-1:0]  SRAM_A,
    inout  wire [7:0]                   SRAM_DQ,
    output wire                         SRAM_CE2,
    output wire                         SRAM_CEn,
    output wire                         SRAM_OEn,
    output wire                         SRAM_WEn,

    // DDR
    output wire [15:0]                  ddr3_addr,
    output wire [2:0]                   ddr3_ba,
    output wire                         ddr3_cas_n,
    output wire                         ddr3_ck_n,
    output wire                         ddr3_ck_p,
    output wire                         ddr3_cke,
    output wire                         ddr3_ras_n,
    output wire                         ddr3_reset_n,
    output wire                         ddr3_we_n,
    inout  wire [7:0]                   ddr3_dq,
    inout  wire                         ddr3_dqs_n,
    inout  wire                         ddr3_dqs_p,
    output wire                         ddr3_dm,
    output wire                         ddr3_cs_n,
    output wire                         ddr3_odt,

    output wire                         LVDS_XO_200M_ENA,
    // TODO NEXT: how was this in my standalone project?
    input  wire                         SYSCLK_P,
    input  wire                         SYSCLK_N
    );


    wire [pKEY_WIDTH-1:0] crypt_key;
    wire [pPT_WIDTH-1:0] crypt_textout;
    wire [pCT_WIDTH-1:0] crypt_cipherin;
    wire crypt_init;
    wire crypt_ready;
    wire crypt_start;
    wire crypt_done;
    wire crypt_busy;

    wire usb_clk_buf;
    wire [7:0] usb_dout;
    wire isout;
    wire [pUSB_ADDR_WIDTH-pBYTECNT_SIZE-1:0] reg_address;
    wire [pBYTECNT_SIZE-1:0] reg_bytecnt;
    wire reg_addrvalid;
    wire [7:0] write_data;
    wire [7:0] read_data;
    wire reg_read;
    wire reg_write;
    wire [4:0] clk_settings;
    wire crypt_clk;

    wire [7:0] reg_leds;
    wire hearbeats;
    wire [7:0] top_address;
    wire ddr3_pass;
    wire ddr3_fail;
    wire sram_pass;
    wire sram_fail;
    wire ddr3_en;
    wire sram_en;
    wire sysclk;

    wire init_calib_complete;

    wire [11:0] temp_out;

    wire resetn = USRSW2;
    wire reset = !resetn;
    reg [31:0] sysclk_frequency;



    // USB CLK Heartbeat
    reg [24:0] usb_timer_heartbeat;
    always @(posedge usb_clk_buf) usb_timer_heartbeat <= usb_timer_heartbeat +  25'd1;

    // CRYPT CLK Heartbeat
    reg [22:0] crypt_clk_heartbeat;
    always @(posedge crypt_clk) crypt_clk_heartbeat <= crypt_clk_heartbeat +  23'd1;

    assign USRLED = hearbeats? {6'b0, crypt_clk_heartbeat[22], usb_timer_heartbeat[24]} : reg_leds;


    cw310_usb_reg_fe #(
       .pBYTECNT_SIZE           (pBYTECNT_SIZE),
       .pADDR_WIDTH             (pUSB_ADDR_WIDTH)
    ) U_usb_reg_fe (
       .rst                     (reset),
       .usb_clk                 (usb_clk_buf), 
       .usb_din                 (USB_D), 
       .usb_dout                (usb_dout), 
       .usb_rdn                 (USB_nRD), 
       .usb_wrn                 (USB_nWR),
       .usb_cen                 (USB_nCE),
       .usb_alen                (1'b0),                 // unused
       .usb_addr                (USB_A),
       .usb_isout               (isout), 
       .reg_address             (reg_address), 
       .reg_bytecnt             (reg_bytecnt), 
       .reg_datao               (write_data), 
       .reg_datai               (read_data),
       .reg_read                (reg_read), 
       .reg_write               (reg_write), 
       .reg_addrvalid           (reg_addrvalid)
    );


    cw310_reg_aes #(
       .pBYTECNT_SIZE           (pBYTECNT_SIZE),
       .pADDR_WIDTH             (pUSB_ADDR_WIDTH),
       .pPT_WIDTH               (pPT_WIDTH),
       .pCT_WIDTH               (pCT_WIDTH),
       .pKEY_WIDTH              (pKEY_WIDTH)
    ) U_reg_aes (
       .reset_i                 (reset),
       .crypto_clk              (crypt_clk),
       .usb_clk                 (usb_clk_buf), 
       .reg_address             (reg_address[pUSB_ADDR_WIDTH-pBYTECNT_SIZE-1:0]), 
       .reg_bytecnt             (reg_bytecnt), 
       .read_data               (read_data), 
       .write_data              (write_data),
       .reg_read                (reg_read), 
       .reg_write               (reg_write), 
       .reg_addrvalid           (reg_addrvalid),

       .exttrigger_in           (usb_trigger),

       .I_textout               (128'b0),               // unused
       .I_cipherout             (crypt_cipherin),
       .I_ready                 (crypt_ready),
       .I_done                  (crypt_done),
       .I_busy                  (crypt_busy),
       .I_ddr3_pass             (ddr3_pass & ~ddr3_fail),
       .I_sram_pass             (sram_pass & ~sram_fail),
       .I_ddr3_calib_complete   (init_calib_complete),
       .I_dip                   (USRDIP),
       .I_sysclk_freq           (sysclk_frequency),

       .O_user_led              (),
       .O_key                   (crypt_key),
       .O_textin                (crypt_textout),
       .O_cipherin              (),                     // unused
       .O_start                 (crypt_start),

       .O_ddr3_en               (ddr3_en),
       .O_sram_en               (sram_en),
       .O_xo_en                 (LVDS_XO_200M_ENA),
       .O_leds                  (reg_leds),
       .O_hearbeats             (hearbeats),
       .O_top_address           (top_address)

    );

    assign USB_D = isout? usb_dout : 8'bZ;

    clocks U_clocks (
       .usb_clk                 (usb_clk),
       .usb_clk_buf             (usb_clk_buf),
       .I_j16_sel               (USRDIP[0]),
       .I_k16_sel               (USRDIP[1]),
       //.I_j16_sel               (1'b0),
       //.I_k16_sel               (1'b1),
       .I_clock_reg             (clk_settings),
       .I_cw_clkin              (CWIO_HS2),
       .I_pll_clk1              (PLL_CLK1),
       .O_cw_clkout             (CWIO_HS1),
       .O_cryptoclk             (crypt_clk)
    );


   wire aes_clk;
   wire [127:0] aes_key;
   wire [127:0] aes_pt;
   wire [127:0] aes_ct;
   wire aes_load;
   wire aes_busy;

   assign aes_clk = crypt_clk;
   assign aes_key = crypt_key;
   assign aes_pt = crypt_textout;
   assign crypt_cipherin = aes_ct;
   assign aes_load = crypt_start;
   assign crypt_ready = 1'b1;
   assign crypt_done = ~aes_busy;
   assign crypt_busy = aes_busy;

   // Example AES Core
   aes_core aes_core (
       .clk             (aes_clk),
       .load_i          (aes_load),
       .key_i           ({aes_key, 128'h0}),
       .data_i          (aes_pt),
       .size_i          (2'd0), //AES128
       .dec_i           (1'b0),//enc mode
       .data_o          (aes_ct),
       .busy_o          (aes_busy)
   );

   assign CWIO_IO4 = aes_busy;

   simple_sram_rwtest #(
      .pDATA_WIDTH      (8),
      .pADDR_WIDTH      (pSRAM_ADDR_WIDTH)
   ) U_sram_test (
      .clk              (usb_clk_buf),
      .reset            (reset),
      .active           (sram_en),
      .pass             (sram_pass),
      .fail             (sram_fail),
      .I_top_address    (top_address),
   
      .wen              (SRAM_WEn),
      .oen              (SRAM_OEn),
      .cen              (SRAM_CEn),
      .ce2              (SRAM_CE2),
      .addr             (SRAM_A),
      .data             (SRAM_DQ)
   );


    `ifndef __ICARUS__
        xadc_wiz_0 U_xadc (
          .di_in                (0),                    // input wire [15 : 0] di_in
          .daddr_in             (0),                    // input wire [6 : 0] daddr_in
          .den_in               (0),                    // input wire den_in
          .dwe_in               (0),                    // input wire dwe_in
          .drdy_out             (),                     // output wire drdy_out
          .do_out               (),                     // output wire [15 : 0] do_out
          //.dclk_in              (usb_clk_buf),          // input wire dclk_in
          //.reset_in             (reset),                // input wire reset_in
          .vp_in                (),                     // input wire vp_in
          .vn_in                (),                     // input wire vn_in
          .vauxp0               (vauxp0),               // input wire vauxp0
          .vauxn0               (vauxn0),               // input wire vauxn0
          .vauxp1               (vauxp1),               // input wire vauxp1
          .vauxn1               (vauxn1),               // input wire vauxn1
          .vauxp8               (vauxp8),               // input wire vauxp8
          .vauxn8               (vauxn8),               // input wire vauxn8
          .user_temp_alarm_out  (),                     // output wire user_temp_alarm_out
          .vccint_alarm_out     (),                     // output wire vccint_alarm_out
          .vccaux_alarm_out     (),                     // output wire vccaux_alarm_out
          .ot_out               (),                     // output wire ot_out
          .channel_out          (),                     // output wire [4 : 0] channel_out
          .eoc_out              (),                     // output wire eoc_out
          .vbram_alarm_out      (),                     // output wire vbram_alarm_out
          .alarm_out            (),                     // output wire alarm_out
          .eos_out              (),                     // output wire eos_out
          .busy_out             (),                     // output wire busy_out
          .temp_out             (temp_out),             // output wire [11:0] temp_out
          .m_axis_tvalid        (),                     // output wire m_axis_tvalid
          .m_axis_tready        (1'b1),                 // input wire m_axis_tready
          .m_axis_tdata         (),                     // output wire [15 : 0] m_axis_tdata
          .m_axis_tid           (),                     // output wire [4 : 0] m_axis_tid
          .m_axis_aclk          (usb_clk_buf),          // input wire m_axis_aclk
          .s_axis_aclk          (usb_clk_buf),          // input wire s_axis_aclk
          .m_axis_resetn        (resetn)                // input wire m_axis_resetn
        );
    `endif

   `ifdef __ICARUS__
      assign sysclk = SYSCLK_P;

   `else
      IBUFDS #(
         .DIFF_TERM        ("FALSE"),
         .IBUF_LOW_PWR     ("FALSE"),
         .IOSTANDARD       ("LVDS_25")
      ) U_IBUFDS_adc_clk_fb (
         .I                (SYSCLK_P),
         .IB               (SYSCLK_N),
         .O                (sysclk)
      );
   `endif


   //Divide clock by 2^24 for heartbeat LED
   //Divide clock by 2^23 for frequency measurement
   reg [24:0] timer_heartbeat;
   reg freq_measure;
   reg timer_heartbeat22r;
   always @(posedge usb_clk_buf)
      if (reset) begin
         timer_heartbeat <= 25'b0;
         timer_heartbeat22r <= 1'b0;
         freq_measure <= 1'b0;
      end 
      else begin
         timer_heartbeat <= timer_heartbeat +  25'd1;
         timer_heartbeat22r <= timer_heartbeat[22];
         if (timer_heartbeat[22] && ~timer_heartbeat22r)
            freq_measure <= 1'b1;
         else
            freq_measure <= 1'b0;
      end

   wire freq_measure_sysclk;
   cdc_pulse U_freq_measure (
      .reset_i       (reset),
      .src_clk       (usb_clk_buf),
      .src_pulse     (freq_measure),
      .dst_clk       (sysclk),
      .dst_pulse     (freq_measure_sysclk)
   );

   reg [31:0] sysclk_frequency_int;

   always @(posedge sysclk) begin
      if (freq_measure_sysclk) begin
         sysclk_frequency_int <= 32'd1;
         sysclk_frequency <= sysclk_frequency_int;
      end 
      else begin
         sysclk_frequency_int <= sysclk_frequency_int + 32'd1;
      end
   end

   // application interface to DDR3:
   wire [28:0]  app_addr;
   wire [2:0]   app_cmd;
   wire         app_en;
   wire [31:0]  app_wdf_data;
   wire         app_wdf_end;
   wire         app_wdf_wren;
   wire         app_sr_req;
   wire         app_ref_req;
   wire         app_zq_req;
   wire [3:0]   app_wdf_mask;
   wire         app_sr_active;
   wire         app_ref_ack;
   wire         app_zq_ack;
   wire         ui_clk;
   wire         ui_clk_sync_rst;
   wire [31:0]  app_rd_data;
   wire         app_rd_data_end;
   wire         app_rd_data_valid;
   wire         app_rdy;
   wire         app_wdf_rdy;


   simple_ddr3_rwtest #(
      .pDATA_WIDTH                         (32),
      .pADDR_WIDTH                         (29),
      .pMASK_WIDTH                         (4)
   ) U_simple_ddr3_rwtest (
      .clk                                 (ui_clk              ),
      .reset                               (reset               ),
      .active                              (ddr3_en             ),
      .init_calib_complete                 (init_calib_complete ),
      .pass                                (ddr3_pass           ),
      .fail                                (ddr3_fail           ),

      .app_addr                            (app_addr            ),
      .app_cmd                             (app_cmd             ),
      .app_en                              (app_en              ),
      .app_wdf_data                        (app_wdf_data        ),
      .app_wdf_end                         (app_wdf_end         ),
      .app_wdf_wren                        (app_wdf_wren        ),
      .app_sr_req                          (app_sr_req          ),
      .app_ref_req                         (app_ref_req         ),
      .app_zq_req                          (app_zq_req          ),
      .app_wdf_mask                        (app_wdf_mask        ),

      .app_sr_active                       (app_sr_active       ),
      .app_ref_ack                         (app_ref_ack         ),
      .app_zq_ack                          (app_zq_ack          ),
      .app_rd_data                         (app_rd_data         ),
      .app_rd_data_end                     (app_rd_data_end     ),
      .app_rd_data_valid                   (app_rd_data_valid   ),
      .app_rdy                             (app_rdy             ),
      .app_wdf_rdy                         (app_wdf_rdy         )
   );


  `ifndef __ICARUS__
  mig_7series_nosysclock u_mig_7series_nosysclock (
    // Memory interface ports
    .ddr3_addr                      (ddr3_addr),                // output [15:0] ddr3_addr
    .ddr3_ba                        (ddr3_ba),                  // output [2:0] ddr3_ba
    .ddr3_cas_n                     (ddr3_cas_n),               // output ddr3_cas_n
    .ddr3_ck_n                      (ddr3_ck_n),                // output [0:0] ddr3_ck_n
    .ddr3_ck_p                      (ddr3_ck_p),                // output [0:0] ddr3_ck_p
    .ddr3_cke                       (ddr3_cke),                 // output [0:0] ddr3_cke
    .ddr3_ras_n                     (ddr3_ras_n),               // output ddr3_ras_n
    .ddr3_reset_n                   (ddr3_reset_n),             // output ddr3_reset_n
    .ddr3_we_n                      (ddr3_we_n),                // output ddr3_we_n
    .ddr3_dq                        (ddr3_dq),                  // inout [7:0] ddr3_dq
    .ddr3_dqs_n                     (ddr3_dqs_n),               // inout [0:0] ddr3_dqs_n
    .ddr3_dqs_p                     (ddr3_dqs_p),               // inout [0:0] ddr3_dqs_p
    .init_calib_complete            (init_calib_complete),      // output init_calib_complete

    .ddr3_cs_n                      (ddr3_cs_n),                // output [0:0] ddr3_cs_n
    .ddr3_dm                        (ddr3_dm),                  // output [0:0] ddr3_dm
    .ddr3_odt                       (ddr3_odt),                 // output [0:0] ddr3_odt

    // Application interface ports
    .app_addr                       (app_addr),                 // input [29:0] app_addr
    .app_cmd                        (app_cmd),                  // input [2:0] app_cmd
    .app_en                         (app_en),                   // input app_en
    .app_wdf_data                   (app_wdf_data),             // input [31:0] app_wdf_data
    .app_wdf_end                    (app_wdf_end),              // input app_wdf_end
    .app_wdf_wren                   (app_wdf_wren),             // input app_wdf_wren
    .app_rd_data                    (app_rd_data),              // output [31:0] app_rd_data
    .app_rd_data_end                (app_rd_data_end),          // output app_rd_data_end
    .app_rd_data_valid              (app_rd_data_valid),        // output app_rd_data_valid
    .app_rdy                        (app_rdy),                  // output app_rdy
    .app_wdf_rdy                    (app_wdf_rdy),              // output app_wdf_rdy
    .app_sr_req                     (app_sr_req),               // input app_sr_req
    .app_ref_req                    (app_ref_req),              // input app_ref_req
    .app_zq_req                     (app_zq_req),               // input app_zq_req
    .app_sr_active                  (app_sr_active),            // output app_sr_active
    .app_ref_ack                    (app_ref_ack),              // output app_ref_ack
    .app_zq_ack                     (app_zq_ack),               // output app_zq_ack
    .ui_clk                         (ui_clk),                   // output ui_clk
    .ui_clk_sync_rst                (ui_clk_sync_rst),          // output ui_clk_sync_rst
    .app_wdf_mask                   (app_wdf_mask),             // input [3:0] app_wdf_mask

    // System Clock Ports
    .device_temp_i                  (temp_out),
    .sys_clk_i                      (sysclk),                   // input sys_clk_i
    .sys_rst                        (resetn)                    // input sys_rst
    );
    `endif


endmodule

`default_nettype wire

