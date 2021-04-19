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

`timescale 1ns / 1ps
`default_nettype none 


module simple_ddr3_rwtest #(
   parameter pDATA_WIDTH = 256,
   parameter pADDR_WIDTH = 15,
   parameter pMASK_WIDTH = 32
)(
   input wire                           clk,
   input wire                           reset,
   input wire                           active,
   input wire                           init_calib_complete,
   output reg                           pass,
   output reg                           fail,

   output reg  [pADDR_WIDTH-1:0]        app_addr,
   output reg  [2:0]                    app_cmd,
   output reg                           app_en,
   output reg  [pDATA_WIDTH-1:0]        app_wdf_data,
   output wire                          app_wdf_end,
   output reg                           app_wdf_wren,
   output wire                          app_sr_req,
   output wire                          app_ref_req,
   output wire                          app_zq_req,
   output wire [pMASK_WIDTH-1:0]        app_wdf_mask,

   input  wire                          app_sr_active,
   input  wire                          app_ref_ack,
   input  wire                          app_zq_ack,
   input  wire [pDATA_WIDTH-1:0]        app_rd_data,
   input  wire                          app_rd_data_end,
   input  wire                          app_rd_data_valid,
   input  wire                          app_rdy,
   input  wire                          app_wdf_rdy
);



 /*
 reg [pDATA_WIDTH-1:0] data_to_write = {32'hcafebabe, 32'h12345678,
                                        32'h87654321, 32'haabbccdd,
                                        32'hffeeddcc, 32'habcdddef,
                                        32'hAA55AA55, 32'h55AA55AA};
 */
 reg [pDATA_WIDTH-1:0] data_to_write = 32'h12345678;


 reg [pDATA_WIDTH-1:0] data_read_from_memory = 0;

 localparam IDLE = 3'd0;
 localparam WRITE = 3'd1;
 localparam WRITE_DONE = 3'd2;
 localparam READ = 3'd3;
 localparam READ_DONE = 3'd4;
 localparam CHECK = 3'd5;
 reg [2:0] state = IDLE;

 localparam CMD_WRITE = 3'b000;
 localparam CMD_READ = 3'b001;

 assign app_sr_req = 0;
 assign app_ref_req = 0;
 assign app_zq_req = 0;
 assign app_wdf_mask = 0;
 assign app_wdf_end = 1;

reg [7:0] index;
//reg [63:0] iteration;
reg [15:0] iteration;

always @ (posedge clk) begin
  if (reset) begin
    state <= IDLE;
    app_en <= 0;
    app_wdf_wren <= 0;
    index <= 0;
    iteration <= 0;
    pass <= 0;
    fail <= 0;
  end else begin
    case (state)
      IDLE: begin
        index <= 0;
        if (init_calib_complete && active) begin
          state <= WRITE;
        end
      end

      WRITE: begin
        if (app_rdy & app_wdf_rdy) begin
          state <= WRITE_DONE;
          app_en <= 1;
          app_wdf_wren <= 1;
          app_addr <= index << 8;
          app_cmd <= CMD_WRITE;
          //app_wdf_data <= data_to_write + (index << 128) + iteration;
          app_wdf_data <= data_to_write + index + iteration;
        end
      end

      WRITE_DONE: begin
        if (app_rdy & app_en) begin
          app_en <= 0;
        end

        if (app_wdf_rdy & app_wdf_wren) begin
          app_wdf_wren <= 0;
        end

        if (~app_en & ~app_wdf_wren) begin
          //if (index == 3) begin
          if (index == 63) begin
             index <= 0;
             state <= READ;
          end
          else begin
             index <= index + 1;
             state <= WRITE;
          end
        end
      end

      READ: begin
        if (app_rdy) begin
          app_en <= 1;
          app_addr <= index << 8;
          app_cmd <= CMD_READ;
          state <= READ_DONE;
        end
      end

      READ_DONE: begin
        if (app_rdy & app_en) begin
          app_en <= 0;
        end

        if (app_rd_data_valid) begin
          data_read_from_memory <= app_rd_data;
          state <= CHECK;
        end
      end

      CHECK: begin
        //if ((data_to_write + (index << 128) + iteration) == data_read_from_memory) begin
        if ((data_to_write + index + iteration) == data_read_from_memory) begin
          pass <= 1;
        end else if (data_to_write != data_read_from_memory) begin
          pass <= 0;
          fail <= 1;
        end
        //if (index == 3) begin
        if (index == 63) begin
           index <= 0;
           iteration <= iteration + 1;
           state <= WRITE;
        end
        else begin
           index <= index + 1;
           state <= READ;
        end

      end

      default: state <= IDLE;
   endcase
 end
end


`ifndef __ICARUS__
ila_1 U_simple_ddr3_rwtest_ila (
	.clk(clk), // input wire clk

	.probe0         (active             ),      // input wire [0:0]  probe0  
	.probe1         (init_calib_complete),      // input wire [0:0]  probe1 
	.probe2         (pass               ),      // input wire [0:0]  probe2 
	.probe3         (fail               ),      // input wire [0:0]  probe3 
	.probe4         (app_addr[14:0]     ),      // input wire [14:0]  probe4 
	.probe5         (app_cmd            ),      // input wire [2:0]  probe5 
	.probe6         (app_en             ),      // input wire [0:0]  probe6 
	.probe7         (app_wdf_data       ),      // input wire [255:0]  probe7 
	.probe8         (app_wdf_end        ),      // input wire [0:0]  probe8 
	.probe9         (app_wdf_wren       ),      // input wire [0:0]  probe9 
	.probe10        (app_sr_req         ),      // input wire [0:0]  probe10 
	.probe11        (app_ref_req        ),      // input wire [0:0]  probe11 
	.probe12        (app_zq_req         ),      // input wire [0:0]  probe12 
	.probe13        (app_wdf_mask       ),      // input wire [31:0]  probe13 
	.probe14        (app_sr_active      ),      // input wire [0:0]  probe14 
	.probe15        (app_ref_ack        ),      // input wire [0:0]  probe15 
	.probe16        (app_zq_ack         ),      // input wire [0:0]  probe16 
	.probe17        (app_rd_data        ),      // input wire [255:0]  probe17 
	.probe18        (app_rd_data_end    ),      // input wire [0:0]  probe18 
	.probe19        (app_rd_data_valid  ),      // input wire [0:0]  probe19 
	.probe20        (app_rdy            ),      // input wire [0:0]  probe20 
	.probe21        (app_wdf_rdy        ),      // input wire [0:0]  probe21
	.probe22        (state              ),      // input wire [2:0]  probe22
	.probe23        (index[1:0]         ),      // input wire [1:0]  probe23
	//.probe24        (iteration          )       // input wire [63:0] probe24
	.probe24        ({48'b0, iteration} )       // input wire [63:0] probe24
);
`endif

endmodule

`default_nettype wire

