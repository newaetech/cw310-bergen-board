// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Tue Jul 26 19:36:19 2022
// Host        : red running 64-bit Ubuntu 18.04.6 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/jpnewae/git/bergen/cw310-bergen-board/fpga/ddr_test/ddr_test.srcs/sources_1/ip/ila_simple_ddr3/ila_simple_ddr3_stub.v
// Design      : ila_simple_ddr3
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k160tfbg676-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2020.2" *)
module ila_simple_ddr3(clk, probe0, probe1, probe2, probe3, probe4, probe5, 
  probe6, probe7, probe8, probe9, probe10, probe11, probe12, probe13, probe14, probe15, probe16, probe17, 
  probe18, probe19, probe20, probe21, probe22, probe23, probe24, probe25, probe26, probe27)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[0:0],probe1[0:0],probe2[0:0],probe3[0:0],probe4[29:0],probe5[2:0],probe6[0:0],probe7[31:0],probe8[0:0],probe9[0:0],probe10[0:0],probe11[31:0],probe12[0:0],probe13[0:0],probe14[0:0],probe15[0:0],probe16[3:0],probe17[0:0],probe18[15:0],probe19[0:0],probe20[0:0],probe21[0:0],probe22[0:0],probe23[31:0],probe24[29:0],probe25[31:0],probe26[0:0],probe27[0:0]" */;
  input clk;
  input [0:0]probe0;
  input [0:0]probe1;
  input [0:0]probe2;
  input [0:0]probe3;
  input [29:0]probe4;
  input [2:0]probe5;
  input [0:0]probe6;
  input [31:0]probe7;
  input [0:0]probe8;
  input [0:0]probe9;
  input [0:0]probe10;
  input [31:0]probe11;
  input [0:0]probe12;
  input [0:0]probe13;
  input [0:0]probe14;
  input [0:0]probe15;
  input [3:0]probe16;
  input [0:0]probe17;
  input [15:0]probe18;
  input [0:0]probe19;
  input [0:0]probe20;
  input [0:0]probe21;
  input [0:0]probe22;
  input [31:0]probe23;
  input [29:0]probe24;
  input [31:0]probe25;
  input [0:0]probe26;
  input [0:0]probe27;
endmodule
