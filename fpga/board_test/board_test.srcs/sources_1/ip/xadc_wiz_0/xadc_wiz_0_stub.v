// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2026.1 (lin64) Build 6511674 Tue Jun 16 11:01:26 MDT 2026
// Date        : Thu Nov  5 16:28:21 2026
// Host        : red running 64-bit Ubuntu 24.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/jpnewae/git/cw310-bergen-board/fpga/board_test/board_test.srcs/sources_1/ip/xadc_wiz_0/xadc_wiz_0_stub.v
// Design      : xadc_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k160tfbg676-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CORE_GENERATION_INFO = "xadc_wiz_0,xadc_wiz_v3_3_15,{component_name=xadc_wiz_0,enable_axi=false,enable_axi4stream=true,dclk_frequency=100,enable_busy=true,enable_convst=false,enable_convstclk=false,enable_dclk=true,enable_drp=true,enable_eoc=true,enable_eos=true,enable_vbram_alaram=true,enable_vccddro_alaram=false,enable_Vccint_Alaram=true,enable_Vccaux_alaram=true,enable_vccpaux_alaram=false,enable_vccpint_alaram=false,ot_alaram=true,user_temp_alaram=true,timing_mode=continuous,channel_averaging=None,sequencer_mode=on,startup_channel_selection=contineous_sequence}" *) 
module xadc_wiz_0(daddr_in, den_in, di_in, dwe_in, do_out, drdy_out, 
  s_axis_aclk, m_axis_aclk, m_axis_resetn, m_axis_tdata, m_axis_tvalid, m_axis_tid, 
  m_axis_tready, vauxp0, vauxn0, vauxp1, vauxn1, vauxp8, vauxn8, channel_out, busy_out, eoc_out, 
  eos_out, ot_out, vccaux_alarm_out, vccint_alarm_out, user_temp_alarm_out, vbram_alarm_out, 
  alarm_out, temp_out, vp_in, vn_in)
/* synthesis syn_black_box black_box_pad_pin="daddr_in[6:0],den_in,di_in[15:0],dwe_in,do_out[15:0],drdy_out,m_axis_resetn,m_axis_tdata[15:0],m_axis_tvalid,m_axis_tid[4:0],m_axis_tready,vauxp0,vauxn0,vauxp1,vauxn1,vauxp8,vauxn8,channel_out[4:0],busy_out,eoc_out,eos_out,ot_out,vccaux_alarm_out,vccint_alarm_out,user_temp_alarm_out,vbram_alarm_out,alarm_out,temp_out[11:0],vp_in,vn_in" */
/* synthesis syn_force_seq_prim="s_axis_aclk" */
/* synthesis syn_force_seq_prim="m_axis_aclk" */;
  input [6:0]daddr_in;
  input den_in;
  input [15:0]di_in;
  input dwe_in;
  output [15:0]do_out;
  output drdy_out;
  input s_axis_aclk /* synthesis syn_isclock = 1 */;
  input m_axis_aclk /* synthesis syn_isclock = 1 */;
  input m_axis_resetn;
  output [15:0]m_axis_tdata;
  output m_axis_tvalid;
  output [4:0]m_axis_tid;
  input m_axis_tready;
  input vauxp0;
  input vauxn0;
  input vauxp1;
  input vauxn1;
  input vauxp8;
  input vauxn8;
  output [4:0]channel_out;
  output busy_out;
  output eoc_out;
  output eos_out;
  output ot_out;
  output vccaux_alarm_out;
  output vccint_alarm_out;
  output user_temp_alarm_out;
  output vbram_alarm_out;
  output alarm_out;
  output [11:0]temp_out;
  input vp_in;
  input vn_in;
endmodule
