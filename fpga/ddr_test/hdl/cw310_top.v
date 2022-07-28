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
    parameter pUSB_ADDR_WIDTH = 20
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
    output reg  [7:0]                   USRLED,

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

    // DDR
    `ifndef NOMIG
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
    `endif

    input  wire                         SYSCLK_P,
    input  wire                         SYSCLK_N,

    output wire                         LVDS_XO_200M_ENA,
    output wire                         vddr_enable,
    input  wire                         vddr_pgood
    );


    wire usb_clk_buf;
    wire [7:0] usb_dout;
    wire isout;
    wire [pUSB_ADDR_WIDTH-pBYTECNT_SIZE-1:0] reg_address;
    wire [pBYTECNT_SIZE-1:0] reg_bytecnt;
    wire reg_addrvalid;
    wire [7:0] write_data;
    wire [7:0] read_data;
    wire [7:0] read_data_ddr;
    wire [7:0] read_data_xadc;
    wire reg_read;
    wire reg_write;
    wire [4:0] clk_settings;
    wire crypt_clk;

    wire [7:0] reg_leds;
    wire heartbeats;
    wire ddr3_pass;
    wire ddr3_fail;
    wire ddr3_en;

    wire init_calib_complete;

    wire [11:0] temp_out;

    wire resetn = USRSW2;
    wire reset = !resetn;

    wire         ddr3_clear_fail;
    wire [15:0]  ddr3_iteration;
    wire [7:0]   ddr3_errors;
    wire [29:0]  ddr3_error_addr;

    wire [31:0]  ddr_read_read;
    wire [31:0]  ddr_read_idle;
    wire [31:0]  ddr_write_write;
    wire [31:0]  ddr_write_idle;
    wire [15:0]  ddr_max_read_stall_count;
    wire [15:0]  ddr_max_write_stall_count;

    // USB CLK Heartbeat
    reg [24:0] usb_timer_heartbeat;
    always @(posedge usb_clk_buf) usb_timer_heartbeat <= usb_timer_heartbeat +  25'd1;

    // CRYPT CLK Heartbeat
    reg [22:0] crypt_clk_heartbeat;
    always @(posedge crypt_clk) crypt_clk_heartbeat <= crypt_clk_heartbeat +  23'd1;

    wire  dbg_pi_phaselock_err;
    wire  dbg_pi_dqsfound_err;
    wire  dbg_wrlvl_err;
    wire [1:0] dbg_rdlvl_err;
    wire  dbg_wrcal_err;
    wire [6:0] ddr3_stat;

    always @(*) begin
        if (ddr3_en) begin
            USRLED[0] = init_calib_complete;
            USRLED[1] = ddr3_fail;
            USRLED[2] = ddr3_pass;
            USRLED[3] = ~dbg_pi_phaselock_err;
            USRLED[4] = ~dbg_pi_dqsfound_err;
            USRLED[5] = ~dbg_wrlvl_err;
            USRLED[6] = ~dbg_rdlvl_err[1];
            USRLED[7] = ~dbg_wrcal_err;
            //USRLED[7] = ~dbg_rdlvl_err[0];
        end
        else if (heartbeats)
            USRLED = {6'b0, crypt_clk_heartbeat[22], usb_timer_heartbeat[24]};
        else
            USRLED = reg_leds;
    end

    assign dbg_pi_phaselock_err = ddr3_ila_basic_w[6];
    assign dbg_pi_dqsfound_err  = ddr3_ila_basic_w[9];
    assign dbg_wrlvl_err        = ddr3_ila_basic_w[3];
    assign dbg_rdlvl_err        = ddr3_ila_basic_w[15:14];
    assign dbg_wrcal_err        = ddr3_ila_basic_w[21];

    assign ddr3_stat = {dbg_pi_phaselock_err,
                        dbg_pi_dqsfound_err,
                        dbg_wrlvl_err,
                        dbg_rdlvl_err,
                        dbg_wrcal_err,
                        init_calib_complete
                       };

    assign read_data = read_data_ddr | read_data_xadc;


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


    cw310_reg_ddr #(
       .pBYTECNT_SIZE           (pBYTECNT_SIZE),
       .pADDR_WIDTH             (pUSB_ADDR_WIDTH)
    ) U_reg_ddr (
       .reset_i                 (reset),
       .crypto_clk              (crypt_clk),
       .usb_clk                 (usb_clk_buf), 
       .reg_address             (reg_address[pUSB_ADDR_WIDTH-pBYTECNT_SIZE-1:0]), 
       .reg_bytecnt             (reg_bytecnt), 
       .read_data               (read_data_ddr), 
       .write_data              (write_data),
       .reg_read                (reg_read), 
       .reg_write               (reg_write), 
       .reg_addrvalid           (reg_addrvalid),

       .exttrigger_in           (usb_trigger),

       .I_ddr3_pass             (ddr3_pass),
       .I_ddr3_fail             (ddr3_fail),
       .I_ddr3_stat             (ddr3_stat),
       .I_dip                   (USRDIP),

       .O_user_led              (),

       .O_ddr3_en               (ddr3_en),
       .O_xo_en                 (LVDS_XO_200M_ENA),
       .O_vddr_enable           (vddr_enable),
       .I_vddr_pgood            (vddr_pgood),

       .O_ddr3_clear_fail       (ddr3_clear_fail ),
       .I_ddr3_iteration        (ddr3_iteration  ),
       .I_ddr3_errors           (ddr3_errors     ),
       .I_ddr3_error_addr       (ddr3_error_addr ),

       .I_ddr3_read_read        (ddr_read_read       ),
       .I_ddr3_read_idle        (ddr_read_idle       ),
       .I_ddr3_write_write      (ddr_write_write     ),
       .I_ddr3_write_idle       (ddr_write_idle      ),
       .I_ddr3_max_read_stall_count  (ddr_max_read_stall_count ),
       .I_ddr3_max_write_stall_count (ddr_max_write_stall_count),

       .I_ddr3_ui_clk_frequency (ui_frequency),
       .I_usb_clk_frequency     (usb_frequency),
       .I_sysclk_frequency      (sysclk_frequency),

       .O_leds                  (reg_leds),
       .O_heartbeats            (heartbeats)
    );

    xadc #(
       .pBYTECNT_SIZE           (pBYTECNT_SIZE),
       .pADDR_WIDTH             (pUSB_ADDR_WIDTH)
    ) U_xadc (
       .reset_i                 (reset),
       .clk_usb                 (usb_clk_buf), 
       .reg_address             (reg_address[pUSB_ADDR_WIDTH-pBYTECNT_SIZE-1:0]), 
       .reg_bytecnt             (reg_bytecnt), 
       .reg_datao               (read_data_xadc), 
       .reg_datai               (write_data),
       .reg_read                (reg_read), 
       .reg_write               (reg_write), 

       .vauxp0                  (vauxp0),
       .vauxn0                  (vauxn0),
       .vauxp1                  (vauxp1),
       .vauxn1                  (vauxn1),
       .vauxp8                  (vauxp8),
       .vauxn8                  (vauxn8),
       .O_xadc_temp_out         (temp_out),
       .xadc_error              ()
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


   // TODO assign CWIO_IO4 = ;


   //Divide clock by 2^24 for heartbeat LED
   //Divide clock by 2^23 for frequency measurement
   reg [24:0] timer_heartbeat;
   reg freq_measure;
   reg timer_heartbeat22r;
   reg [31:0] ui_frequency;
   reg [31:0] ui_frequency_int;
   reg [31:0] usb_frequency;
   reg [31:0] usb_frequency_int;
   reg [31:0] sysclk_frequency;
   reg [31:0] sysclk_frequency_int;

   wire sysclk;

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

   wire freq_measure_ui;
   cdc_pulse U_freq_measure_ui (
      .reset_i       (reset),
      .src_clk       (usb_clk_buf),
      .src_pulse     (freq_measure),
      .dst_clk       (ui_clk),
      .dst_pulse     (freq_measure_ui)
   );

  always @(posedge ui_clk) begin
      if (freq_measure_ui) begin
         ui_frequency_int <= 32'd1;
         ui_frequency <= ui_frequency_int;
      end 
      else begin
         ui_frequency_int <= ui_frequency_int + 32'd1;
      end
   end

  always @(posedge usb_clk_buf) begin
      if (freq_measure) begin
         usb_frequency_int <= 32'd1;
         usb_frequency <= usb_frequency_int;
      end 
      else begin
         usb_frequency_int <= usb_frequency_int + 32'd1;
      end
   end




   // application interface to DDR3:
   wire [29:0]  app_addr;
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

   wire [255:0] ddr3_ila_basic_w;

   simple_ddr3_rwtest #(
      .pDATA_WIDTH                         (32),
      .pADDR_WIDTH                         (30),
      .pMASK_WIDTH                         (4)
   ) U_simple_ddr3_rwtest (
      .clk                                 (ui_clk              ),
      .reset                               (reset               ),
      .active_usb                          (ddr3_en             ),
      .init_calib_complete                 (init_calib_complete ),
      .pass                                (ddr3_pass           ),
      .fail                                (ddr3_fail           ),
      .clear_fail                          (ddr3_clear_fail     ),

      .iteration                           (ddr3_iteration      ),
      .errors                              (ddr3_errors         ),
      .error_addr                          (ddr3_error_addr     ),
      .ddrtest_incr                        (8'd8                ),
      .ddrtest_stop                        (32'h1FFF_FFF8       ),

      .ddr_read_read                       (ddr_read_read       ),
      .ddr_read_idle                       (ddr_read_idle       ),
      .ddr_write_write                     (ddr_write_write     ),
      .ddr_write_idle                      (ddr_write_idle      ),
      .ddr_max_read_stall_count            (ddr_max_read_stall_count ),
      .ddr_max_write_stall_count           (ddr_max_write_stall_count),

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

`ifdef NOMIG
    // omit MIG block so we can measure the SYSCLK_P/N frequency:
   `ifdef __ICARUS__
      assign sysclk = usb_clk_buf;

   `else
      wire sysclk_prebuf;
      IBUFDS #(
         .DIFF_TERM        ("FALSE"),
         .IBUF_LOW_PWR     ("FALSE"),
         .IOSTANDARD       ("LVDS_25")
      ) U_IBUFDS_adc_clk_fb (
         .I                (SYSCLK_P),
         .IB               (SYSCLK_N),
         .O                (sysclk_prebuf)
      );

      BUFG BUFG_adc_clk (
         .O(sysclk),
         .I(sysclk_prebuf)
      );

   `endif

   wire freq_measure_sysclk;
   cdc_pulse U_freq_measure_sysclk (
      .reset_i       (reset),
      .src_clk       (usb_clk_buf),
      .src_pulse     (freq_measure),
      .dst_clk       (sysclk),
      .dst_pulse     (freq_measure_sysclk)
   );

  always @(posedge sysclk) begin
      if (freq_measure_sysclk) begin
         sysclk_frequency_int <= 32'd1;
         sysclk_frequency <= sysclk_frequency_int;
      end 
      else begin
         sysclk_frequency_int <= sysclk_frequency_int + 32'd1;
      end
   end



`else
`ifndef __ICARUS__

  mig_7series_nosysclock u_mig_7series_nosysclock
      (
// Memory interface ports
       .ddr3_addr                      (ddr3_addr),
       .ddr3_ba                        (ddr3_ba),
       .ddr3_cas_n                     (ddr3_cas_n),
       .ddr3_ck_n                      (ddr3_ck_n),
       .ddr3_ck_p                      (ddr3_ck_p),
       .ddr3_cke                       (ddr3_cke),
       .ddr3_ras_n                     (ddr3_ras_n),
       .ddr3_we_n                      (ddr3_we_n),
       .ddr3_dq                        (ddr3_dq),
       .ddr3_dqs_n                     (ddr3_dqs_n),
       .ddr3_dqs_p                     (ddr3_dqs_p),
       .ddr3_reset_n                   (ddr3_reset_n),
       .init_calib_complete            (init_calib_complete),
       .ddr3_cs_n                      (ddr3_cs_n),
       .ddr3_dm                        (ddr3_dm),
       .ddr3_odt                       (ddr3_odt),
// Application interface ports
       .app_addr                       (app_addr),
       .app_cmd                        (app_cmd),
       .app_en                         (app_en),
       .app_wdf_data                   (app_wdf_data),
       .app_wdf_end                    (app_wdf_end),
       .app_wdf_wren                   (app_wdf_wren),
       .app_rd_data                    (app_rd_data),
       .app_rd_data_end                (app_rd_data_end),
       .app_rd_data_valid              (app_rd_data_valid),
       .app_rdy                        (app_rdy),
       .app_wdf_rdy                    (app_wdf_rdy),
       .app_sr_req                     (1'b0),
       .app_ref_req                    (1'b0),
       .app_zq_req                     (1'b0),
       .app_sr_active                  (app_sr_active),
       .app_ref_ack                    (app_ref_ack),
       .app_zq_ack                     (app_zq_ack),
       .ui_clk                         (ui_clk),
       .ui_clk_sync_rst                (ui_clk_sync_rst),
       .app_wdf_mask                   (app_wdf_mask),
// Debug Ports
// these can be omitted if you wish -- regenerate the MIG with debug disabled
       .ddr3_ila_basic                 (ddr3_ila_basic_w[119:0]),
       .ddr3_ila_wrpath                (),
       .ddr3_ila_rdpath                (),
       .dbg_pi_counter_read_val        (),
       .dbg_po_counter_read_val        (),
       .dbg_prbs_final_dqs_tap_cnt_r   (),
       .dbg_prbs_first_edge_taps       (),
       .dbg_prbs_second_edge_taps      (),
       // debug inputs, connect to rest of debug infrastructure if present:
       /*
       .dbg_pi_f_inc                   (dbg_pi_f_inc),
       .dbg_pi_f_dec                   (dbg_pi_f_dec),
       .dbg_po_f_inc                   (dbg_po_f_inc),
       .dbg_po_f_stg23_sel             (dbg_po_f_stg23_sel),
       .dbg_po_f_dec                   (dbg_po_f_dec),
       .ddr3_vio_sync_out              ({dbg_dqs,dbg_bit}),
       .dbg_sel_pi_incdec              (dbg_sel_pi_incdec),
       .dbg_sel_po_incdec              (dbg_sel_po_incdec),
       .dbg_byte_sel                   (dbg_byte_sel_r),
       */
       // otherwise:
       .dbg_pi_f_inc                   (1'b0),
       .dbg_pi_f_dec                   (1'b0),
       .dbg_po_f_inc                   (1'b0),
       .dbg_po_f_stg23_sel             (1'b0),
       .dbg_po_f_dec                   (1'b0),
       .ddr3_vio_sync_out              (14'b0),
       .dbg_sel_pi_incdec              (1'b0),
       .dbg_sel_po_incdec              (1'b0),
       .dbg_byte_sel                   (2'b0),

// System Clock Ports
       .sys_clk_p                      (SYSCLK_P),
       .sys_clk_n                      (SYSCLK_N),
       .device_temp_i                  (temp_out),
       `ifdef SKIP_CALIB
       .calib_tap_req                  (calib_tap_req),
       .calib_tap_load                 (calib_tap_load),
       .calib_tap_addr                 (calib_tap_addr),
       .calib_tap_val                  (calib_tap_val),
       .calib_tap_load_done            (calib_tap_load_done),
       `endif
       .sys_rst                        (resetn)
       );

`endif
`endif


endmodule

`default_nettype wire

