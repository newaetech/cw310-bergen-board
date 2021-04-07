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
    parameter pADDR_WIDTH = 20,
    parameter pPT_WIDTH = 128,
    parameter pCT_WIDTH = 128,
    parameter pKEY_WIDTH = 128
)(
    // USB Interface
    input wire                          usb_clk,        // Clock
    inout wire [7:0]                    USB_D,          // Data for write/read
    input wire [pADDR_WIDTH-1:0]        USB_A,          // Address
    input wire                          USB_nRD,        // !RD, low when addr valid for read
    input wire                          USB_nWR,        // !WR, low when data+addr valid for write
    input wire                          USB_nCE,        // !CE, active low chip enable
    input wire                          usb_trigger,    // High when trigger requested

    // Buttons/LEDs on Board
    input wire                          USRDIP0,        // DIP switch 0
    input wire                          USRDIP1,        // DIP switch 1
    input wire                          USRSW2,     // Pushbutton SW4, connected to R1, used here as reset
    output wire                         USRLED0,
    output wire                         USRLED1,
    output wire                         USRLED2,

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
    input  wire                         vauxn8

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
    wire [pADDR_WIDTH-pBYTECNT_SIZE-1:0] reg_address;
    wire [pBYTECNT_SIZE-1:0] reg_bytecnt;
    wire reg_addrvalid;
    wire [7:0] write_data;
    wire [7:0] read_data;
    wire reg_read;
    wire reg_write;
    wire [4:0] clk_settings;
    wire crypt_clk;

    wire resetn = USRSW2;
    wire reset = !resetn;


    // USB CLK Heartbeat
    reg [24:0] usb_timer_heartbeat;
    always @(posedge usb_clk_buf) usb_timer_heartbeat <= usb_timer_heartbeat +  25'd1;
    assign USRLED0 = usb_timer_heartbeat[24];

    // CRYPT CLK Heartbeat
    reg [22:0] crypt_clk_heartbeat;
    always @(posedge crypt_clk) crypt_clk_heartbeat <= crypt_clk_heartbeat +  23'd1;
    assign USRLED1 = crypt_clk_heartbeat[22];


    cw310_usb_reg_fe #(
       .pBYTECNT_SIZE           (pBYTECNT_SIZE),
       .pADDR_WIDTH             (pADDR_WIDTH)
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
       .pADDR_WIDTH             (pADDR_WIDTH),
       .pPT_WIDTH               (pPT_WIDTH),
       .pCT_WIDTH               (pCT_WIDTH),
       .pKEY_WIDTH              (pKEY_WIDTH)
    ) U_reg_aes (
       .reset_i                 (reset),
       .crypto_clk              (crypt_clk),
       .usb_clk                 (usb_clk_buf), 
       .reg_address             (reg_address[pADDR_WIDTH-pBYTECNT_SIZE-1:0]), 
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

       .O_user_led              (USRLED2),
       .O_key                   (crypt_key),
       .O_textin                (crypt_textout),
       .O_cipherin              (),                     // unused
       .O_start                 (crypt_start)
    );

    assign USB_D = isout? usb_dout : 8'bZ;

    clocks U_clocks (
       .usb_clk                 (usb_clk),
       .usb_clk_buf             (usb_clk_buf),
       .I_j16_sel               (USRDIP0),
       .I_k16_sel               (USRDIP1),
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


    `ifndef __ICARUS__
        xadc_wiz_0 U_xadc (
          .di_in                (0),                    // input wire [15 : 0] di_in
          .daddr_in             (0),                    // input wire [6 : 0] daddr_in
          .den_in               (0),                    // input wire den_in
          .dwe_in               (0),                    // input wire dwe_in
          .drdy_out             (),                     // output wire drdy_out
          .do_out               (),                     // output wire [15 : 0] do_out
          .dclk_in              (usb_clk_buf),          // input wire dclk_in
          .reset_in             (reset),                // input wire reset_in
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
          .busy_out             ()                      // output wire busy_out
        );
    `endif


endmodule

`default_nettype wire

