// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Wed Apr 21 14:56:17 2021
// Host        : qed running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/jp/GitHub/OpenTitan/cw310-bergen-board/fpga/board_test/board_test.srcs/sources_1/ip/xadc_wiz_0/xadc_wiz_0_sim_netlist.v
// Design      : xadc_wiz_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k160tfbg676-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* NotValidForBitStream *)
module xadc_wiz_0
   (daddr_in,
    den_in,
    di_in,
    dwe_in,
    do_out,
    drdy_out,
    s_axis_aclk,
    m_axis_aclk,
    m_axis_resetn,
    m_axis_tdata,
    m_axis_tvalid,
    m_axis_tid,
    m_axis_tready,
    vauxp0,
    vauxn0,
    vauxp1,
    vauxn1,
    vauxp8,
    vauxn8,
    channel_out,
    busy_out,
    eoc_out,
    eos_out,
    ot_out,
    vccaux_alarm_out,
    vccint_alarm_out,
    user_temp_alarm_out,
    vbram_alarm_out,
    alarm_out,
    temp_out,
    vp_in,
    vn_in);
  input [6:0]daddr_in;
  input den_in;
  input [15:0]di_in;
  input dwe_in;
  output [15:0]do_out;
  output drdy_out;
  input s_axis_aclk;
  input m_axis_aclk;
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

  wire alarm_out;
  wire busy_out;
  wire [4:0]channel_out;
  wire [6:0]daddr_in;
  wire den_in;
  wire [15:0]di_in;
  wire [15:0]do_out;
  wire drdy_out;
  wire dwe_in;
  wire eoc_out;
  wire eos_out;
  wire m_axis_aclk;
  wire m_axis_resetn;
  wire [15:0]m_axis_tdata;
  wire [4:0]m_axis_tid;
  wire m_axis_tready;
  wire m_axis_tvalid;
  wire ot_out;
  wire s_axis_aclk;
  wire [11:0]temp_out;
  wire user_temp_alarm_out;
  wire vauxn0;
  wire vauxn1;
  wire vauxn8;
  wire vauxp0;
  wire vauxp1;
  wire vauxp8;
  wire vbram_alarm_out;
  wire vccaux_alarm_out;
  wire vccint_alarm_out;
  wire vn_in;
  wire vp_in;
  wire [6:4]NLW_inst_alarm_out_UNCONNECTED;

  xadc_wiz_0_xadc_wiz_0_axi_xadc inst
       (.alarm_out({alarm_out,NLW_inst_alarm_out_UNCONNECTED[6:4],vbram_alarm_out,vccaux_alarm_out,vccint_alarm_out,user_temp_alarm_out}),
        .busy_out(busy_out),
        .channel_out(channel_out),
        .daddr_in(daddr_in),
        .den_in(den_in),
        .di_in(di_in),
        .do_out(do_out),
        .drdy_out(drdy_out),
        .dwe_in(dwe_in),
        .eoc_out(eoc_out),
        .eos_out(eos_out),
        .m_axis_aclk(m_axis_aclk),
        .m_axis_resetn(m_axis_resetn),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tid(m_axis_tid),
        .m_axis_tready(m_axis_tready),
        .m_axis_tvalid(m_axis_tvalid),
        .ot_out(ot_out),
        .s_axis_aclk(s_axis_aclk),
        .temp_out(temp_out),
        .vauxn0(vauxn0),
        .vauxn1(vauxn1),
        .vauxn8(vauxn8),
        .vauxp0(vauxp0),
        .vauxp1(vauxp1),
        .vauxp8(vauxp8),
        .vn_in(vn_in),
        .vp_in(vp_in));
endmodule

(* ORIG_REF_NAME = "drp_arbiter" *) 
module xadc_wiz_0_drp_arbiter
   (m_axis_reset,
    den_C,
    dwe_C,
    overlap_B_reg_0,
    drdy_i,
    drdy_out,
    wren_fifo,
    \do_A_reg_reg[14]_0 ,
    Q,
    \FSM_sequential_state_reg[0]_0 ,
    \do_A_reg_reg[15]_0 ,
    state__0,
    do_out,
    \daddr_C_reg_reg[6]_0 ,
    \di_C_reg_reg[15]_0 ,
    m_axis_aclk,
    den_reg,
    \m_axis_tdata[15] ,
    m_axis_resetn,
    \FSM_sequential_state_reg[3] ,
    mode_change,
    \FSM_sequential_state_reg[3]_0 ,
    \FSM_sequential_state_reg[3]_1 ,
    eoc_out,
    channel_out,
    di_in,
    daddr_in,
    \daddr_C_reg_reg[6]_1 ,
    dwe_in,
    drdy_C,
    bbusy_A,
    den_A,
    den_in,
    jtaglocked_i,
    DO,
    overlap_A,
    \FSM_sequential_state_reg[0]_1 );
  output m_axis_reset;
  output den_C;
  output dwe_C;
  output overlap_B_reg_0;
  output drdy_i;
  output drdy_out;
  output wren_fifo;
  output \do_A_reg_reg[14]_0 ;
  output [15:0]Q;
  output \FSM_sequential_state_reg[0]_0 ;
  output \do_A_reg_reg[15]_0 ;
  output [1:0]state__0;
  output [15:0]do_out;
  output [6:0]\daddr_C_reg_reg[6]_0 ;
  output [15:0]\di_C_reg_reg[15]_0 ;
  input m_axis_aclk;
  input den_reg;
  input \m_axis_tdata[15] ;
  input m_axis_resetn;
  input \FSM_sequential_state_reg[3] ;
  input mode_change;
  input [0:0]\FSM_sequential_state_reg[3]_0 ;
  input \FSM_sequential_state_reg[3]_1 ;
  input eoc_out;
  input [0:0]channel_out;
  input [15:0]di_in;
  input [6:0]daddr_in;
  input [5:0]\daddr_C_reg_reg[6]_1 ;
  input dwe_in;
  input drdy_C;
  input bbusy_A;
  input den_A;
  input den_in;
  input jtaglocked_i;
  input [15:0]DO;
  input overlap_A;
  input \FSM_sequential_state_reg[0]_1 ;

  wire [15:0]DO;
  wire \FSM_sequential_state[0]_i_1_n_0 ;
  wire \FSM_sequential_state[0]_i_2__0_n_0 ;
  wire \FSM_sequential_state[1]_i_1_n_0 ;
  wire \FSM_sequential_state[1]_i_2__0_n_0 ;
  wire \FSM_sequential_state[1]_i_3_n_0 ;
  wire \FSM_sequential_state[1]_i_4_n_0 ;
  wire \FSM_sequential_state[1]_i_5_n_0 ;
  wire \FSM_sequential_state_reg[0]_0 ;
  wire \FSM_sequential_state_reg[0]_1 ;
  wire \FSM_sequential_state_reg[3] ;
  wire [0:0]\FSM_sequential_state_reg[3]_0 ;
  wire \FSM_sequential_state_reg[3]_1 ;
  wire [15:0]Q;
  wire bbusy_A;
  wire [0:0]channel_out;
  wire [6:0]daddr_C_reg0_in;
  wire \daddr_C_reg[6]_i_10_n_0 ;
  wire \daddr_C_reg[6]_i_1_n_0 ;
  wire \daddr_C_reg[6]_i_3_n_0 ;
  wire \daddr_C_reg[6]_i_4_n_0 ;
  wire \daddr_C_reg[6]_i_5_n_0 ;
  wire \daddr_C_reg[6]_i_6_n_0 ;
  wire \daddr_C_reg[6]_i_7_n_0 ;
  wire \daddr_C_reg[6]_i_8_n_0 ;
  wire \daddr_C_reg[6]_i_9_n_0 ;
  wire [6:0]\daddr_C_reg_reg[6]_0 ;
  wire [5:0]\daddr_C_reg_reg[6]_1 ;
  wire [6:0]daddr_in;
  wire [6:0]daddr_reg;
  wire \daddr_reg_reg_n_0_[0] ;
  wire \daddr_reg_reg_n_0_[1] ;
  wire \daddr_reg_reg_n_0_[2] ;
  wire \daddr_reg_reg_n_0_[3] ;
  wire \daddr_reg_reg_n_0_[4] ;
  wire \daddr_reg_reg_n_0_[5] ;
  wire \daddr_reg_reg_n_0_[6] ;
  wire den_A;
  wire den_C;
  wire den_C_reg;
  wire den_C_reg_i_2_n_0;
  wire den_C_reg_i_3_n_0;
  wire den_C_reg_i_4_n_0;
  wire den_C_reg_i_5_n_0;
  wire den_in;
  wire den_reg;
  wire den_reg_reg_n_0;
  wire [15:0]di_C_reg;
  wire [15:0]\di_C_reg_reg[15]_0 ;
  wire [15:0]di_in;
  wire [15:0]di_reg;
  wire \di_reg_reg_n_0_[0] ;
  wire \di_reg_reg_n_0_[10] ;
  wire \di_reg_reg_n_0_[11] ;
  wire \di_reg_reg_n_0_[12] ;
  wire \di_reg_reg_n_0_[13] ;
  wire \di_reg_reg_n_0_[14] ;
  wire \di_reg_reg_n_0_[15] ;
  wire \di_reg_reg_n_0_[1] ;
  wire \di_reg_reg_n_0_[2] ;
  wire \di_reg_reg_n_0_[3] ;
  wire \di_reg_reg_n_0_[4] ;
  wire \di_reg_reg_n_0_[5] ;
  wire \di_reg_reg_n_0_[6] ;
  wire \di_reg_reg_n_0_[7] ;
  wire \di_reg_reg_n_0_[8] ;
  wire \di_reg_reg_n_0_[9] ;
  wire [15:0]do_A_reg0_in;
  wire \do_A_reg[15]_i_1_n_0 ;
  wire \do_A_reg_reg[14]_0 ;
  wire \do_A_reg_reg[15]_0 ;
  wire [15:0]do_B_reg0_in;
  wire \do_B_reg[15]_i_1_n_0 ;
  wire [15:0]do_out;
  wire drdy_A_reg_i_1_n_0;
  wire drdy_B_reg_i_1_n_0;
  wire drdy_C;
  wire drdy_i;
  wire drdy_out;
  wire dwe_C;
  wire dwe_C_reg;
  wire dwe_in;
  wire dwe_reg;
  wire dwe_reg_i_1_n_0;
  wire dwe_reg_i_3_n_0;
  wire dwe_reg_i_4_n_0;
  wire dwe_reg_i_5_n_0;
  wire dwe_reg_i_6_n_0;
  wire dwe_reg_reg_n_0;
  wire eoc_out;
  wire jtaglocked_i;
  wire m_axis_aclk;
  wire m_axis_reset;
  wire m_axis_resetn;
  wire \m_axis_tdata[15] ;
  wire mode_change;
  wire overlap_A;
  wire overlap_A_i_1_n_0;
  wire overlap_A_i_3_n_0;
  wire overlap_A_reg_n_0;
  wire overlap_B;
  wire overlap_B_i_1_n_0;
  wire overlap_B_i_3_n_0;
  wire overlap_B_i_4_n_0;
  wire overlap_B_reg_0;
  wire [1:0]state__0;
  wire wren_fifo;

  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h8)) 
    FIFO18E1_inst_data_i_2
       (.I0(drdy_i),
        .I1(\m_axis_tdata[15] ),
        .O(wren_fifo));
  LUT6 #(
    .INIT(64'h0000FFFFCCF40000)) 
    \FSM_sequential_state[0]_i_1 
       (.I0(overlap_B_reg_0),
        .I1(\FSM_sequential_state[0]_i_2__0_n_0 ),
        .I2(\FSM_sequential_state_reg[0]_1 ),
        .I3(state__0[1]),
        .I4(\FSM_sequential_state[1]_i_3_n_0 ),
        .I5(state__0[0]),
        .O(\FSM_sequential_state[0]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \FSM_sequential_state[0]_i_2__0 
       (.I0(overlap_A_reg_n_0),
        .I1(den_A),
        .O(\FSM_sequential_state[0]_i_2__0_n_0 ));
  LUT5 #(
    .INIT(32'hAAFFAE00)) 
    \FSM_sequential_state[1]_i_1 
       (.I0(\FSM_sequential_state[1]_i_2__0_n_0 ),
        .I1(overlap_B_reg_0),
        .I2(bbusy_A),
        .I3(\FSM_sequential_state[1]_i_3_n_0 ),
        .I4(state__0[1]),
        .O(\FSM_sequential_state[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h06)) 
    \FSM_sequential_state[1]_i_2 
       (.I0(Q[15]),
        .I1(Q[14]),
        .I2(\FSM_sequential_state_reg[3]_0 ),
        .O(\do_A_reg_reg[15]_0 ));
  LUT6 #(
    .INIT(64'h0200020002000300)) 
    \FSM_sequential_state[1]_i_2__0 
       (.I0(state__0[0]),
        .I1(state__0[1]),
        .I2(bbusy_A),
        .I3(den_in),
        .I4(den_A),
        .I5(overlap_A_reg_n_0),
        .O(\FSM_sequential_state[1]_i_2__0_n_0 ));
  LUT6 #(
    .INIT(64'hFAEAFFFFFAEAFAEA)) 
    \FSM_sequential_state[1]_i_3 
       (.I0(\FSM_sequential_state[1]_i_4_n_0 ),
        .I1(overlap_A_reg_n_0),
        .I2(\daddr_C_reg[6]_i_4_n_0 ),
        .I3(\FSM_sequential_state[1]_i_5_n_0 ),
        .I4(state__0[1]),
        .I5(dwe_reg_i_5_n_0),
        .O(\FSM_sequential_state[1]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h60)) 
    \FSM_sequential_state[1]_i_4 
       (.I0(state__0[1]),
        .I1(state__0[0]),
        .I2(drdy_C),
        .O(\FSM_sequential_state[1]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \FSM_sequential_state[1]_i_5 
       (.I0(overlap_B_reg_0),
        .I1(den_in),
        .O(\FSM_sequential_state[1]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h7F707F7F)) 
    \FSM_sequential_state[2]_i_2 
       (.I0(eoc_out),
        .I1(channel_out),
        .I2(\FSM_sequential_state_reg[3]_0 ),
        .I3(Q[14]),
        .I4(Q[15]),
        .O(\FSM_sequential_state_reg[0]_0 ));
  LUT6 #(
    .INIT(64'h00F09999FFFFFFFF)) 
    \FSM_sequential_state[3]_i_7 
       (.I0(Q[14]),
        .I1(Q[15]),
        .I2(\FSM_sequential_state_reg[3] ),
        .I3(mode_change),
        .I4(\FSM_sequential_state_reg[3]_0 ),
        .I5(\FSM_sequential_state_reg[3]_1 ),
        .O(\do_A_reg_reg[14]_0 ));
  (* FSM_ENCODED_STATES = "grant_b:10,nogrant:00,grant_a:01" *) 
  FDCE \FSM_sequential_state_reg[0] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\FSM_sequential_state[0]_i_1_n_0 ),
        .Q(state__0[0]));
  (* FSM_ENCODED_STATES = "grant_b:10,nogrant:00,grant_a:01" *) 
  FDCE \FSM_sequential_state_reg[1] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\FSM_sequential_state[1]_i_1_n_0 ),
        .Q(state__0[1]));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \daddr_C_reg[0]_i_1 
       (.I0(\daddr_C_reg[6]_i_6_n_0 ),
        .I1(daddr_in[0]),
        .I2(\daddr_C_reg[6]_i_7_n_0 ),
        .I3(\daddr_C_reg_reg[6]_1 [0]),
        .I4(\daddr_reg_reg_n_0_[0] ),
        .I5(\daddr_C_reg[6]_i_8_n_0 ),
        .O(daddr_C_reg0_in[0]));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \daddr_C_reg[1]_i_1 
       (.I0(\daddr_C_reg[6]_i_6_n_0 ),
        .I1(daddr_in[1]),
        .I2(\daddr_C_reg[6]_i_7_n_0 ),
        .I3(\daddr_C_reg_reg[6]_1 [1]),
        .I4(\daddr_reg_reg_n_0_[1] ),
        .I5(\daddr_C_reg[6]_i_8_n_0 ),
        .O(daddr_C_reg0_in[1]));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \daddr_C_reg[2]_i_1 
       (.I0(\daddr_C_reg[6]_i_6_n_0 ),
        .I1(daddr_in[2]),
        .I2(\daddr_C_reg[6]_i_7_n_0 ),
        .I3(\daddr_C_reg_reg[6]_1 [2]),
        .I4(\daddr_reg_reg_n_0_[2] ),
        .I5(\daddr_C_reg[6]_i_8_n_0 ),
        .O(daddr_C_reg0_in[2]));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \daddr_C_reg[3]_i_1 
       (.I0(\daddr_C_reg[6]_i_6_n_0 ),
        .I1(daddr_in[3]),
        .I2(\daddr_C_reg[6]_i_7_n_0 ),
        .I3(\daddr_C_reg_reg[6]_1 [3]),
        .I4(\daddr_reg_reg_n_0_[3] ),
        .I5(\daddr_C_reg[6]_i_8_n_0 ),
        .O(daddr_C_reg0_in[3]));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \daddr_C_reg[4]_i_1 
       (.I0(\daddr_C_reg[6]_i_6_n_0 ),
        .I1(daddr_in[4]),
        .I2(\daddr_C_reg[6]_i_7_n_0 ),
        .I3(\daddr_C_reg_reg[6]_1 [4]),
        .I4(\daddr_reg_reg_n_0_[4] ),
        .I5(\daddr_C_reg[6]_i_8_n_0 ),
        .O(daddr_C_reg0_in[4]));
  LUT4 #(
    .INIT(16'hF888)) 
    \daddr_C_reg[5]_i_1 
       (.I0(\daddr_reg_reg_n_0_[5] ),
        .I1(\daddr_C_reg[6]_i_8_n_0 ),
        .I2(daddr_in[5]),
        .I3(\daddr_C_reg[6]_i_6_n_0 ),
        .O(daddr_C_reg0_in[5]));
  LUT6 #(
    .INIT(64'hEEEEEEEEFEFEFEEE)) 
    \daddr_C_reg[6]_i_1 
       (.I0(\daddr_C_reg[6]_i_3_n_0 ),
        .I1(\daddr_C_reg[6]_i_4_n_0 ),
        .I2(\daddr_C_reg[6]_i_5_n_0 ),
        .I3(overlap_B_reg_0),
        .I4(den_in),
        .I5(bbusy_A),
        .O(\daddr_C_reg[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000040000FF0404)) 
    \daddr_C_reg[6]_i_10 
       (.I0(overlap_B_reg_0),
        .I1(den_A),
        .I2(overlap_A_reg_n_0),
        .I3(drdy_C),
        .I4(state__0[0]),
        .I5(state__0[1]),
        .O(\daddr_C_reg[6]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \daddr_C_reg[6]_i_2 
       (.I0(\daddr_C_reg[6]_i_6_n_0 ),
        .I1(daddr_in[6]),
        .I2(\daddr_C_reg[6]_i_7_n_0 ),
        .I3(\daddr_C_reg_reg[6]_1 [5]),
        .I4(\daddr_reg_reg_n_0_[6] ),
        .I5(\daddr_C_reg[6]_i_8_n_0 ),
        .O(daddr_C_reg0_in[6]));
  LUT6 #(
    .INIT(64'h11111111AAA2FFA2)) 
    \daddr_C_reg[6]_i_3 
       (.I0(state__0[1]),
        .I1(drdy_C),
        .I2(overlap_A_reg_n_0),
        .I3(den_A),
        .I4(jtaglocked_i),
        .I5(state__0[0]),
        .O(\daddr_C_reg[6]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \daddr_C_reg[6]_i_4 
       (.I0(bbusy_A),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(jtaglocked_i),
        .O(\daddr_C_reg[6]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \daddr_C_reg[6]_i_5 
       (.I0(state__0[0]),
        .I1(state__0[1]),
        .O(\daddr_C_reg[6]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h03C003C003F30340)) 
    \daddr_C_reg[6]_i_6 
       (.I0(overlap_B_reg_0),
        .I1(state__0[0]),
        .I2(drdy_C),
        .I3(state__0[1]),
        .I4(\daddr_C_reg[6]_i_9_n_0 ),
        .I5(bbusy_A),
        .O(\daddr_C_reg[6]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hAABAAAFFAABAAAAA)) 
    \daddr_C_reg[6]_i_7 
       (.I0(\daddr_C_reg[6]_i_10_n_0 ),
        .I1(overlap_A_reg_n_0),
        .I2(drdy_C),
        .I3(state__0[0]),
        .I4(state__0[1]),
        .I5(bbusy_A),
        .O(\daddr_C_reg[6]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h4000400040DD4050)) 
    \daddr_C_reg[6]_i_8 
       (.I0(state__0[0]),
        .I1(drdy_C),
        .I2(overlap_A_reg_n_0),
        .I3(state__0[1]),
        .I4(overlap_B_reg_0),
        .I5(bbusy_A),
        .O(\daddr_C_reg[6]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'h0004)) 
    \daddr_C_reg[6]_i_9 
       (.I0(den_A),
        .I1(den_in),
        .I2(overlap_B_reg_0),
        .I3(overlap_A_reg_n_0),
        .O(\daddr_C_reg[6]_i_9_n_0 ));
  FDCE \daddr_C_reg_reg[0] 
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(daddr_C_reg0_in[0]),
        .Q(\daddr_C_reg_reg[6]_0 [0]));
  FDCE \daddr_C_reg_reg[1] 
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(daddr_C_reg0_in[1]),
        .Q(\daddr_C_reg_reg[6]_0 [1]));
  FDCE \daddr_C_reg_reg[2] 
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(daddr_C_reg0_in[2]),
        .Q(\daddr_C_reg_reg[6]_0 [2]));
  FDCE \daddr_C_reg_reg[3] 
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(daddr_C_reg0_in[3]),
        .Q(\daddr_C_reg_reg[6]_0 [3]));
  FDCE \daddr_C_reg_reg[4] 
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(daddr_C_reg0_in[4]),
        .Q(\daddr_C_reg_reg[6]_0 [4]));
  FDCE \daddr_C_reg_reg[5] 
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(daddr_C_reg0_in[5]),
        .Q(\daddr_C_reg_reg[6]_0 [5]));
  FDCE \daddr_C_reg_reg[6] 
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(daddr_C_reg0_in[6]),
        .Q(\daddr_C_reg_reg[6]_0 [6]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'h2F20)) 
    \daddr_reg[0]_i_1 
       (.I0(\daddr_C_reg_reg[6]_1 [0]),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(daddr_in[0]),
        .O(daddr_reg[0]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h2F20)) 
    \daddr_reg[1]_i_1 
       (.I0(\daddr_C_reg_reg[6]_1 [1]),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(daddr_in[1]),
        .O(daddr_reg[1]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h2F20)) 
    \daddr_reg[2]_i_1 
       (.I0(\daddr_C_reg_reg[6]_1 [2]),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(daddr_in[2]),
        .O(daddr_reg[2]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h2F20)) 
    \daddr_reg[3]_i_1 
       (.I0(\daddr_C_reg_reg[6]_1 [3]),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(daddr_in[3]),
        .O(daddr_reg[3]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h2F20)) 
    \daddr_reg[4]_i_1 
       (.I0(\daddr_C_reg_reg[6]_1 [4]),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(daddr_in[4]),
        .O(daddr_reg[4]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \daddr_reg[5]_i_1 
       (.I0(daddr_in[5]),
        .I1(state__0[1]),
        .O(daddr_reg[5]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'h2F20)) 
    \daddr_reg[6]_i_1 
       (.I0(\daddr_C_reg_reg[6]_1 [5]),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(daddr_in[6]),
        .O(daddr_reg[6]));
  FDCE \daddr_reg_reg[0] 
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(daddr_reg[0]),
        .Q(\daddr_reg_reg_n_0_[0] ));
  FDCE \daddr_reg_reg[1] 
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(daddr_reg[1]),
        .Q(\daddr_reg_reg_n_0_[1] ));
  FDCE \daddr_reg_reg[2] 
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(daddr_reg[2]),
        .Q(\daddr_reg_reg_n_0_[2] ));
  FDCE \daddr_reg_reg[3] 
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(daddr_reg[3]),
        .Q(\daddr_reg_reg_n_0_[3] ));
  FDCE \daddr_reg_reg[4] 
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(daddr_reg[4]),
        .Q(\daddr_reg_reg_n_0_[4] ));
  FDCE \daddr_reg_reg[5] 
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(daddr_reg[5]),
        .Q(\daddr_reg_reg_n_0_[5] ));
  FDCE \daddr_reg_reg[6] 
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(daddr_reg[6]),
        .Q(\daddr_reg_reg_n_0_[6] ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFEA)) 
    den_C_reg_i_1
       (.I0(den_C_reg_i_2_n_0),
        .I1(\daddr_C_reg[6]_i_8_n_0 ),
        .I2(den_reg_reg_n_0),
        .I3(den_C_reg_i_3_n_0),
        .I4(den_C_reg_i_4_n_0),
        .I5(den_C_reg_i_5_n_0),
        .O(den_C_reg));
  LUT6 #(
    .INIT(64'h0202024700000000)) 
    den_C_reg_i_2
       (.I0(state__0[0]),
        .I1(drdy_C),
        .I2(state__0[1]),
        .I3(overlap_B_reg_0),
        .I4(overlap_A_reg_n_0),
        .I5(den_A),
        .O(den_C_reg_i_2_n_0));
  LUT6 #(
    .INIT(64'h040F040000000000)) 
    den_C_reg_i_3
       (.I0(overlap_A_reg_n_0),
        .I1(drdy_C),
        .I2(state__0[0]),
        .I3(state__0[1]),
        .I4(bbusy_A),
        .I5(den_A),
        .O(den_C_reg_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h0400)) 
    den_C_reg_i_4
       (.I0(drdy_C),
        .I1(den_in),
        .I2(state__0[0]),
        .I3(state__0[1]),
        .O(den_C_reg_i_4_n_0));
  LUT6 #(
    .INIT(64'h000000004000440C)) 
    den_C_reg_i_5
       (.I0(state__0[1]),
        .I1(dwe_reg_i_4_n_0),
        .I2(state__0[0]),
        .I3(drdy_C),
        .I4(overlap_A_reg_n_0),
        .I5(bbusy_A),
        .O(den_C_reg_i_5_n_0));
  FDCE den_C_reg_reg
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(den_C_reg),
        .Q(den_C));
  FDCE den_reg_reg
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(den_reg),
        .Q(den_reg_reg_n_0));
  LUT4 #(
    .INIT(16'hF888)) 
    \di_C_reg[0]_i_1 
       (.I0(\di_reg_reg_n_0_[0] ),
        .I1(\daddr_C_reg[6]_i_8_n_0 ),
        .I2(di_in[0]),
        .I3(\daddr_C_reg[6]_i_6_n_0 ),
        .O(di_C_reg[0]));
  LUT4 #(
    .INIT(16'hF888)) 
    \di_C_reg[10]_i_1 
       (.I0(\di_reg_reg_n_0_[10] ),
        .I1(\daddr_C_reg[6]_i_8_n_0 ),
        .I2(di_in[10]),
        .I3(\daddr_C_reg[6]_i_6_n_0 ),
        .O(di_C_reg[10]));
  LUT4 #(
    .INIT(16'hF888)) 
    \di_C_reg[11]_i_1 
       (.I0(\di_reg_reg_n_0_[11] ),
        .I1(\daddr_C_reg[6]_i_8_n_0 ),
        .I2(di_in[11]),
        .I3(\daddr_C_reg[6]_i_6_n_0 ),
        .O(di_C_reg[11]));
  LUT4 #(
    .INIT(16'hF888)) 
    \di_C_reg[12]_i_1 
       (.I0(\di_reg_reg_n_0_[12] ),
        .I1(\daddr_C_reg[6]_i_8_n_0 ),
        .I2(di_in[12]),
        .I3(\daddr_C_reg[6]_i_6_n_0 ),
        .O(di_C_reg[12]));
  LUT4 #(
    .INIT(16'hF888)) 
    \di_C_reg[13]_i_1 
       (.I0(\di_reg_reg_n_0_[13] ),
        .I1(\daddr_C_reg[6]_i_8_n_0 ),
        .I2(di_in[13]),
        .I3(\daddr_C_reg[6]_i_6_n_0 ),
        .O(di_C_reg[13]));
  LUT4 #(
    .INIT(16'hF888)) 
    \di_C_reg[14]_i_1 
       (.I0(\di_reg_reg_n_0_[14] ),
        .I1(\daddr_C_reg[6]_i_8_n_0 ),
        .I2(di_in[14]),
        .I3(\daddr_C_reg[6]_i_6_n_0 ),
        .O(di_C_reg[14]));
  LUT4 #(
    .INIT(16'hF888)) 
    \di_C_reg[15]_i_1 
       (.I0(\di_reg_reg_n_0_[15] ),
        .I1(\daddr_C_reg[6]_i_8_n_0 ),
        .I2(di_in[15]),
        .I3(\daddr_C_reg[6]_i_6_n_0 ),
        .O(di_C_reg[15]));
  LUT4 #(
    .INIT(16'hF888)) 
    \di_C_reg[1]_i_1 
       (.I0(\di_reg_reg_n_0_[1] ),
        .I1(\daddr_C_reg[6]_i_8_n_0 ),
        .I2(di_in[1]),
        .I3(\daddr_C_reg[6]_i_6_n_0 ),
        .O(di_C_reg[1]));
  LUT4 #(
    .INIT(16'hF888)) 
    \di_C_reg[2]_i_1 
       (.I0(\di_reg_reg_n_0_[2] ),
        .I1(\daddr_C_reg[6]_i_8_n_0 ),
        .I2(di_in[2]),
        .I3(\daddr_C_reg[6]_i_6_n_0 ),
        .O(di_C_reg[2]));
  LUT4 #(
    .INIT(16'hF888)) 
    \di_C_reg[3]_i_1 
       (.I0(\di_reg_reg_n_0_[3] ),
        .I1(\daddr_C_reg[6]_i_8_n_0 ),
        .I2(di_in[3]),
        .I3(\daddr_C_reg[6]_i_6_n_0 ),
        .O(di_C_reg[3]));
  LUT4 #(
    .INIT(16'hF888)) 
    \di_C_reg[4]_i_1 
       (.I0(\di_reg_reg_n_0_[4] ),
        .I1(\daddr_C_reg[6]_i_8_n_0 ),
        .I2(di_in[4]),
        .I3(\daddr_C_reg[6]_i_6_n_0 ),
        .O(di_C_reg[4]));
  LUT4 #(
    .INIT(16'hF888)) 
    \di_C_reg[5]_i_1 
       (.I0(\di_reg_reg_n_0_[5] ),
        .I1(\daddr_C_reg[6]_i_8_n_0 ),
        .I2(di_in[5]),
        .I3(\daddr_C_reg[6]_i_6_n_0 ),
        .O(di_C_reg[5]));
  LUT4 #(
    .INIT(16'hF888)) 
    \di_C_reg[6]_i_1 
       (.I0(\di_reg_reg_n_0_[6] ),
        .I1(\daddr_C_reg[6]_i_8_n_0 ),
        .I2(di_in[6]),
        .I3(\daddr_C_reg[6]_i_6_n_0 ),
        .O(di_C_reg[6]));
  LUT4 #(
    .INIT(16'hF888)) 
    \di_C_reg[7]_i_1 
       (.I0(\di_reg_reg_n_0_[7] ),
        .I1(\daddr_C_reg[6]_i_8_n_0 ),
        .I2(di_in[7]),
        .I3(\daddr_C_reg[6]_i_6_n_0 ),
        .O(di_C_reg[7]));
  LUT4 #(
    .INIT(16'hF888)) 
    \di_C_reg[8]_i_1 
       (.I0(\di_reg_reg_n_0_[8] ),
        .I1(\daddr_C_reg[6]_i_8_n_0 ),
        .I2(di_in[8]),
        .I3(\daddr_C_reg[6]_i_6_n_0 ),
        .O(di_C_reg[8]));
  LUT4 #(
    .INIT(16'hF888)) 
    \di_C_reg[9]_i_1 
       (.I0(\di_reg_reg_n_0_[9] ),
        .I1(\daddr_C_reg[6]_i_8_n_0 ),
        .I2(di_in[9]),
        .I3(\daddr_C_reg[6]_i_6_n_0 ),
        .O(di_C_reg[9]));
  FDCE \di_C_reg_reg[0] 
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(di_C_reg[0]),
        .Q(\di_C_reg_reg[15]_0 [0]));
  FDCE \di_C_reg_reg[10] 
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(di_C_reg[10]),
        .Q(\di_C_reg_reg[15]_0 [10]));
  FDCE \di_C_reg_reg[11] 
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(di_C_reg[11]),
        .Q(\di_C_reg_reg[15]_0 [11]));
  FDCE \di_C_reg_reg[12] 
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(di_C_reg[12]),
        .Q(\di_C_reg_reg[15]_0 [12]));
  FDCE \di_C_reg_reg[13] 
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(di_C_reg[13]),
        .Q(\di_C_reg_reg[15]_0 [13]));
  FDCE \di_C_reg_reg[14] 
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(di_C_reg[14]),
        .Q(\di_C_reg_reg[15]_0 [14]));
  FDCE \di_C_reg_reg[15] 
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(di_C_reg[15]),
        .Q(\di_C_reg_reg[15]_0 [15]));
  FDCE \di_C_reg_reg[1] 
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(di_C_reg[1]),
        .Q(\di_C_reg_reg[15]_0 [1]));
  FDCE \di_C_reg_reg[2] 
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(di_C_reg[2]),
        .Q(\di_C_reg_reg[15]_0 [2]));
  FDCE \di_C_reg_reg[3] 
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(di_C_reg[3]),
        .Q(\di_C_reg_reg[15]_0 [3]));
  FDCE \di_C_reg_reg[4] 
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(di_C_reg[4]),
        .Q(\di_C_reg_reg[15]_0 [4]));
  FDCE \di_C_reg_reg[5] 
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(di_C_reg[5]),
        .Q(\di_C_reg_reg[15]_0 [5]));
  FDCE \di_C_reg_reg[6] 
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(di_C_reg[6]),
        .Q(\di_C_reg_reg[15]_0 [6]));
  FDCE \di_C_reg_reg[7] 
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(di_C_reg[7]),
        .Q(\di_C_reg_reg[15]_0 [7]));
  FDCE \di_C_reg_reg[8] 
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(di_C_reg[8]),
        .Q(\di_C_reg_reg[15]_0 [8]));
  FDCE \di_C_reg_reg[9] 
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(di_C_reg[9]),
        .Q(\di_C_reg_reg[15]_0 [9]));
  LUT2 #(
    .INIT(4'h2)) 
    \di_reg[0]_i_1 
       (.I0(di_in[0]),
        .I1(state__0[1]),
        .O(di_reg[0]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \di_reg[10]_i_1 
       (.I0(di_in[10]),
        .I1(state__0[1]),
        .O(di_reg[10]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \di_reg[11]_i_1 
       (.I0(di_in[11]),
        .I1(state__0[1]),
        .O(di_reg[11]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \di_reg[12]_i_1 
       (.I0(di_in[12]),
        .I1(state__0[1]),
        .O(di_reg[12]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \di_reg[13]_i_1 
       (.I0(di_in[13]),
        .I1(state__0[1]),
        .O(di_reg[13]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \di_reg[14]_i_1 
       (.I0(di_in[14]),
        .I1(state__0[1]),
        .O(di_reg[14]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \di_reg[15]_i_1 
       (.I0(di_in[15]),
        .I1(state__0[1]),
        .O(di_reg[15]));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \di_reg[1]_i_1 
       (.I0(di_in[1]),
        .I1(state__0[1]),
        .O(di_reg[1]));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \di_reg[2]_i_1 
       (.I0(di_in[2]),
        .I1(state__0[1]),
        .O(di_reg[2]));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \di_reg[3]_i_1 
       (.I0(di_in[3]),
        .I1(state__0[1]),
        .O(di_reg[3]));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \di_reg[4]_i_1 
       (.I0(di_in[4]),
        .I1(state__0[1]),
        .O(di_reg[4]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \di_reg[5]_i_1 
       (.I0(di_in[5]),
        .I1(state__0[1]),
        .O(di_reg[5]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \di_reg[6]_i_1 
       (.I0(di_in[6]),
        .I1(state__0[1]),
        .O(di_reg[6]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \di_reg[7]_i_1 
       (.I0(di_in[7]),
        .I1(state__0[1]),
        .O(di_reg[7]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \di_reg[8]_i_1 
       (.I0(di_in[8]),
        .I1(state__0[1]),
        .O(di_reg[8]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \di_reg[9]_i_1 
       (.I0(di_in[9]),
        .I1(state__0[1]),
        .O(di_reg[9]));
  FDCE \di_reg_reg[0] 
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(di_reg[0]),
        .Q(\di_reg_reg_n_0_[0] ));
  FDCE \di_reg_reg[10] 
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(di_reg[10]),
        .Q(\di_reg_reg_n_0_[10] ));
  FDCE \di_reg_reg[11] 
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(di_reg[11]),
        .Q(\di_reg_reg_n_0_[11] ));
  FDCE \di_reg_reg[12] 
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(di_reg[12]),
        .Q(\di_reg_reg_n_0_[12] ));
  FDCE \di_reg_reg[13] 
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(di_reg[13]),
        .Q(\di_reg_reg_n_0_[13] ));
  FDCE \di_reg_reg[14] 
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(di_reg[14]),
        .Q(\di_reg_reg_n_0_[14] ));
  FDCE \di_reg_reg[15] 
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(di_reg[15]),
        .Q(\di_reg_reg_n_0_[15] ));
  FDCE \di_reg_reg[1] 
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(di_reg[1]),
        .Q(\di_reg_reg_n_0_[1] ));
  FDCE \di_reg_reg[2] 
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(di_reg[2]),
        .Q(\di_reg_reg_n_0_[2] ));
  FDCE \di_reg_reg[3] 
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(di_reg[3]),
        .Q(\di_reg_reg_n_0_[3] ));
  FDCE \di_reg_reg[4] 
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(di_reg[4]),
        .Q(\di_reg_reg_n_0_[4] ));
  FDCE \di_reg_reg[5] 
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(di_reg[5]),
        .Q(\di_reg_reg_n_0_[5] ));
  FDCE \di_reg_reg[6] 
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(di_reg[6]),
        .Q(\di_reg_reg_n_0_[6] ));
  FDCE \di_reg_reg[7] 
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(di_reg[7]),
        .Q(\di_reg_reg_n_0_[7] ));
  FDCE \di_reg_reg[8] 
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(di_reg[8]),
        .Q(\di_reg_reg_n_0_[8] ));
  FDCE \di_reg_reg[9] 
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(di_reg[9]),
        .Q(\di_reg_reg_n_0_[9] ));
  LUT2 #(
    .INIT(4'h8)) 
    \do_A_reg[0]_i_1 
       (.I0(state__0[0]),
        .I1(DO[0]),
        .O(do_A_reg0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_A_reg[10]_i_1 
       (.I0(state__0[0]),
        .I1(DO[10]),
        .O(do_A_reg0_in[10]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_A_reg[11]_i_1 
       (.I0(state__0[0]),
        .I1(DO[11]),
        .O(do_A_reg0_in[11]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_A_reg[12]_i_1 
       (.I0(state__0[0]),
        .I1(DO[12]),
        .O(do_A_reg0_in[12]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_A_reg[13]_i_1 
       (.I0(state__0[0]),
        .I1(DO[13]),
        .O(do_A_reg0_in[13]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_A_reg[14]_i_1 
       (.I0(state__0[0]),
        .I1(DO[14]),
        .O(do_A_reg0_in[14]));
  LUT3 #(
    .INIT(8'h31)) 
    \do_A_reg[15]_i_1 
       (.I0(state__0[0]),
        .I1(state__0[1]),
        .I2(drdy_C),
        .O(\do_A_reg[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_A_reg[15]_i_2 
       (.I0(state__0[0]),
        .I1(DO[15]),
        .O(do_A_reg0_in[15]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_A_reg[1]_i_1 
       (.I0(state__0[0]),
        .I1(DO[1]),
        .O(do_A_reg0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_A_reg[2]_i_1 
       (.I0(state__0[0]),
        .I1(DO[2]),
        .O(do_A_reg0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_A_reg[3]_i_1 
       (.I0(state__0[0]),
        .I1(DO[3]),
        .O(do_A_reg0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_A_reg[4]_i_1 
       (.I0(state__0[0]),
        .I1(DO[4]),
        .O(do_A_reg0_in[4]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_A_reg[5]_i_1 
       (.I0(state__0[0]),
        .I1(DO[5]),
        .O(do_A_reg0_in[5]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_A_reg[6]_i_1 
       (.I0(state__0[0]),
        .I1(DO[6]),
        .O(do_A_reg0_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_A_reg[7]_i_1 
       (.I0(state__0[0]),
        .I1(DO[7]),
        .O(do_A_reg0_in[7]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_A_reg[8]_i_1 
       (.I0(state__0[0]),
        .I1(DO[8]),
        .O(do_A_reg0_in[8]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_A_reg[9]_i_1 
       (.I0(state__0[0]),
        .I1(DO[9]),
        .O(do_A_reg0_in[9]));
  FDCE \do_A_reg_reg[0] 
       (.C(m_axis_aclk),
        .CE(\do_A_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_A_reg0_in[0]),
        .Q(Q[0]));
  FDCE \do_A_reg_reg[10] 
       (.C(m_axis_aclk),
        .CE(\do_A_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_A_reg0_in[10]),
        .Q(Q[10]));
  FDCE \do_A_reg_reg[11] 
       (.C(m_axis_aclk),
        .CE(\do_A_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_A_reg0_in[11]),
        .Q(Q[11]));
  FDCE \do_A_reg_reg[12] 
       (.C(m_axis_aclk),
        .CE(\do_A_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_A_reg0_in[12]),
        .Q(Q[12]));
  FDCE \do_A_reg_reg[13] 
       (.C(m_axis_aclk),
        .CE(\do_A_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_A_reg0_in[13]),
        .Q(Q[13]));
  FDCE \do_A_reg_reg[14] 
       (.C(m_axis_aclk),
        .CE(\do_A_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_A_reg0_in[14]),
        .Q(Q[14]));
  FDCE \do_A_reg_reg[15] 
       (.C(m_axis_aclk),
        .CE(\do_A_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_A_reg0_in[15]),
        .Q(Q[15]));
  FDCE \do_A_reg_reg[1] 
       (.C(m_axis_aclk),
        .CE(\do_A_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_A_reg0_in[1]),
        .Q(Q[1]));
  FDCE \do_A_reg_reg[2] 
       (.C(m_axis_aclk),
        .CE(\do_A_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_A_reg0_in[2]),
        .Q(Q[2]));
  FDCE \do_A_reg_reg[3] 
       (.C(m_axis_aclk),
        .CE(\do_A_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_A_reg0_in[3]),
        .Q(Q[3]));
  FDCE \do_A_reg_reg[4] 
       (.C(m_axis_aclk),
        .CE(\do_A_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_A_reg0_in[4]),
        .Q(Q[4]));
  FDCE \do_A_reg_reg[5] 
       (.C(m_axis_aclk),
        .CE(\do_A_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_A_reg0_in[5]),
        .Q(Q[5]));
  FDCE \do_A_reg_reg[6] 
       (.C(m_axis_aclk),
        .CE(\do_A_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_A_reg0_in[6]),
        .Q(Q[6]));
  FDCE \do_A_reg_reg[7] 
       (.C(m_axis_aclk),
        .CE(\do_A_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_A_reg0_in[7]),
        .Q(Q[7]));
  FDCE \do_A_reg_reg[8] 
       (.C(m_axis_aclk),
        .CE(\do_A_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_A_reg0_in[8]),
        .Q(Q[8]));
  FDCE \do_A_reg_reg[9] 
       (.C(m_axis_aclk),
        .CE(\do_A_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_A_reg0_in[9]),
        .Q(Q[9]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_B_reg[0]_i_1 
       (.I0(state__0[1]),
        .I1(DO[0]),
        .O(do_B_reg0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_B_reg[10]_i_1 
       (.I0(state__0[1]),
        .I1(DO[10]),
        .O(do_B_reg0_in[10]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_B_reg[11]_i_1 
       (.I0(state__0[1]),
        .I1(DO[11]),
        .O(do_B_reg0_in[11]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_B_reg[12]_i_1 
       (.I0(state__0[1]),
        .I1(DO[12]),
        .O(do_B_reg0_in[12]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_B_reg[13]_i_1 
       (.I0(state__0[1]),
        .I1(DO[13]),
        .O(do_B_reg0_in[13]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_B_reg[14]_i_1 
       (.I0(state__0[1]),
        .I1(DO[14]),
        .O(do_B_reg0_in[14]));
  LUT3 #(
    .INIT(8'h31)) 
    \do_B_reg[15]_i_1 
       (.I0(state__0[1]),
        .I1(state__0[0]),
        .I2(drdy_C),
        .O(\do_B_reg[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_B_reg[15]_i_2 
       (.I0(state__0[1]),
        .I1(DO[15]),
        .O(do_B_reg0_in[15]));
  LUT1 #(
    .INIT(2'h1)) 
    \do_B_reg[15]_i_3 
       (.I0(m_axis_resetn),
        .O(m_axis_reset));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_B_reg[1]_i_1 
       (.I0(state__0[1]),
        .I1(DO[1]),
        .O(do_B_reg0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_B_reg[2]_i_1 
       (.I0(state__0[1]),
        .I1(DO[2]),
        .O(do_B_reg0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_B_reg[3]_i_1 
       (.I0(state__0[1]),
        .I1(DO[3]),
        .O(do_B_reg0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_B_reg[4]_i_1 
       (.I0(state__0[1]),
        .I1(DO[4]),
        .O(do_B_reg0_in[4]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_B_reg[5]_i_1 
       (.I0(state__0[1]),
        .I1(DO[5]),
        .O(do_B_reg0_in[5]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_B_reg[6]_i_1 
       (.I0(state__0[1]),
        .I1(DO[6]),
        .O(do_B_reg0_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_B_reg[7]_i_1 
       (.I0(state__0[1]),
        .I1(DO[7]),
        .O(do_B_reg0_in[7]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_B_reg[8]_i_1 
       (.I0(state__0[1]),
        .I1(DO[8]),
        .O(do_B_reg0_in[8]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \do_B_reg[9]_i_1 
       (.I0(state__0[1]),
        .I1(DO[9]),
        .O(do_B_reg0_in[9]));
  FDCE \do_B_reg_reg[0] 
       (.C(m_axis_aclk),
        .CE(\do_B_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_B_reg0_in[0]),
        .Q(do_out[0]));
  FDCE \do_B_reg_reg[10] 
       (.C(m_axis_aclk),
        .CE(\do_B_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_B_reg0_in[10]),
        .Q(do_out[10]));
  FDCE \do_B_reg_reg[11] 
       (.C(m_axis_aclk),
        .CE(\do_B_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_B_reg0_in[11]),
        .Q(do_out[11]));
  FDCE \do_B_reg_reg[12] 
       (.C(m_axis_aclk),
        .CE(\do_B_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_B_reg0_in[12]),
        .Q(do_out[12]));
  FDCE \do_B_reg_reg[13] 
       (.C(m_axis_aclk),
        .CE(\do_B_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_B_reg0_in[13]),
        .Q(do_out[13]));
  FDCE \do_B_reg_reg[14] 
       (.C(m_axis_aclk),
        .CE(\do_B_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_B_reg0_in[14]),
        .Q(do_out[14]));
  FDCE \do_B_reg_reg[15] 
       (.C(m_axis_aclk),
        .CE(\do_B_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_B_reg0_in[15]),
        .Q(do_out[15]));
  FDCE \do_B_reg_reg[1] 
       (.C(m_axis_aclk),
        .CE(\do_B_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_B_reg0_in[1]),
        .Q(do_out[1]));
  FDCE \do_B_reg_reg[2] 
       (.C(m_axis_aclk),
        .CE(\do_B_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_B_reg0_in[2]),
        .Q(do_out[2]));
  FDCE \do_B_reg_reg[3] 
       (.C(m_axis_aclk),
        .CE(\do_B_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_B_reg0_in[3]),
        .Q(do_out[3]));
  FDCE \do_B_reg_reg[4] 
       (.C(m_axis_aclk),
        .CE(\do_B_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_B_reg0_in[4]),
        .Q(do_out[4]));
  FDCE \do_B_reg_reg[5] 
       (.C(m_axis_aclk),
        .CE(\do_B_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_B_reg0_in[5]),
        .Q(do_out[5]));
  FDCE \do_B_reg_reg[6] 
       (.C(m_axis_aclk),
        .CE(\do_B_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_B_reg0_in[6]),
        .Q(do_out[6]));
  FDCE \do_B_reg_reg[7] 
       (.C(m_axis_aclk),
        .CE(\do_B_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_B_reg0_in[7]),
        .Q(do_out[7]));
  FDCE \do_B_reg_reg[8] 
       (.C(m_axis_aclk),
        .CE(\do_B_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_B_reg0_in[8]),
        .Q(do_out[8]));
  FDCE \do_B_reg_reg[9] 
       (.C(m_axis_aclk),
        .CE(\do_B_reg[15]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(do_B_reg0_in[9]),
        .Q(do_out[9]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'hC808)) 
    drdy_A_reg_i_1
       (.I0(drdy_C),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(drdy_i),
        .O(drdy_A_reg_i_1_n_0));
  FDCE drdy_A_reg_reg
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(drdy_A_reg_i_1_n_0),
        .Q(drdy_i));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'hE020)) 
    drdy_B_reg_i_1
       (.I0(drdy_C),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(drdy_out),
        .O(drdy_B_reg_i_1_n_0));
  FDCE drdy_B_reg_reg
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(drdy_B_reg_i_1_n_0),
        .Q(drdy_out));
  LUT4 #(
    .INIT(16'hF888)) 
    dwe_C_reg_i_1
       (.I0(dwe_reg_reg_n_0),
        .I1(\daddr_C_reg[6]_i_8_n_0 ),
        .I2(dwe_in),
        .I3(\daddr_C_reg[6]_i_6_n_0 ),
        .O(dwe_C_reg));
  FDCE dwe_C_reg_reg
       (.C(m_axis_aclk),
        .CE(\daddr_C_reg[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(dwe_C_reg),
        .Q(dwe_C));
  LUT6 #(
    .INIT(64'hFFFFFFFF8F888888)) 
    dwe_reg_i_1
       (.I0(dwe_reg_i_3_n_0),
        .I1(den_A),
        .I2(overlap_A_reg_n_0),
        .I3(dwe_reg_i_4_n_0),
        .I4(dwe_reg_i_5_n_0),
        .I5(dwe_reg_i_6_n_0),
        .O(dwe_reg_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h4)) 
    dwe_reg_i_2
       (.I0(state__0[1]),
        .I1(dwe_in),
        .O(dwe_reg));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h2)) 
    dwe_reg_i_3
       (.I0(state__0[1]),
        .I1(state__0[0]),
        .O(dwe_reg_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h2)) 
    dwe_reg_i_4
       (.I0(den_in),
        .I1(overlap_B_reg_0),
        .O(dwe_reg_i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'h10)) 
    dwe_reg_i_5
       (.I0(state__0[0]),
        .I1(jtaglocked_i),
        .I2(den_A),
        .O(dwe_reg_i_5_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h22320000)) 
    dwe_reg_i_6
       (.I0(state__0[0]),
        .I1(state__0[1]),
        .I2(bbusy_A),
        .I3(jtaglocked_i),
        .I4(den_in),
        .O(dwe_reg_i_6_n_0));
  FDCE dwe_reg_reg
       (.C(m_axis_aclk),
        .CE(dwe_reg_i_1_n_0),
        .CLR(m_axis_reset),
        .D(dwe_reg),
        .Q(dwe_reg_reg_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAAABB80BF80)) 
    overlap_A_i_1
       (.I0(overlap_A),
        .I1(dwe_reg_i_3_n_0),
        .I2(den_A),
        .I3(overlap_A_reg_n_0),
        .I4(drdy_C),
        .I5(overlap_A_i_3_n_0),
        .O(overlap_A_i_1_n_0));
  LUT6 #(
    .INIT(64'h00000000FF44F444)) 
    overlap_A_i_3
       (.I0(bbusy_A),
        .I1(dwe_reg_i_5_n_0),
        .I2(overlap_A_reg_n_0),
        .I3(\daddr_C_reg[6]_i_4_n_0 ),
        .I4(den_in),
        .I5(overlap_B_reg_0),
        .O(overlap_A_i_3_n_0));
  FDCE overlap_A_reg
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(overlap_A_i_1_n_0),
        .Q(overlap_A_reg_n_0));
  LUT5 #(
    .INIT(32'hAAAAAB88)) 
    overlap_B_i_1
       (.I0(overlap_B),
        .I1(overlap_B_i_3_n_0),
        .I2(\daddr_C_reg[6]_i_4_n_0 ),
        .I3(overlap_B_reg_0),
        .I4(overlap_B_i_4_n_0),
        .O(overlap_B_i_1_n_0));
  LUT6 #(
    .INIT(64'h00000000E0F0E0E0)) 
    overlap_B_i_2
       (.I0(bbusy_A),
        .I1(state__0[0]),
        .I2(den_in),
        .I3(overlap_B_reg_0),
        .I4(den_A),
        .I5(state__0[1]),
        .O(overlap_B));
  LUT6 #(
    .INIT(64'h00008888000088F8)) 
    overlap_B_i_3
       (.I0(\daddr_C_reg[6]_i_4_n_0 ),
        .I1(den_A),
        .I2(den_in),
        .I3(state__0[1]),
        .I4(overlap_A_reg_n_0),
        .I5(jtaglocked_i),
        .O(overlap_B_i_3_n_0));
  LUT6 #(
    .INIT(64'hAAAEAAAAAAAAAAAA)) 
    overlap_B_i_4
       (.I0(dwe_reg_i_6_n_0),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(bbusy_A),
        .I4(overlap_B_reg_0),
        .I5(drdy_C),
        .O(overlap_B_i_4_n_0));
  FDCE overlap_B_reg
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(overlap_B_i_1_n_0),
        .Q(overlap_B_reg_0));
endmodule

(* ORIG_REF_NAME = "drp_to_axi4stream" *) 
module xadc_wiz_0_drp_to_axi4stream
   (m_axis_tdata,
    m_axis_tid,
    \channel_id_reg[6]_0 ,
    den_A,
    bbusy_A,
    valid_data_wren_reg_0,
    \FSM_sequential_state_reg[0]_0 ,
    m_axis_aclk_0,
    \FSM_sequential_state_reg[1]_0 ,
    den_reg,
    overlap_A,
    busy_o_reg_0,
    daddr_in_2_sp_1,
    m_axis_tvalid,
    temp_out,
    s_axis_aclk,
    m_axis_reset,
    m_axis_aclk,
    wren_fifo,
    Q,
    drdy_i,
    m_axis_tready,
    eoc_out,
    mode_change,
    \FSM_sequential_state_reg[3]_0 ,
    \FSM_sequential_state_reg[1]_1 ,
    \FSM_sequential_state_reg[2]_0 ,
    channel_out,
    den_in,
    state__0,
    \FSM_sequential_state_reg[0]_1 ,
    mode_change_reg,
    daddr_in);
  output [15:0]m_axis_tdata;
  output [4:0]m_axis_tid;
  output [5:0]\channel_id_reg[6]_0 ;
  output den_A;
  output bbusy_A;
  output valid_data_wren_reg_0;
  output [0:0]\FSM_sequential_state_reg[0]_0 ;
  output m_axis_aclk_0;
  output \FSM_sequential_state_reg[1]_0 ;
  output den_reg;
  output overlap_A;
  output busy_o_reg_0;
  output daddr_in_2_sp_1;
  output m_axis_tvalid;
  output [11:0]temp_out;
  input s_axis_aclk;
  input m_axis_reset;
  input m_axis_aclk;
  input wren_fifo;
  input [15:0]Q;
  input drdy_i;
  input m_axis_tready;
  input eoc_out;
  input mode_change;
  input \FSM_sequential_state_reg[3]_0 ;
  input \FSM_sequential_state_reg[1]_1 ;
  input \FSM_sequential_state_reg[2]_0 ;
  input [4:0]channel_out;
  input den_in;
  input [1:0]state__0;
  input \FSM_sequential_state_reg[0]_1 ;
  input mode_change_reg;
  input [2:0]daddr_in;

  wire FIFO18E1_inst_data_i_1_n_0;
  wire \FSM_sequential_state[0]_i_2_n_0 ;
  wire \FSM_sequential_state[3]_i_10_n_0 ;
  wire \FSM_sequential_state[3]_i_1_n_0 ;
  wire \FSM_sequential_state[3]_i_3_n_0 ;
  wire \FSM_sequential_state[3]_i_4_n_0 ;
  wire \FSM_sequential_state[3]_i_5_n_0 ;
  wire \FSM_sequential_state[3]_i_6_n_0 ;
  wire \FSM_sequential_state[3]_i_8_n_0 ;
  wire \FSM_sequential_state[3]_i_9_n_0 ;
  wire [0:0]\FSM_sequential_state_reg[0]_0 ;
  wire \FSM_sequential_state_reg[0]_1 ;
  wire \FSM_sequential_state_reg[1]_0 ;
  wire \FSM_sequential_state_reg[1]_1 ;
  wire \FSM_sequential_state_reg[2]_0 ;
  wire \FSM_sequential_state_reg[3]_0 ;
  wire [15:0]Q;
  wire almost_full;
  wire bbusy_A;
  wire busy_o_i_1_n_0;
  wire busy_o_reg_0;
  wire [6:0]channel_id;
  wire \channel_id[6]_i_1_n_0 ;
  wire [5:0]\channel_id_reg[6]_0 ;
  wire [4:0]channel_out;
  wire [2:0]daddr_in;
  wire daddr_in_2_sn_1;
  wire den_A;
  wire den_in;
  wire den_o_i_1_n_0;
  wire den_reg;
  wire drdy_i;
  wire drp_rdwr_status;
  wire drp_rdwr_status0;
  wire drp_rdwr_status_i_1_n_0;
  wire eoc_out;
  wire fifo_empty;
  wire m_axis_aclk;
  wire m_axis_aclk_0;
  wire m_axis_reset;
  wire [15:0]m_axis_tdata;
  wire [4:0]m_axis_tid;
  wire m_axis_tready;
  wire m_axis_tvalid;
  wire mode_change;
  wire mode_change_reg;
  wire mode_change_sig_reset;
  wire mode_change_sig_reset_i_1_n_0;
  wire overlap_A;
  wire s_axis_aclk;
  wire [3:1]state;
  wire [1:0]state__0;
  wire [3:0]state__0_0;
  wire [11:0]temp_out;
  wire \temp_out[11]_i_1_n_0 ;
  wire \timer_cntr[0]_i_2_n_0 ;
  wire \timer_cntr[0]_i_3_n_0 ;
  wire \timer_cntr[0]_i_4_n_0 ;
  wire \timer_cntr[0]_i_5_n_0 ;
  wire \timer_cntr[0]_i_6_n_0 ;
  wire \timer_cntr[12]_i_2_n_0 ;
  wire \timer_cntr[12]_i_3_n_0 ;
  wire \timer_cntr[12]_i_4_n_0 ;
  wire \timer_cntr[12]_i_5_n_0 ;
  wire \timer_cntr[4]_i_2_n_0 ;
  wire \timer_cntr[4]_i_3_n_0 ;
  wire \timer_cntr[4]_i_4_n_0 ;
  wire \timer_cntr[4]_i_5_n_0 ;
  wire \timer_cntr[4]_i_6_n_0 ;
  wire \timer_cntr[8]_i_2_n_0 ;
  wire \timer_cntr[8]_i_3_n_0 ;
  wire \timer_cntr[8]_i_4_n_0 ;
  wire \timer_cntr[8]_i_5_n_0 ;
  wire [15:0]timer_cntr_reg;
  wire \timer_cntr_reg[0]_i_1_n_0 ;
  wire \timer_cntr_reg[0]_i_1_n_1 ;
  wire \timer_cntr_reg[0]_i_1_n_2 ;
  wire \timer_cntr_reg[0]_i_1_n_3 ;
  wire \timer_cntr_reg[0]_i_1_n_4 ;
  wire \timer_cntr_reg[0]_i_1_n_5 ;
  wire \timer_cntr_reg[0]_i_1_n_6 ;
  wire \timer_cntr_reg[0]_i_1_n_7 ;
  wire \timer_cntr_reg[12]_i_1_n_1 ;
  wire \timer_cntr_reg[12]_i_1_n_2 ;
  wire \timer_cntr_reg[12]_i_1_n_3 ;
  wire \timer_cntr_reg[12]_i_1_n_4 ;
  wire \timer_cntr_reg[12]_i_1_n_5 ;
  wire \timer_cntr_reg[12]_i_1_n_6 ;
  wire \timer_cntr_reg[12]_i_1_n_7 ;
  wire \timer_cntr_reg[4]_i_1_n_0 ;
  wire \timer_cntr_reg[4]_i_1_n_1 ;
  wire \timer_cntr_reg[4]_i_1_n_2 ;
  wire \timer_cntr_reg[4]_i_1_n_3 ;
  wire \timer_cntr_reg[4]_i_1_n_4 ;
  wire \timer_cntr_reg[4]_i_1_n_5 ;
  wire \timer_cntr_reg[4]_i_1_n_6 ;
  wire \timer_cntr_reg[4]_i_1_n_7 ;
  wire \timer_cntr_reg[8]_i_1_n_0 ;
  wire \timer_cntr_reg[8]_i_1_n_1 ;
  wire \timer_cntr_reg[8]_i_1_n_2 ;
  wire \timer_cntr_reg[8]_i_1_n_3 ;
  wire \timer_cntr_reg[8]_i_1_n_4 ;
  wire \timer_cntr_reg[8]_i_1_n_5 ;
  wire \timer_cntr_reg[8]_i_1_n_6 ;
  wire \timer_cntr_reg[8]_i_1_n_7 ;
  wire valid_data_wren_i_1_n_0;
  wire valid_data_wren_reg_0;
  wire wren_fifo;
  wire NLW_FIFO18E1_inst_data_ALMOSTEMPTY_UNCONNECTED;
  wire NLW_FIFO18E1_inst_data_FULL_UNCONNECTED;
  wire NLW_FIFO18E1_inst_data_RDERR_UNCONNECTED;
  wire NLW_FIFO18E1_inst_data_WRERR_UNCONNECTED;
  wire [31:16]NLW_FIFO18E1_inst_data_DO_UNCONNECTED;
  wire [3:0]NLW_FIFO18E1_inst_data_DOP_UNCONNECTED;
  wire [11:0]NLW_FIFO18E1_inst_data_RDCOUNT_UNCONNECTED;
  wire [11:0]NLW_FIFO18E1_inst_data_WRCOUNT_UNCONNECTED;
  wire NLW_FIFO18E1_inst_tid_ALMOSTEMPTY_UNCONNECTED;
  wire NLW_FIFO18E1_inst_tid_ALMOSTFULL_UNCONNECTED;
  wire NLW_FIFO18E1_inst_tid_EMPTY_UNCONNECTED;
  wire NLW_FIFO18E1_inst_tid_FULL_UNCONNECTED;
  wire NLW_FIFO18E1_inst_tid_RDERR_UNCONNECTED;
  wire NLW_FIFO18E1_inst_tid_WRERR_UNCONNECTED;
  wire [31:5]NLW_FIFO18E1_inst_tid_DO_UNCONNECTED;
  wire [3:0]NLW_FIFO18E1_inst_tid_DOP_UNCONNECTED;
  wire [11:0]NLW_FIFO18E1_inst_tid_RDCOUNT_UNCONNECTED;
  wire [11:0]NLW_FIFO18E1_inst_tid_WRCOUNT_UNCONNECTED;
  wire [3:3]\NLW_timer_cntr_reg[12]_i_1_CO_UNCONNECTED ;

  assign daddr_in_2_sp_1 = daddr_in_2_sn_1;
  (* box_type = "PRIMITIVE" *) 
  FIFO18E1 #(
    .ALMOST_EMPTY_OFFSET(13'h0006),
    .ALMOST_FULL_OFFSET(13'h03F9),
    .DATA_WIDTH(18),
    .DO_REG(1),
    .EN_SYN("FALSE"),
    .FIFO_MODE("FIFO18"),
    .FIRST_WORD_FALL_THROUGH("TRUE"),
    .INIT(36'h000000000),
    .IS_RDCLK_INVERTED(1'b0),
    .IS_RDEN_INVERTED(1'b0),
    .IS_RSTREG_INVERTED(1'b0),
    .IS_RST_INVERTED(1'b0),
    .IS_WRCLK_INVERTED(1'b0),
    .IS_WREN_INVERTED(1'b0),
    .SIM_DEVICE("7SERIES"),
    .SRVAL(36'h000000000)) 
    FIFO18E1_inst_data
       (.ALMOSTEMPTY(NLW_FIFO18E1_inst_data_ALMOSTEMPTY_UNCONNECTED),
        .ALMOSTFULL(almost_full),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,Q}),
        .DIP({1'b0,1'b0,1'b0,1'b0}),
        .DO({NLW_FIFO18E1_inst_data_DO_UNCONNECTED[31:16],m_axis_tdata}),
        .DOP(NLW_FIFO18E1_inst_data_DOP_UNCONNECTED[3:0]),
        .EMPTY(fifo_empty),
        .FULL(NLW_FIFO18E1_inst_data_FULL_UNCONNECTED),
        .RDCLK(s_axis_aclk),
        .RDCOUNT(NLW_FIFO18E1_inst_data_RDCOUNT_UNCONNECTED[11:0]),
        .RDEN(FIFO18E1_inst_data_i_1_n_0),
        .RDERR(NLW_FIFO18E1_inst_data_RDERR_UNCONNECTED),
        .REGCE(1'b1),
        .RST(m_axis_reset),
        .RSTREG(1'b0),
        .WRCLK(m_axis_aclk),
        .WRCOUNT(NLW_FIFO18E1_inst_data_WRCOUNT_UNCONNECTED[11:0]),
        .WREN(wren_fifo),
        .WRERR(NLW_FIFO18E1_inst_data_WRERR_UNCONNECTED));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT2 #(
    .INIT(4'h2)) 
    FIFO18E1_inst_data_i_1
       (.I0(m_axis_tready),
        .I1(fifo_empty),
        .O(FIFO18E1_inst_data_i_1_n_0));
  (* box_type = "PRIMITIVE" *) 
  FIFO18E1 #(
    .ALMOST_EMPTY_OFFSET(13'h0006),
    .ALMOST_FULL_OFFSET(13'h03F9),
    .DATA_WIDTH(18),
    .DO_REG(1),
    .EN_SYN("FALSE"),
    .FIFO_MODE("FIFO18"),
    .FIRST_WORD_FALL_THROUGH("TRUE"),
    .INIT(36'h000000000),
    .IS_RDCLK_INVERTED(1'b0),
    .IS_RDEN_INVERTED(1'b0),
    .IS_RSTREG_INVERTED(1'b0),
    .IS_RST_INVERTED(1'b0),
    .IS_WRCLK_INVERTED(1'b0),
    .IS_WREN_INVERTED(1'b0),
    .SIM_DEVICE("7SERIES"),
    .SRVAL(36'h000000000)) 
    FIFO18E1_inst_tid
       (.ALMOSTEMPTY(NLW_FIFO18E1_inst_tid_ALMOSTEMPTY_UNCONNECTED),
        .ALMOSTFULL(NLW_FIFO18E1_inst_tid_ALMOSTFULL_UNCONNECTED),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,\channel_id_reg[6]_0 [5],1'b0,\channel_id_reg[6]_0 [4:0]}),
        .DIP({1'b0,1'b0,1'b0,1'b0}),
        .DO({NLW_FIFO18E1_inst_tid_DO_UNCONNECTED[31:5],m_axis_tid}),
        .DOP(NLW_FIFO18E1_inst_tid_DOP_UNCONNECTED[3:0]),
        .EMPTY(NLW_FIFO18E1_inst_tid_EMPTY_UNCONNECTED),
        .FULL(NLW_FIFO18E1_inst_tid_FULL_UNCONNECTED),
        .RDCLK(s_axis_aclk),
        .RDCOUNT(NLW_FIFO18E1_inst_tid_RDCOUNT_UNCONNECTED[11:0]),
        .RDEN(FIFO18E1_inst_data_i_1_n_0),
        .RDERR(NLW_FIFO18E1_inst_tid_RDERR_UNCONNECTED),
        .REGCE(1'b1),
        .RST(m_axis_reset),
        .RSTREG(1'b0),
        .WRCLK(m_axis_aclk),
        .WRCOUNT(NLW_FIFO18E1_inst_tid_WRCOUNT_UNCONNECTED[11:0]),
        .WREN(wren_fifo),
        .WRERR(NLW_FIFO18E1_inst_tid_WRERR_UNCONNECTED));
  LUT6 #(
    .INIT(64'h0135313501050105)) 
    \FSM_sequential_state[0]_i_1__0 
       (.I0(\FSM_sequential_state_reg[0]_0 ),
        .I1(state[3]),
        .I2(state[1]),
        .I3(mode_change),
        .I4(state[2]),
        .I5(\FSM_sequential_state[0]_i_2_n_0 ),
        .O(state__0_0[0]));
  LUT6 #(
    .INIT(64'h2F0F2FFF2FFF2F0F)) 
    \FSM_sequential_state[0]_i_2 
       (.I0(m_axis_aclk_0),
        .I1(mode_change),
        .I2(\FSM_sequential_state_reg[1]_0 ),
        .I3(\FSM_sequential_state_reg[0]_0 ),
        .I4(Q[14]),
        .I5(Q[15]),
        .O(\FSM_sequential_state[0]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hAB)) 
    \FSM_sequential_state[0]_i_3 
       (.I0(bbusy_A),
        .I1(den_in),
        .I2(\FSM_sequential_state_reg[0]_1 ),
        .O(busy_o_reg_0));
  LUT6 #(
    .INIT(64'h001FAAAA0010AAAA)) 
    \FSM_sequential_state[1]_i_1__0 
       (.I0(\FSM_sequential_state_reg[0]_0 ),
        .I1(mode_change),
        .I2(state[2]),
        .I3(state[3]),
        .I4(state[1]),
        .I5(\FSM_sequential_state_reg[1]_1 ),
        .O(state__0_0[1]));
  LUT4 #(
    .INIT(16'h1014)) 
    \FSM_sequential_state[2]_i_1 
       (.I0(state[3]),
        .I1(state[1]),
        .I2(state[2]),
        .I3(\FSM_sequential_state_reg[2]_0 ),
        .O(state__0_0[2]));
  LUT6 #(
    .INIT(64'hFFFFFFFFF1110000)) 
    \FSM_sequential_state[3]_i_1 
       (.I0(\FSM_sequential_state[3]_i_3_n_0 ),
        .I1(\FSM_sequential_state[3]_i_4_n_0 ),
        .I2(mode_change),
        .I3(drdy_i),
        .I4(\FSM_sequential_state[3]_i_5_n_0 ),
        .I5(\FSM_sequential_state[3]_i_6_n_0 ),
        .O(\FSM_sequential_state[3]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \FSM_sequential_state[3]_i_10 
       (.I0(timer_cntr_reg[10]),
        .I1(timer_cntr_reg[9]),
        .I2(timer_cntr_reg[11]),
        .I3(timer_cntr_reg[8]),
        .O(\FSM_sequential_state[3]_i_10_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'h53)) 
    \FSM_sequential_state[3]_i_11 
       (.I0(state[1]),
        .I1(state[2]),
        .I2(state[3]),
        .O(\FSM_sequential_state_reg[1]_0 ));
  LUT6 #(
    .INIT(64'h002FBB000000BB00)) 
    \FSM_sequential_state[3]_i_2 
       (.I0(\FSM_sequential_state_reg[0]_0 ),
        .I1(mode_change),
        .I2(state[2]),
        .I3(state[3]),
        .I4(state[1]),
        .I5(\FSM_sequential_state_reg[3]_0 ),
        .O(state__0_0[3]));
  LUT5 #(
    .INIT(32'hFFFFFFF8)) 
    \FSM_sequential_state[3]_i_3 
       (.I0(timer_cntr_reg[3]),
        .I1(\FSM_sequential_state[3]_i_8_n_0 ),
        .I2(drp_rdwr_status),
        .I3(mode_change),
        .I4(eoc_out),
        .O(\FSM_sequential_state[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \FSM_sequential_state[3]_i_4 
       (.I0(timer_cntr_reg[14]),
        .I1(timer_cntr_reg[15]),
        .I2(timer_cntr_reg[12]),
        .I3(timer_cntr_reg[13]),
        .I4(\FSM_sequential_state[3]_i_9_n_0 ),
        .I5(\FSM_sequential_state[3]_i_10_n_0 ),
        .O(\FSM_sequential_state[3]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT4 #(
    .INIT(16'h1F11)) 
    \FSM_sequential_state[3]_i_5 
       (.I0(state[2]),
        .I1(state[1]),
        .I2(state[3]),
        .I3(\FSM_sequential_state_reg[0]_0 ),
        .O(\FSM_sequential_state[3]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h031F001033F330F3)) 
    \FSM_sequential_state[3]_i_6 
       (.I0(m_axis_aclk_0),
        .I1(state[3]),
        .I2(\FSM_sequential_state_reg[0]_0 ),
        .I3(state[2]),
        .I4(drdy_i),
        .I5(state[1]),
        .O(\FSM_sequential_state[3]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'hFE)) 
    \FSM_sequential_state[3]_i_8 
       (.I0(timer_cntr_reg[0]),
        .I1(timer_cntr_reg[2]),
        .I2(timer_cntr_reg[1]),
        .O(\FSM_sequential_state[3]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \FSM_sequential_state[3]_i_9 
       (.I0(timer_cntr_reg[7]),
        .I1(timer_cntr_reg[6]),
        .I2(timer_cntr_reg[5]),
        .I3(timer_cntr_reg[4]),
        .O(\FSM_sequential_state[3]_i_9_n_0 ));
  (* FSM_ENCODED_STATES = "wait_ind_adc:0111,wait_mode_change:0000,wait_seq_s_ch:1000,rd_ctrl_reg_temp:1010,rd_ctrl_reg_41:0010,rd_en_ctrl_reg_41:0001,rd_b_reg_cmd:0101,rd_en_ctrl_reg_temp:1001,rd_b_reg:0110,rd_a_reg:0100,wait_sim_samp:0011" *) 
  FDCE \FSM_sequential_state_reg[0] 
       (.C(m_axis_aclk),
        .CE(\FSM_sequential_state[3]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(state__0_0[0]),
        .Q(\FSM_sequential_state_reg[0]_0 ));
  (* FSM_ENCODED_STATES = "wait_ind_adc:0111,wait_mode_change:0000,wait_seq_s_ch:1000,rd_ctrl_reg_temp:1010,rd_ctrl_reg_41:0010,rd_en_ctrl_reg_41:0001,rd_b_reg_cmd:0101,rd_en_ctrl_reg_temp:1001,rd_b_reg:0110,rd_a_reg:0100,wait_sim_samp:0011" *) 
  FDCE \FSM_sequential_state_reg[1] 
       (.C(m_axis_aclk),
        .CE(\FSM_sequential_state[3]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(state__0_0[1]),
        .Q(state[1]));
  (* FSM_ENCODED_STATES = "wait_ind_adc:0111,wait_mode_change:0000,wait_seq_s_ch:1000,rd_ctrl_reg_temp:1010,rd_ctrl_reg_41:0010,rd_en_ctrl_reg_41:0001,rd_b_reg_cmd:0101,rd_en_ctrl_reg_temp:1001,rd_b_reg:0110,rd_a_reg:0100,wait_sim_samp:0011" *) 
  FDCE \FSM_sequential_state_reg[2] 
       (.C(m_axis_aclk),
        .CE(\FSM_sequential_state[3]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(state__0_0[2]),
        .Q(state[2]));
  (* FSM_ENCODED_STATES = "wait_ind_adc:0111,wait_mode_change:0000,wait_seq_s_ch:1000,rd_ctrl_reg_temp:1010,rd_ctrl_reg_41:0010,rd_en_ctrl_reg_41:0001,rd_b_reg_cmd:0101,rd_en_ctrl_reg_temp:1001,rd_b_reg:0110,rd_a_reg:0100,wait_sim_samp:0011" *) 
  FDCE \FSM_sequential_state_reg[3] 
       (.C(m_axis_aclk),
        .CE(\FSM_sequential_state[3]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(state__0_0[3]),
        .Q(state[3]));
  LUT6 #(
    .INIT(64'hFFFA55FA00001000)) 
    busy_o_i_1
       (.I0(state[2]),
        .I1(m_axis_aclk_0),
        .I2(\FSM_sequential_state_reg[0]_0 ),
        .I3(state[1]),
        .I4(state[3]),
        .I5(bbusy_A),
        .O(busy_o_i_1_n_0));
  LUT2 #(
    .INIT(4'h7)) 
    busy_o_i_2
       (.I0(eoc_out),
        .I1(channel_out[4]),
        .O(m_axis_aclk_0));
  FDCE busy_o_reg
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(busy_o_i_1_n_0),
        .Q(bbusy_A));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT5 #(
    .INIT(32'h01FF0003)) 
    \channel_id[0]_i_1 
       (.I0(\FSM_sequential_state_reg[0]_0 ),
        .I1(state[2]),
        .I2(state[1]),
        .I3(state[3]),
        .I4(channel_out[0]),
        .O(channel_id[0]));
  LUT5 #(
    .INIT(32'h222022AA)) 
    \channel_id[1]_i_1 
       (.I0(channel_out[1]),
        .I1(state[3]),
        .I2(state[1]),
        .I3(state[2]),
        .I4(\FSM_sequential_state_reg[0]_0 ),
        .O(channel_id[1]));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT5 #(
    .INIT(32'h222022AA)) 
    \channel_id[2]_i_1 
       (.I0(channel_out[2]),
        .I1(state[3]),
        .I2(state[1]),
        .I3(state[2]),
        .I4(\FSM_sequential_state_reg[0]_0 ),
        .O(channel_id[2]));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT5 #(
    .INIT(32'h212021AA)) 
    \channel_id[3]_i_1 
       (.I0(channel_out[3]),
        .I1(state[3]),
        .I2(state[1]),
        .I3(state[2]),
        .I4(\FSM_sequential_state_reg[0]_0 ),
        .O(channel_id[3]));
  LUT6 #(
    .INIT(64'h0044C3C40044CCC4)) 
    \channel_id[4]_i_1 
       (.I0(\FSM_sequential_state_reg[0]_0 ),
        .I1(channel_out[4]),
        .I2(state[1]),
        .I3(state[2]),
        .I4(state[3]),
        .I5(channel_out[3]),
        .O(channel_id[4]));
  LUT4 #(
    .INIT(16'h222E)) 
    \channel_id[6]_i_1 
       (.I0(\FSM_sequential_state_reg[0]_0 ),
        .I1(state[3]),
        .I2(state[2]),
        .I3(state[1]),
        .O(\channel_id[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \channel_id[6]_i_2 
       (.I0(state[2]),
        .I1(state[1]),
        .I2(state[3]),
        .O(channel_id[6]));
  FDCE \channel_id_reg[0] 
       (.C(m_axis_aclk),
        .CE(\channel_id[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(channel_id[0]),
        .Q(\channel_id_reg[6]_0 [0]));
  FDCE \channel_id_reg[1] 
       (.C(m_axis_aclk),
        .CE(\channel_id[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(channel_id[1]),
        .Q(\channel_id_reg[6]_0 [1]));
  FDCE \channel_id_reg[2] 
       (.C(m_axis_aclk),
        .CE(\channel_id[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(channel_id[2]),
        .Q(\channel_id_reg[6]_0 [2]));
  FDCE \channel_id_reg[3] 
       (.C(m_axis_aclk),
        .CE(\channel_id[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(channel_id[3]),
        .Q(\channel_id_reg[6]_0 [3]));
  FDCE \channel_id_reg[4] 
       (.C(m_axis_aclk),
        .CE(\channel_id[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(channel_id[4]),
        .Q(\channel_id_reg[6]_0 [4]));
  FDCE \channel_id_reg[6] 
       (.C(m_axis_aclk),
        .CE(\channel_id[6]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(channel_id[6]),
        .Q(\channel_id_reg[6]_0 [5]));
  LUT6 #(
    .INIT(64'hF8FCC8EC080C08EC)) 
    den_o_i_1
       (.I0(drp_rdwr_status0),
        .I1(\FSM_sequential_state_reg[0]_0 ),
        .I2(state[3]),
        .I3(state[1]),
        .I4(state[2]),
        .I5(den_A),
        .O(den_o_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT2 #(
    .INIT(4'h2)) 
    den_o_i_2
       (.I0(eoc_out),
        .I1(almost_full),
        .O(drp_rdwr_status0));
  FDCE den_o_reg
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(den_o_i_1_n_0),
        .Q(den_A));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT5 #(
    .INIT(32'h00CCAAC8)) 
    den_reg_i_1
       (.I0(den_A),
        .I1(den_in),
        .I2(bbusy_A),
        .I3(state__0[1]),
        .I4(state__0[0]),
        .O(den_reg));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT4 #(
    .INIT(16'h7530)) 
    drp_rdwr_status_i_1
       (.I0(drdy_i),
        .I1(almost_full),
        .I2(eoc_out),
        .I3(drp_rdwr_status),
        .O(drp_rdwr_status_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    drp_rdwr_status_reg
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(drp_rdwr_status_i_1_n_0),
        .Q(drp_rdwr_status));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT1 #(
    .INIT(2'h1)) 
    m_axis_tvalid_INST_0
       (.I0(fifo_empty),
        .O(m_axis_tvalid));
  LUT6 #(
    .INIT(64'h0200FFFF02000200)) 
    mode_change_i_1
       (.I0(mode_change_reg),
        .I1(daddr_in[2]),
        .I2(daddr_in[1]),
        .I3(daddr_in[0]),
        .I4(mode_change_sig_reset),
        .I5(mode_change),
        .O(daddr_in_2_sn_1));
  LUT5 #(
    .INIT(32'hFFFD0001)) 
    mode_change_sig_reset_i_1
       (.I0(\FSM_sequential_state_reg[0]_0 ),
        .I1(state[2]),
        .I2(state[1]),
        .I3(state[3]),
        .I4(mode_change_sig_reset),
        .O(mode_change_sig_reset_i_1_n_0));
  FDCE mode_change_sig_reset_reg
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(mode_change_sig_reset_i_1_n_0),
        .Q(mode_change_sig_reset));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT4 #(
    .INIT(16'h00C8)) 
    overlap_A_i_2
       (.I0(bbusy_A),
        .I1(den_A),
        .I2(state__0[1]),
        .I3(state__0[0]),
        .O(overlap_A));
  LUT5 #(
    .INIT(32'h10000000)) 
    \temp_out[11]_i_1 
       (.I0(\FSM_sequential_state_reg[0]_0 ),
        .I1(state[2]),
        .I2(drdy_i),
        .I3(state[1]),
        .I4(state[3]),
        .O(\temp_out[11]_i_1_n_0 ));
  FDCE \temp_out_reg[0] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(Q[4]),
        .Q(temp_out[0]));
  FDCE \temp_out_reg[10] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(Q[14]),
        .Q(temp_out[10]));
  FDCE \temp_out_reg[11] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(Q[15]),
        .Q(temp_out[11]));
  FDCE \temp_out_reg[1] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(Q[5]),
        .Q(temp_out[1]));
  FDCE \temp_out_reg[2] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(Q[6]),
        .Q(temp_out[2]));
  FDCE \temp_out_reg[3] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(Q[7]),
        .Q(temp_out[3]));
  FDCE \temp_out_reg[4] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(Q[8]),
        .Q(temp_out[4]));
  FDCE \temp_out_reg[5] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(Q[9]),
        .Q(temp_out[5]));
  FDCE \temp_out_reg[6] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(Q[10]),
        .Q(temp_out[6]));
  FDCE \temp_out_reg[7] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(Q[11]),
        .Q(temp_out[7]));
  FDCE \temp_out_reg[8] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(Q[12]),
        .Q(temp_out[8]));
  FDCE \temp_out_reg[9] 
       (.C(m_axis_aclk),
        .CE(\temp_out[11]_i_1_n_0 ),
        .CLR(m_axis_reset),
        .D(Q[13]),
        .Q(temp_out[9]));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \timer_cntr[0]_i_2 
       (.I0(timer_cntr_reg[3]),
        .I1(timer_cntr_reg[0]),
        .I2(timer_cntr_reg[2]),
        .I3(timer_cntr_reg[1]),
        .I4(\FSM_sequential_state[3]_i_4_n_0 ),
        .O(\timer_cntr[0]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \timer_cntr[0]_i_3 
       (.I0(timer_cntr_reg[3]),
        .O(\timer_cntr[0]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h0F0F0F0E)) 
    \timer_cntr[0]_i_4 
       (.I0(\FSM_sequential_state[3]_i_4_n_0 ),
        .I1(timer_cntr_reg[1]),
        .I2(timer_cntr_reg[2]),
        .I3(timer_cntr_reg[0]),
        .I4(timer_cntr_reg[3]),
        .O(\timer_cntr[0]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h33333332)) 
    \timer_cntr[0]_i_5 
       (.I0(\FSM_sequential_state[3]_i_4_n_0 ),
        .I1(timer_cntr_reg[1]),
        .I2(timer_cntr_reg[2]),
        .I3(timer_cntr_reg[0]),
        .I4(timer_cntr_reg[3]),
        .O(\timer_cntr[0]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h00FF00FE)) 
    \timer_cntr[0]_i_6 
       (.I0(\FSM_sequential_state[3]_i_4_n_0 ),
        .I1(timer_cntr_reg[1]),
        .I2(timer_cntr_reg[2]),
        .I3(timer_cntr_reg[0]),
        .I4(timer_cntr_reg[3]),
        .O(\timer_cntr[0]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FFFFFFFE)) 
    \timer_cntr[12]_i_2 
       (.I0(\FSM_sequential_state[3]_i_4_n_0 ),
        .I1(timer_cntr_reg[1]),
        .I2(timer_cntr_reg[2]),
        .I3(timer_cntr_reg[0]),
        .I4(timer_cntr_reg[3]),
        .I5(timer_cntr_reg[15]),
        .O(\timer_cntr[12]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h5555555555555556)) 
    \timer_cntr[12]_i_3 
       (.I0(timer_cntr_reg[14]),
        .I1(\FSM_sequential_state[3]_i_4_n_0 ),
        .I2(timer_cntr_reg[1]),
        .I3(timer_cntr_reg[2]),
        .I4(timer_cntr_reg[0]),
        .I5(timer_cntr_reg[3]),
        .O(\timer_cntr[12]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h5555555555555556)) 
    \timer_cntr[12]_i_4 
       (.I0(timer_cntr_reg[13]),
        .I1(\FSM_sequential_state[3]_i_4_n_0 ),
        .I2(timer_cntr_reg[1]),
        .I3(timer_cntr_reg[2]),
        .I4(timer_cntr_reg[0]),
        .I5(timer_cntr_reg[3]),
        .O(\timer_cntr[12]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h5555555555555556)) 
    \timer_cntr[12]_i_5 
       (.I0(timer_cntr_reg[12]),
        .I1(\FSM_sequential_state[3]_i_4_n_0 ),
        .I2(timer_cntr_reg[1]),
        .I3(timer_cntr_reg[2]),
        .I4(timer_cntr_reg[0]),
        .I5(timer_cntr_reg[3]),
        .O(\timer_cntr[12]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \timer_cntr[4]_i_2 
       (.I0(timer_cntr_reg[3]),
        .I1(timer_cntr_reg[0]),
        .I2(timer_cntr_reg[2]),
        .I3(timer_cntr_reg[1]),
        .I4(\FSM_sequential_state[3]_i_4_n_0 ),
        .O(\timer_cntr[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h5555555555555557)) 
    \timer_cntr[4]_i_3 
       (.I0(timer_cntr_reg[7]),
        .I1(\FSM_sequential_state[3]_i_4_n_0 ),
        .I2(timer_cntr_reg[1]),
        .I3(timer_cntr_reg[2]),
        .I4(timer_cntr_reg[0]),
        .I5(timer_cntr_reg[3]),
        .O(\timer_cntr[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h5555555555555557)) 
    \timer_cntr[4]_i_4 
       (.I0(timer_cntr_reg[6]),
        .I1(\FSM_sequential_state[3]_i_4_n_0 ),
        .I2(timer_cntr_reg[1]),
        .I3(timer_cntr_reg[2]),
        .I4(timer_cntr_reg[0]),
        .I5(timer_cntr_reg[3]),
        .O(\timer_cntr[4]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h5555555555555557)) 
    \timer_cntr[4]_i_5 
       (.I0(timer_cntr_reg[5]),
        .I1(\FSM_sequential_state[3]_i_4_n_0 ),
        .I2(timer_cntr_reg[1]),
        .I3(timer_cntr_reg[2]),
        .I4(timer_cntr_reg[0]),
        .I5(timer_cntr_reg[3]),
        .O(\timer_cntr[4]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h5555555555555556)) 
    \timer_cntr[4]_i_6 
       (.I0(timer_cntr_reg[4]),
        .I1(\FSM_sequential_state[3]_i_4_n_0 ),
        .I2(timer_cntr_reg[1]),
        .I3(timer_cntr_reg[2]),
        .I4(timer_cntr_reg[0]),
        .I5(timer_cntr_reg[3]),
        .O(\timer_cntr[4]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h5555555555555556)) 
    \timer_cntr[8]_i_2 
       (.I0(timer_cntr_reg[11]),
        .I1(\FSM_sequential_state[3]_i_4_n_0 ),
        .I2(timer_cntr_reg[1]),
        .I3(timer_cntr_reg[2]),
        .I4(timer_cntr_reg[0]),
        .I5(timer_cntr_reg[3]),
        .O(\timer_cntr[8]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h5555555555555556)) 
    \timer_cntr[8]_i_3 
       (.I0(timer_cntr_reg[10]),
        .I1(\FSM_sequential_state[3]_i_4_n_0 ),
        .I2(timer_cntr_reg[1]),
        .I3(timer_cntr_reg[2]),
        .I4(timer_cntr_reg[0]),
        .I5(timer_cntr_reg[3]),
        .O(\timer_cntr[8]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h5555555555555557)) 
    \timer_cntr[8]_i_4 
       (.I0(timer_cntr_reg[9]),
        .I1(\FSM_sequential_state[3]_i_4_n_0 ),
        .I2(timer_cntr_reg[1]),
        .I3(timer_cntr_reg[2]),
        .I4(timer_cntr_reg[0]),
        .I5(timer_cntr_reg[3]),
        .O(\timer_cntr[8]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h5555555555555557)) 
    \timer_cntr[8]_i_5 
       (.I0(timer_cntr_reg[8]),
        .I1(\FSM_sequential_state[3]_i_4_n_0 ),
        .I2(timer_cntr_reg[1]),
        .I3(timer_cntr_reg[2]),
        .I4(timer_cntr_reg[0]),
        .I5(timer_cntr_reg[3]),
        .O(\timer_cntr[8]_i_5_n_0 ));
  FDCE \timer_cntr_reg[0] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[0]_i_1_n_7 ),
        .Q(timer_cntr_reg[0]));
  CARRY4 \timer_cntr_reg[0]_i_1 
       (.CI(1'b0),
        .CO({\timer_cntr_reg[0]_i_1_n_0 ,\timer_cntr_reg[0]_i_1_n_1 ,\timer_cntr_reg[0]_i_1_n_2 ,\timer_cntr_reg[0]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\timer_cntr[0]_i_2_n_0 ,timer_cntr_reg[2:0]}),
        .O({\timer_cntr_reg[0]_i_1_n_4 ,\timer_cntr_reg[0]_i_1_n_5 ,\timer_cntr_reg[0]_i_1_n_6 ,\timer_cntr_reg[0]_i_1_n_7 }),
        .S({\timer_cntr[0]_i_3_n_0 ,\timer_cntr[0]_i_4_n_0 ,\timer_cntr[0]_i_5_n_0 ,\timer_cntr[0]_i_6_n_0 }));
  FDCE \timer_cntr_reg[10] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[8]_i_1_n_5 ),
        .Q(timer_cntr_reg[10]));
  FDCE \timer_cntr_reg[11] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[8]_i_1_n_4 ),
        .Q(timer_cntr_reg[11]));
  FDCE \timer_cntr_reg[12] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[12]_i_1_n_7 ),
        .Q(timer_cntr_reg[12]));
  CARRY4 \timer_cntr_reg[12]_i_1 
       (.CI(\timer_cntr_reg[8]_i_1_n_0 ),
        .CO({\NLW_timer_cntr_reg[12]_i_1_CO_UNCONNECTED [3],\timer_cntr_reg[12]_i_1_n_1 ,\timer_cntr_reg[12]_i_1_n_2 ,\timer_cntr_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,timer_cntr_reg[14:12]}),
        .O({\timer_cntr_reg[12]_i_1_n_4 ,\timer_cntr_reg[12]_i_1_n_5 ,\timer_cntr_reg[12]_i_1_n_6 ,\timer_cntr_reg[12]_i_1_n_7 }),
        .S({\timer_cntr[12]_i_2_n_0 ,\timer_cntr[12]_i_3_n_0 ,\timer_cntr[12]_i_4_n_0 ,\timer_cntr[12]_i_5_n_0 }));
  FDCE \timer_cntr_reg[13] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[12]_i_1_n_6 ),
        .Q(timer_cntr_reg[13]));
  FDCE \timer_cntr_reg[14] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[12]_i_1_n_5 ),
        .Q(timer_cntr_reg[14]));
  FDCE \timer_cntr_reg[15] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[12]_i_1_n_4 ),
        .Q(timer_cntr_reg[15]));
  FDCE \timer_cntr_reg[1] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[0]_i_1_n_6 ),
        .Q(timer_cntr_reg[1]));
  FDCE \timer_cntr_reg[2] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[0]_i_1_n_5 ),
        .Q(timer_cntr_reg[2]));
  FDCE \timer_cntr_reg[3] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[0]_i_1_n_4 ),
        .Q(timer_cntr_reg[3]));
  FDCE \timer_cntr_reg[4] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[4]_i_1_n_7 ),
        .Q(timer_cntr_reg[4]));
  CARRY4 \timer_cntr_reg[4]_i_1 
       (.CI(\timer_cntr_reg[0]_i_1_n_0 ),
        .CO({\timer_cntr_reg[4]_i_1_n_0 ,\timer_cntr_reg[4]_i_1_n_1 ,\timer_cntr_reg[4]_i_1_n_2 ,\timer_cntr_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\timer_cntr[4]_i_2_n_0 ,\timer_cntr[4]_i_2_n_0 ,\timer_cntr[4]_i_2_n_0 ,timer_cntr_reg[4]}),
        .O({\timer_cntr_reg[4]_i_1_n_4 ,\timer_cntr_reg[4]_i_1_n_5 ,\timer_cntr_reg[4]_i_1_n_6 ,\timer_cntr_reg[4]_i_1_n_7 }),
        .S({\timer_cntr[4]_i_3_n_0 ,\timer_cntr[4]_i_4_n_0 ,\timer_cntr[4]_i_5_n_0 ,\timer_cntr[4]_i_6_n_0 }));
  FDCE \timer_cntr_reg[5] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[4]_i_1_n_6 ),
        .Q(timer_cntr_reg[5]));
  FDCE \timer_cntr_reg[6] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[4]_i_1_n_5 ),
        .Q(timer_cntr_reg[6]));
  FDCE \timer_cntr_reg[7] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[4]_i_1_n_4 ),
        .Q(timer_cntr_reg[7]));
  FDCE \timer_cntr_reg[8] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[8]_i_1_n_7 ),
        .Q(timer_cntr_reg[8]));
  CARRY4 \timer_cntr_reg[8]_i_1 
       (.CI(\timer_cntr_reg[4]_i_1_n_0 ),
        .CO({\timer_cntr_reg[8]_i_1_n_0 ,\timer_cntr_reg[8]_i_1_n_1 ,\timer_cntr_reg[8]_i_1_n_2 ,\timer_cntr_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({timer_cntr_reg[11:10],\timer_cntr[4]_i_2_n_0 ,\timer_cntr[4]_i_2_n_0 }),
        .O({\timer_cntr_reg[8]_i_1_n_4 ,\timer_cntr_reg[8]_i_1_n_5 ,\timer_cntr_reg[8]_i_1_n_6 ,\timer_cntr_reg[8]_i_1_n_7 }),
        .S({\timer_cntr[8]_i_2_n_0 ,\timer_cntr[8]_i_3_n_0 ,\timer_cntr[8]_i_4_n_0 ,\timer_cntr[8]_i_5_n_0 }));
  FDCE \timer_cntr_reg[9] 
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(\timer_cntr_reg[8]_i_1_n_6 ),
        .Q(timer_cntr_reg[9]));
  LUT6 #(
    .INIT(64'hFFF3FFFC00000200)) 
    valid_data_wren_i_1
       (.I0(drdy_i),
        .I1(\FSM_sequential_state_reg[0]_0 ),
        .I2(state[2]),
        .I3(state[1]),
        .I4(state[3]),
        .I5(valid_data_wren_reg_0),
        .O(valid_data_wren_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    valid_data_wren_reg
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(valid_data_wren_i_1_n_0),
        .Q(valid_data_wren_reg_0));
endmodule

(* ORIG_REF_NAME = "xadc_wiz_0_axi_xadc" *) 
module xadc_wiz_0_xadc_wiz_0_axi_xadc
   (daddr_in,
    den_in,
    di_in,
    dwe_in,
    do_out,
    drdy_out,
    s_axis_aclk,
    m_axis_aclk,
    m_axis_resetn,
    m_axis_tdata,
    m_axis_tvalid,
    m_axis_tid,
    m_axis_tready,
    vauxp0,
    vauxn0,
    vauxp1,
    vauxn1,
    vauxp8,
    vauxn8,
    busy_out,
    channel_out,
    eoc_out,
    eos_out,
    ot_out,
    alarm_out,
    temp_out,
    vp_in,
    vn_in);
  input [6:0]daddr_in;
  input den_in;
  input [15:0]di_in;
  input dwe_in;
  output [15:0]do_out;
  output drdy_out;
  input s_axis_aclk;
  input m_axis_aclk;
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
  output busy_out;
  output [4:0]channel_out;
  output eoc_out;
  output eos_out;
  output ot_out;
  output [7:0]alarm_out;
  output [11:0]temp_out;
  input vp_in;
  input vn_in;

  wire [7:0]alarm_out;
  wire busy_out;
  wire [4:0]channel_out;
  wire [6:0]daddr_in;
  wire den_in;
  wire [15:0]di_in;
  wire [15:0]do_out;
  wire drdy_out;
  wire dwe_in;
  wire eoc_out;
  wire eos_out;
  wire m_axis_aclk;
  wire m_axis_resetn;
  wire [15:0]m_axis_tdata;
  wire [4:0]m_axis_tid;
  wire m_axis_tready;
  wire m_axis_tvalid;
  wire ot_out;
  wire s_axis_aclk;
  wire [11:0]temp_out;
  wire vauxn0;
  wire vauxn1;
  wire vauxn8;
  wire vauxp0;
  wire vauxp1;
  wire vauxp8;
  wire vn_in;
  wire vp_in;

  xadc_wiz_0_xadc_wiz_0_xadc_core_drp AXI_XADC_CORE_I
       (.VAUXN({vauxn8,vauxn1,vauxn0}),
        .VAUXP({vauxp8,vauxp1,vauxp0}),
        .alarm_out(alarm_out),
        .busy_out(busy_out),
        .channel_out(channel_out),
        .daddr_in(daddr_in),
        .den_in(den_in),
        .di_in(di_in),
        .do_out(do_out),
        .drdy_out(drdy_out),
        .dwe_in(dwe_in),
        .eoc_out(eoc_out),
        .eos_out(eos_out),
        .m_axis_aclk(m_axis_aclk),
        .m_axis_resetn(m_axis_resetn),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tid(m_axis_tid),
        .m_axis_tready(m_axis_tready),
        .m_axis_tvalid(m_axis_tvalid),
        .ot_out(ot_out),
        .s_axis_aclk(s_axis_aclk),
        .temp_out(temp_out),
        .vn_in(vn_in),
        .vp_in(vp_in));
endmodule

(* ORIG_REF_NAME = "xadc_wiz_0_xadc_core_drp" *) 
module xadc_wiz_0_xadc_wiz_0_xadc_core_drp
   (m_axis_tdata,
    m_axis_tid,
    busy_out,
    eoc_out,
    eos_out,
    ot_out,
    channel_out,
    alarm_out,
    temp_out,
    do_out,
    m_axis_tvalid,
    drdy_out,
    m_axis_tready,
    s_axis_aclk,
    m_axis_aclk,
    vn_in,
    vp_in,
    VAUXN,
    VAUXP,
    m_axis_resetn,
    daddr_in,
    den_in,
    dwe_in,
    di_in);
  output [15:0]m_axis_tdata;
  output [4:0]m_axis_tid;
  output busy_out;
  output eoc_out;
  output eos_out;
  output ot_out;
  output [4:0]channel_out;
  output [7:0]alarm_out;
  output [11:0]temp_out;
  output [15:0]do_out;
  output m_axis_tvalid;
  output drdy_out;
  input m_axis_tready;
  input s_axis_aclk;
  input m_axis_aclk;
  input vn_in;
  input vp_in;
  input [2:0]VAUXN;
  input [2:0]VAUXP;
  input m_axis_resetn;
  input [6:0]daddr_in;
  input den_in;
  input dwe_in;
  input [15:0]di_in;

  wire Inst_drp_arbiter_n_24;
  wire Inst_drp_arbiter_n_25;
  wire Inst_drp_arbiter_n_3;
  wire Inst_drp_arbiter_n_7;
  wire [2:0]VAUXN;
  wire [2:0]VAUXP;
  wire [7:0]alarm_out;
  wire axi4_stream_inst_n_29;
  wire axi4_stream_inst_n_31;
  wire axi4_stream_inst_n_32;
  wire axi4_stream_inst_n_35;
  wire axi4_stream_inst_n_36;
  wire bbusy_A;
  wire busy_out;
  wire [4:0]channel_out;
  wire [6:0]daddr_A;
  wire [6:0]daddr_C;
  wire [6:0]daddr_in;
  wire den_A;
  wire den_C;
  wire den_in;
  wire den_reg;
  wire [15:0]di_C;
  wire [15:0]di_in;
  wire [15:0]do_C;
  wire [15:0]do_i;
  wire [15:0]do_out;
  wire drdy_C;
  wire drdy_i;
  wire drdy_out;
  wire dwe_C;
  wire dwe_in;
  wire eoc_out;
  wire eos_out;
  wire jtaglocked_i;
  wire m_axis_aclk;
  wire m_axis_reset;
  wire m_axis_resetn;
  wire [15:0]m_axis_tdata;
  wire [4:0]m_axis_tid;
  wire m_axis_tready;
  wire m_axis_tvalid;
  wire mode_change;
  wire mode_change_i_2_n_0;
  wire ot_out;
  wire overlap_A;
  wire s_axis_aclk;
  wire [0:0]state;
  wire [1:0]state__0;
  wire [11:0]temp_out;
  wire vn_in;
  wire vp_in;
  wire wren_fifo;
  wire NLW_XADC_INST_JTAGBUSY_UNCONNECTED;
  wire NLW_XADC_INST_JTAGMODIFIED_UNCONNECTED;
  wire [4:0]NLW_XADC_INST_MUXADDR_UNCONNECTED;

  xadc_wiz_0_drp_arbiter Inst_drp_arbiter
       (.DO(do_C),
        .\FSM_sequential_state_reg[0]_0 (Inst_drp_arbiter_n_24),
        .\FSM_sequential_state_reg[0]_1 (axi4_stream_inst_n_35),
        .\FSM_sequential_state_reg[3] (axi4_stream_inst_n_31),
        .\FSM_sequential_state_reg[3]_0 (state),
        .\FSM_sequential_state_reg[3]_1 (axi4_stream_inst_n_32),
        .Q(do_i),
        .bbusy_A(bbusy_A),
        .channel_out(channel_out[4]),
        .\daddr_C_reg_reg[6]_0 (daddr_C),
        .\daddr_C_reg_reg[6]_1 ({daddr_A[6],daddr_A[4:0]}),
        .daddr_in(daddr_in),
        .den_A(den_A),
        .den_C(den_C),
        .den_in(den_in),
        .den_reg(den_reg),
        .\di_C_reg_reg[15]_0 (di_C),
        .di_in(di_in),
        .\do_A_reg_reg[14]_0 (Inst_drp_arbiter_n_7),
        .\do_A_reg_reg[15]_0 (Inst_drp_arbiter_n_25),
        .do_out(do_out),
        .drdy_C(drdy_C),
        .drdy_i(drdy_i),
        .drdy_out(drdy_out),
        .dwe_C(dwe_C),
        .dwe_in(dwe_in),
        .eoc_out(eoc_out),
        .jtaglocked_i(jtaglocked_i),
        .m_axis_aclk(m_axis_aclk),
        .m_axis_reset(m_axis_reset),
        .m_axis_resetn(m_axis_resetn),
        .\m_axis_tdata[15] (axi4_stream_inst_n_29),
        .mode_change(mode_change),
        .overlap_A(overlap_A),
        .overlap_B_reg_0(Inst_drp_arbiter_n_3),
        .state__0(state__0),
        .wren_fifo(wren_fifo));
  (* box_type = "PRIMITIVE" *) 
  XADC #(
    .INIT_40(16'h0000),
    .INIT_41(16'h20A0),
    .INIT_42(16'h0400),
    .INIT_43(16'h0000),
    .INIT_44(16'h0000),
    .INIT_45(16'h0000),
    .INIT_46(16'h0000),
    .INIT_47(16'h0000),
    .INIT_48(16'h4700),
    .INIT_49(16'h0103),
    .INIT_4A(16'h4700),
    .INIT_4B(16'h0103),
    .INIT_4C(16'h0000),
    .INIT_4D(16'h0000),
    .INIT_4E(16'h0000),
    .INIT_4F(16'h0000),
    .INIT_50(16'hB5ED),
    .INIT_51(16'h57E4),
    .INIT_52(16'hA147),
    .INIT_53(16'hCA33),
    .INIT_54(16'hA93A),
    .INIT_55(16'h52C6),
    .INIT_56(16'h9555),
    .INIT_57(16'hAE4E),
    .INIT_58(16'h5999),
    .INIT_59(16'h0000),
    .INIT_5A(16'h0000),
    .INIT_5B(16'h0000),
    .INIT_5C(16'h5111),
    .INIT_5D(16'h0000),
    .INIT_5E(16'h0000),
    .INIT_5F(16'h0000),
    .IS_CONVSTCLK_INVERTED(1'b0),
    .IS_DCLK_INVERTED(1'b0),
    .SIM_DEVICE("7SERIES"),
    .SIM_MONITOR_FILE("design.txt")) 
    XADC_INST
       (.ALM(alarm_out),
        .BUSY(busy_out),
        .CHANNEL(channel_out),
        .CONVST(1'b0),
        .CONVSTCLK(1'b0),
        .DADDR(daddr_C),
        .DCLK(m_axis_aclk),
        .DEN(den_C),
        .DI(di_C),
        .DO(do_C),
        .DRDY(drdy_C),
        .DWE(dwe_C),
        .EOC(eoc_out),
        .EOS(eos_out),
        .JTAGBUSY(NLW_XADC_INST_JTAGBUSY_UNCONNECTED),
        .JTAGLOCKED(jtaglocked_i),
        .JTAGMODIFIED(NLW_XADC_INST_JTAGMODIFIED_UNCONNECTED),
        .MUXADDR(NLW_XADC_INST_MUXADDR_UNCONNECTED[4:0]),
        .OT(ot_out),
        .RESET(m_axis_reset),
        .VAUXN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,VAUXN[2],1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,VAUXN[1:0]}),
        .VAUXP({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,VAUXP[2],1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,VAUXP[1:0]}),
        .VN(vn_in),
        .VP(vp_in));
  xadc_wiz_0_drp_to_axi4stream axi4_stream_inst
       (.\FSM_sequential_state_reg[0]_0 (state),
        .\FSM_sequential_state_reg[0]_1 (Inst_drp_arbiter_n_3),
        .\FSM_sequential_state_reg[1]_0 (axi4_stream_inst_n_32),
        .\FSM_sequential_state_reg[1]_1 (Inst_drp_arbiter_n_25),
        .\FSM_sequential_state_reg[2]_0 (Inst_drp_arbiter_n_24),
        .\FSM_sequential_state_reg[3]_0 (Inst_drp_arbiter_n_7),
        .Q(do_i),
        .bbusy_A(bbusy_A),
        .busy_o_reg_0(axi4_stream_inst_n_35),
        .\channel_id_reg[6]_0 ({daddr_A[6],daddr_A[4:0]}),
        .channel_out(channel_out),
        .daddr_in(daddr_in[2:0]),
        .daddr_in_2_sp_1(axi4_stream_inst_n_36),
        .den_A(den_A),
        .den_in(den_in),
        .den_reg(den_reg),
        .drdy_i(drdy_i),
        .eoc_out(eoc_out),
        .m_axis_aclk(m_axis_aclk),
        .m_axis_aclk_0(axi4_stream_inst_n_31),
        .m_axis_reset(m_axis_reset),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tid(m_axis_tid),
        .m_axis_tready(m_axis_tready),
        .m_axis_tvalid(m_axis_tvalid),
        .mode_change(mode_change),
        .mode_change_reg(mode_change_i_2_n_0),
        .overlap_A(overlap_A),
        .s_axis_aclk(s_axis_aclk),
        .state__0(state__0),
        .temp_out(temp_out),
        .valid_data_wren_reg_0(axi4_stream_inst_n_29),
        .wren_fifo(wren_fifo));
  LUT6 #(
    .INIT(64'h0002000000000000)) 
    mode_change_i_2
       (.I0(daddr_in[6]),
        .I1(daddr_in[5]),
        .I2(daddr_in[3]),
        .I3(daddr_in[4]),
        .I4(den_in),
        .I5(dwe_in),
        .O(mode_change_i_2_n_0));
  FDCE #(
    .INIT(1'b0)) 
    mode_change_reg
       (.C(m_axis_aclk),
        .CE(1'b1),
        .CLR(m_axis_reset),
        .D(axi4_stream_inst_n_36),
        .Q(mode_change));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
