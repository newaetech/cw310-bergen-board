/* 
ChipWhisperer Artix Target - Example of connections between example registers
and rest of system.

Copyright (c) 2020, NewAE Technology Inc.
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

`default_nettype none
`timescale 1ns / 1ps
`include "cw310_defines.v"

module cw310_reg_ddr #(
   parameter pADDR_WIDTH = 21,
   parameter pBYTECNT_SIZE = 7,
   parameter pDONE_EDGE_SENSITIVE = 1
)(

// Interface to cw305_usb_reg_fe:
   input  wire                                  usb_clk,
   input  wire                                  crypto_clk,
   input  wire                                  reset_i,
   input  wire [pADDR_WIDTH-pBYTECNT_SIZE-1:0]  reg_address,     // Address of register
   input  wire [pBYTECNT_SIZE-1:0]              reg_bytecnt,  // Current byte count
   output reg  [7:0]                            read_data,       //
   input  wire [7:0]                            write_data,      //
   input  wire                                  reg_read,        // Read flag. One clock cycle AFTER this flag is high
                                                                 // valid data must be present on the read_data bus
   input  wire                                  reg_write,       // Write flag. When high on rising edge valid data is
                                                                 // present on write_data
   input  wire                                  reg_addrvalid,   // Address valid flag

// from top:
   input  wire                                  exttrigger_in,

// register inputs:
   input  wire [6:0]                            I_ddr3_stat,
   input  wire                                  I_ddr3_pass,
   input  wire                                  I_ddr3_fail,
   input  wire [7:0]                            I_dip,

// register outputs:
   output reg  [4:0]                            O_clksettings,
   output reg                                   O_user_led,

// DDR stuff:
   output reg                                   O_ddr3_en,
   output reg                                   O_xo_en,
   output reg                                   O_vddr_enable,
   input  wire                                  I_vddr_pgood,

   output reg                                   O_ddr3_clear_fail,
   input  wire [15:0]                           I_ddr3_iteration,
   input  wire [7:0]                            I_ddr3_errors,
   input  wire [29:0]                           I_ddr3_error_addr,

   input  wire [31:0]                           I_ddr3_read_read,
   input  wire [31:0]                           I_ddr3_read_idle,
   input  wire [31:0]                           I_ddr3_write_write,
   input  wire [31:0]                           I_ddr3_write_idle,
   input  wire [15:0]                           I_ddr3_max_read_stall_count,
   input  wire [15:0]                           I_ddr3_max_write_stall_count,
   input  wire [31:0]                           I_ddr3_ui_clk_frequency,
   input  wire [31:0]                           I_usb_clk_frequency,
   input  wire [31:0]                           I_sysclk_frequency,

   output reg  [7:0]                            O_leds,
   output reg                                   O_heartbeats

);

   reg  [7:0]                   reg_read_data;

   wire [31:0]                  buildtime;


   //////////////////////////////////
   // read logic:
   //////////////////////////////////

   always @(*) begin
      if (reg_addrvalid && reg_read) begin
         case (reg_address)
            `REG_CLKSETTINGS:           reg_read_data = O_clksettings;
            `REG_USER_LED:              reg_read_data = O_user_led;
            `REG_BUILDTIME:             reg_read_data = buildtime[reg_bytecnt*8 +: 8];
            `REG_DDR3_EN:               reg_read_data = O_ddr3_en;
            `REG_DDR3_PASS:             reg_read_data = {6'b0, I_ddr3_fail, I_ddr3_pass};
            `REG_DDR3_STAT:             reg_read_data = {1'b0, I_ddr3_stat};

            `REG_DDR3_CLEAR_FAIL:       reg_read_data = {7'b0, O_ddr3_clear_fail};
            `REG_DDR3_ITERATIONS:       reg_read_data = I_ddr3_iteration[reg_bytecnt*8 +: 8];
            `REG_DDR3_ERRORS:           reg_read_data = I_ddr3_errors;
            `REG_DDR3_ERROR_ADDR:       reg_read_data = I_ddr3_error_addr[reg_bytecnt*8 +: 8];

            `REG_DIP:                   reg_read_data = I_dip;
            `REG_XO_EN:                 reg_read_data = {6'b0, O_vddr_enable, O_xo_en};
            `REG_LEDS:                  reg_read_data = O_leds;
            `REG_HEARTBEATS:            reg_read_data = O_heartbeats;
            `REG_VDDR_PGOOD:            reg_read_data = I_vddr_pgood;

            `REG_DDR3_READ_READ:        reg_read_data = I_ddr3_read_read[reg_bytecnt*8 +: 8];
            `REG_DDR3_READ_IDLE:        reg_read_data = I_ddr3_read_idle[reg_bytecnt*8 +: 8];
            `REG_DDR3_WRITE_WRITE:      reg_read_data = I_ddr3_write_write[reg_bytecnt*8 +: 8];
            `REG_DDR3_WRITE_IDLE:       reg_read_data = I_ddr3_write_idle[reg_bytecnt*8 +: 8];

            `REG_DDR3_READ_MAX_STALL_COUNT:  reg_read_data = I_ddr3_max_read_stall_count[reg_bytecnt*8 +: 8];
            `REG_DDR3_WRITE_MAX_STALL_COUNT: reg_read_data = I_ddr3_max_write_stall_count[reg_bytecnt*8 +: 8];
            
            `REG_DDR3_UI_CLK_FREQUENCY: reg_read_data = I_ddr3_ui_clk_frequency[reg_bytecnt*8 +: 8];
            `REG_USB_CLK_FREQUENCY:     reg_read_data = I_usb_clk_frequency[reg_bytecnt*8 +: 8];
            `REG_SYS_CLK_FREQUENCY:     reg_read_data = I_sysclk_frequency[reg_bytecnt*8 +: 8];

            default:                    reg_read_data = 0;
         endcase
      end
      else
         reg_read_data = 0;
   end

   // Register output read data to ease timing. If you need read data one clock
   /* cycle earlier, simply remove this stage:
   always @(posedge usb_clk)
      read_data <= reg_read_data;
   */

   always @(*)
      read_data = reg_read_data;

   //////////////////////////////////
   // write logic (USB clock domain):
   //////////////////////////////////
   always @(posedge usb_clk) begin
      if (reset_i) begin
         O_clksettings <= 0;
         O_user_led <= 0;
         O_ddr3_en <= 0;
         O_xo_en <= 1;
         O_vddr_enable <= 0;
         O_leds <= 8'hFF;
         O_heartbeats <= 0;
         O_ddr3_clear_fail <= 1'b0;
      end

      else begin
         if (reg_addrvalid && reg_write) begin
            case (reg_address)
               `REG_CLKSETTINGS:        O_clksettings <= write_data;
               `REG_USER_LED:           O_user_led <= write_data;
               `REG_DDR3_EN:            O_ddr3_en <= write_data[0];
               `REG_XO_EN:              {O_vddr_enable, O_xo_en} <= write_data[1:0];
               `REG_LEDS:               O_leds <= write_data;
               `REG_HEARTBEATS:         O_heartbeats <= write_data[0];
               `REG_DDR3_CLEAR_FAIL:    O_ddr3_clear_fail <= write_data[0];
            endcase
         end

      end
   end



   `ifdef ILA_REG
       ila_reg U_reg_ila (
	.clk            (usb_clk),                      // input wire clk
	.probe0         (reg_address),                  // input wire [19:0] probe1
	.probe1         (reg_bytecnt),                  // input wire [6:0]  probe1 
	.probe2         (read_data),                    // input wire [7:0]  probe2 
	.probe3         (write_data),                   // input wire [7:0]  probe3 
	.probe4         (reg_read),                     // input wire [0:0]  probe4 
	.probe5         (reg_write),                    // input wire [0:0]  probe5 
	.probe6         (reg_addrvalid),                // input wire [0:0]  probe6 
	.probe7         (reg_read_data),                // input wire [7:0]  probe7 
	.probe8         (exttrigger_in),                // input wire [0:0]  probe8 
	.probe9         (reset_i),                      // input wire [0:0]  probe9
	.probe10        (1'b0),                         // input wire [0:0]  probe10
	.probe11        (128'b0)                       // input wire [127:0]  probe11
       );
   `endif

   `ifndef __ICARUS__
      USR_ACCESSE2 U_buildtime (
         .CFGCLK(),
         .DATA(buildtime),
         .DATAVALID()
      );
   `else
      assign buildtime = 0;
   `endif


endmodule

`default_nettype wire
