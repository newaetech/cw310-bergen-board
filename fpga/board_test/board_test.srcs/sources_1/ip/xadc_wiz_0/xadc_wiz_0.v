
// file: xadc_wiz_0.v
// (c) Copyright 2009 - 2013 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
`timescale 1ns / 1 ps

(* CORE_GENERATION_INFO = "xadc_wiz_0,xadc_wiz_v3_3_8,{component_name=xadc_wiz_0,enable_axi=false,enable_axi4stream=true,dclk_frequency=100,enable_busy=true,enable_convst=false,enable_convstclk=false,enable_dclk=true,enable_drp=true,enable_eoc=true,enable_eos=true,enable_vbram_alaram=true,enable_vccddro_alaram=false,enable_Vccint_Alaram=true,enable_Vccaux_alaram=true,enable_vccpaux_alaram=false,enable_vccpint_alaram=false,ot_alaram=true,user_temp_alaram=true,timing_mode=continuous,channel_averaging=None,sequencer_mode=on,startup_channel_selection=contineous_sequence}" *)


module xadc_wiz_0
   (
    input [6:0] daddr_in,
    input den_in,
    input [15:0] di_in,
    input dwe_in,
    output [15:0] do_out,
    output drdy_out,
  // axi4stream master signals 
    input s_axis_aclk,
    input m_axis_aclk,
    input m_axis_resetn,
    output [15 : 0] m_axis_tdata,
    output m_axis_tvalid,
    output [4 : 0] m_axis_tid,
    input m_axis_tready,
    input vauxp0,                                              
    input vauxn0,                                              
    input vauxp1,                                              
    input vauxn1,                                              
    input vauxp8,                                              
    input vauxn8,                                              
    output [4:0] channel_out,
    output busy_out,        
    output eoc_out, 
    output eos_out,
    output ot_out, 
    output vccaux_alarm_out,
    output vccint_alarm_out,
    output user_temp_alarm_out,
    output vbram_alarm_out,
    output alarm_out ,                                          
    output [11:0]  temp_out,
    input vp_in,                                               
    input vn_in
);

          wire [7:0]  alm_int;
          assign alarm_out = alm_int[7];
          assign vbram_alarm_out = alm_int[3];
          assign vccaux_alarm_out = alm_int[2];
          assign vccint_alarm_out = alm_int[1];
          assign user_temp_alarm_out = alm_int[0];

    xadc_wiz_0_axi_xadc 
    inst 
    (
    .daddr_in        (daddr_in),
    .den_in          (den_in),
    .di_in           (di_in),
    .dwe_in          (dwe_in),
    .do_out          (do_out),
    .drdy_out        (drdy_out),
    .s_axis_aclk     (s_axis_aclk),
    .m_axis_aclk     (m_axis_aclk),
    .m_axis_resetn   (m_axis_resetn),
              
    .m_axis_tdata    (m_axis_tdata),
    .m_axis_tvalid   (m_axis_tvalid),
    .m_axis_tid      (m_axis_tid),
    .m_axis_tready   (m_axis_tready),
    .vauxp0 (vauxp0),
    .vauxn0 (vauxn0),
    .vauxp1 (vauxp1),
    .vauxn1 (vauxn1),
    .vauxp8 (vauxp8),
    .vauxn8 (vauxn8),
    .channel_out(channel_out),
    .busy_out(busy_out), 
    .eoc_out(eoc_out), 
    .eos_out(eos_out),
    .ot_out(ot_out),
    .alarm_out  (alm_int),
    .temp_out    (temp_out),
    .vp_in (vp_in),
    .vn_in (vn_in)

          );


endmodule
