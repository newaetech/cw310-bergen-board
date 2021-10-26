-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
-- Date        : Thu Oct 21 15:58:46 2021
-- Host        : red running 64-bit Ubuntu 18.04.6 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /home/jpnewae/git/bergen/cw310-bergen-board/fpga/board_test/board_test.srcs/sources_1/ip/xadc_wiz_0/xadc_wiz_0_sim_netlist.vhdl
-- Design      : xadc_wiz_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k160tfbg676-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity xadc_wiz_0_drp_arbiter is
  port (
    m_axis_reset : out STD_LOGIC;
    den_C : out STD_LOGIC;
    dwe_C : out STD_LOGIC;
    overlap_B_reg_0 : out STD_LOGIC;
    drdy_i : out STD_LOGIC;
    drdy_out : out STD_LOGIC;
    wren_fifo : out STD_LOGIC;
    \do_A_reg_reg[14]_0\ : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 15 downto 0 );
    \FSM_sequential_state_reg[0]_0\ : out STD_LOGIC;
    \do_A_reg_reg[15]_0\ : out STD_LOGIC;
    \state__0\ : out STD_LOGIC_VECTOR ( 1 downto 0 );
    do_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    \daddr_C_reg_reg[6]_0\ : out STD_LOGIC_VECTOR ( 6 downto 0 );
    \di_C_reg_reg[15]_0\ : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_aclk : in STD_LOGIC;
    den_reg : in STD_LOGIC;
    \m_axis_tdata[15]\ : in STD_LOGIC;
    m_axis_resetn : in STD_LOGIC;
    \FSM_sequential_state_reg[3]\ : in STD_LOGIC;
    mode_change : in STD_LOGIC;
    \FSM_sequential_state_reg[3]_0\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    \FSM_sequential_state_reg[3]_1\ : in STD_LOGIC;
    eoc_out : in STD_LOGIC;
    channel_out : in STD_LOGIC_VECTOR ( 0 to 0 );
    di_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    daddr_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    \daddr_C_reg_reg[6]_1\ : in STD_LOGIC_VECTOR ( 5 downto 0 );
    dwe_in : in STD_LOGIC;
    drdy_C : in STD_LOGIC;
    bbusy_A : in STD_LOGIC;
    den_A : in STD_LOGIC;
    den_in : in STD_LOGIC;
    jtaglocked_i : in STD_LOGIC;
    DO : in STD_LOGIC_VECTOR ( 15 downto 0 );
    overlap_A : in STD_LOGIC;
    \FSM_sequential_state_reg[0]_1\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of xadc_wiz_0_drp_arbiter : entity is "drp_arbiter";
end xadc_wiz_0_drp_arbiter;

architecture STRUCTURE of xadc_wiz_0_drp_arbiter is
  signal \FSM_sequential_state[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[0]_i_2__0_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[1]_i_2__0_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[1]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[1]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[1]_i_5_n_0\ : STD_LOGIC;
  signal \^q\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal daddr_C_reg0_in : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \daddr_C_reg[6]_i_10_n_0\ : STD_LOGIC;
  signal \daddr_C_reg[6]_i_1_n_0\ : STD_LOGIC;
  signal \daddr_C_reg[6]_i_3_n_0\ : STD_LOGIC;
  signal \daddr_C_reg[6]_i_4_n_0\ : STD_LOGIC;
  signal \daddr_C_reg[6]_i_5_n_0\ : STD_LOGIC;
  signal \daddr_C_reg[6]_i_6_n_0\ : STD_LOGIC;
  signal \daddr_C_reg[6]_i_7_n_0\ : STD_LOGIC;
  signal \daddr_C_reg[6]_i_8_n_0\ : STD_LOGIC;
  signal \daddr_C_reg[6]_i_9_n_0\ : STD_LOGIC;
  signal daddr_reg : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \daddr_reg_reg_n_0_[0]\ : STD_LOGIC;
  signal \daddr_reg_reg_n_0_[1]\ : STD_LOGIC;
  signal \daddr_reg_reg_n_0_[2]\ : STD_LOGIC;
  signal \daddr_reg_reg_n_0_[3]\ : STD_LOGIC;
  signal \daddr_reg_reg_n_0_[4]\ : STD_LOGIC;
  signal \daddr_reg_reg_n_0_[5]\ : STD_LOGIC;
  signal \daddr_reg_reg_n_0_[6]\ : STD_LOGIC;
  signal den_C_reg : STD_LOGIC;
  signal den_C_reg_i_2_n_0 : STD_LOGIC;
  signal den_C_reg_i_3_n_0 : STD_LOGIC;
  signal den_C_reg_i_4_n_0 : STD_LOGIC;
  signal den_C_reg_i_5_n_0 : STD_LOGIC;
  signal den_reg_reg_n_0 : STD_LOGIC;
  signal di_C_reg : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal di_reg : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \di_reg_reg_n_0_[0]\ : STD_LOGIC;
  signal \di_reg_reg_n_0_[10]\ : STD_LOGIC;
  signal \di_reg_reg_n_0_[11]\ : STD_LOGIC;
  signal \di_reg_reg_n_0_[12]\ : STD_LOGIC;
  signal \di_reg_reg_n_0_[13]\ : STD_LOGIC;
  signal \di_reg_reg_n_0_[14]\ : STD_LOGIC;
  signal \di_reg_reg_n_0_[15]\ : STD_LOGIC;
  signal \di_reg_reg_n_0_[1]\ : STD_LOGIC;
  signal \di_reg_reg_n_0_[2]\ : STD_LOGIC;
  signal \di_reg_reg_n_0_[3]\ : STD_LOGIC;
  signal \di_reg_reg_n_0_[4]\ : STD_LOGIC;
  signal \di_reg_reg_n_0_[5]\ : STD_LOGIC;
  signal \di_reg_reg_n_0_[6]\ : STD_LOGIC;
  signal \di_reg_reg_n_0_[7]\ : STD_LOGIC;
  signal \di_reg_reg_n_0_[8]\ : STD_LOGIC;
  signal \di_reg_reg_n_0_[9]\ : STD_LOGIC;
  signal do_A_reg0_in : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \do_A_reg[15]_i_1_n_0\ : STD_LOGIC;
  signal do_B_reg0_in : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \do_B_reg[15]_i_1_n_0\ : STD_LOGIC;
  signal drdy_A_reg_i_1_n_0 : STD_LOGIC;
  signal drdy_B_reg_i_1_n_0 : STD_LOGIC;
  signal \^drdy_i\ : STD_LOGIC;
  signal \^drdy_out\ : STD_LOGIC;
  signal dwe_C_reg : STD_LOGIC;
  signal dwe_reg : STD_LOGIC;
  signal dwe_reg_i_1_n_0 : STD_LOGIC;
  signal dwe_reg_i_3_n_0 : STD_LOGIC;
  signal dwe_reg_i_4_n_0 : STD_LOGIC;
  signal dwe_reg_i_5_n_0 : STD_LOGIC;
  signal dwe_reg_i_6_n_0 : STD_LOGIC;
  signal dwe_reg_reg_n_0 : STD_LOGIC;
  signal \^m_axis_reset\ : STD_LOGIC;
  signal overlap_A_i_1_n_0 : STD_LOGIC;
  signal overlap_A_i_3_n_0 : STD_LOGIC;
  signal overlap_A_reg_n_0 : STD_LOGIC;
  signal overlap_B : STD_LOGIC;
  signal overlap_B_i_1_n_0 : STD_LOGIC;
  signal overlap_B_i_3_n_0 : STD_LOGIC;
  signal overlap_B_i_4_n_0 : STD_LOGIC;
  signal \^overlap_b_reg_0\ : STD_LOGIC;
  signal \^state__0\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of FIFO18E1_inst_data_i_2 : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \FSM_sequential_state[1]_i_2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \FSM_sequential_state[1]_i_4\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \FSM_sequential_state[2]_i_2\ : label is "soft_lutpair1";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_reg[0]\ : label is "grant_b:10,nogrant:00,grant_a:01";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_reg[1]\ : label is "grant_b:10,nogrant:00,grant_a:01";
  attribute SOFT_HLUTNM of \daddr_C_reg[6]_i_4\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \daddr_C_reg[6]_i_5\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \daddr_C_reg[6]_i_9\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \daddr_reg[0]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \daddr_reg[1]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \daddr_reg[2]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \daddr_reg[3]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \daddr_reg[4]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \daddr_reg[5]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \daddr_reg[6]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of den_C_reg_i_4 : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \di_reg[10]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \di_reg[11]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \di_reg[12]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \di_reg[13]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \di_reg[14]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \di_reg[15]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \di_reg[1]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \di_reg[2]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \di_reg[3]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \di_reg[4]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \di_reg[5]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \di_reg[6]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \di_reg[7]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \di_reg[8]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \di_reg[9]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \do_A_reg[10]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \do_A_reg[11]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \do_A_reg[12]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \do_A_reg[13]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \do_A_reg[14]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \do_A_reg[15]_i_2\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \do_A_reg[1]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \do_A_reg[2]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \do_A_reg[3]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \do_A_reg[4]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \do_A_reg[5]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \do_A_reg[6]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \do_A_reg[7]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \do_A_reg[8]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \do_A_reg[9]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \do_B_reg[0]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \do_B_reg[10]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \do_B_reg[11]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \do_B_reg[12]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \do_B_reg[13]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \do_B_reg[14]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \do_B_reg[15]_i_2\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \do_B_reg[1]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \do_B_reg[2]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \do_B_reg[3]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \do_B_reg[4]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \do_B_reg[5]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \do_B_reg[6]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \do_B_reg[7]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \do_B_reg[8]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \do_B_reg[9]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of drdy_A_reg_i_1 : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of drdy_B_reg_i_1 : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of dwe_reg_i_2 : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of dwe_reg_i_3 : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of dwe_reg_i_4 : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of dwe_reg_i_5 : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of dwe_reg_i_6 : label is "soft_lutpair0";
begin
  Q(15 downto 0) <= \^q\(15 downto 0);
  drdy_i <= \^drdy_i\;
  drdy_out <= \^drdy_out\;
  m_axis_reset <= \^m_axis_reset\;
  overlap_B_reg_0 <= \^overlap_b_reg_0\;
  \state__0\(1 downto 0) <= \^state__0\(1 downto 0);
FIFO18E1_inst_data_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^drdy_i\,
      I1 => \m_axis_tdata[15]\,
      O => wren_fifo
    );
\FSM_sequential_state[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FFFFCCF40000"
    )
        port map (
      I0 => \^overlap_b_reg_0\,
      I1 => \FSM_sequential_state[0]_i_2__0_n_0\,
      I2 => \FSM_sequential_state_reg[0]_1\,
      I3 => \^state__0\(1),
      I4 => \FSM_sequential_state[1]_i_3_n_0\,
      I5 => \^state__0\(0),
      O => \FSM_sequential_state[0]_i_1_n_0\
    );
\FSM_sequential_state[0]_i_2__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => overlap_A_reg_n_0,
      I1 => den_A,
      O => \FSM_sequential_state[0]_i_2__0_n_0\
    );
\FSM_sequential_state[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFFAE00"
    )
        port map (
      I0 => \FSM_sequential_state[1]_i_2__0_n_0\,
      I1 => \^overlap_b_reg_0\,
      I2 => bbusy_A,
      I3 => \FSM_sequential_state[1]_i_3_n_0\,
      I4 => \^state__0\(1),
      O => \FSM_sequential_state[1]_i_1_n_0\
    );
\FSM_sequential_state[1]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"06"
    )
        port map (
      I0 => \^q\(15),
      I1 => \^q\(14),
      I2 => \FSM_sequential_state_reg[3]_0\(0),
      O => \do_A_reg_reg[15]_0\
    );
\FSM_sequential_state[1]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0200020002000300"
    )
        port map (
      I0 => \^state__0\(0),
      I1 => \^state__0\(1),
      I2 => bbusy_A,
      I3 => den_in,
      I4 => den_A,
      I5 => overlap_A_reg_n_0,
      O => \FSM_sequential_state[1]_i_2__0_n_0\
    );
\FSM_sequential_state[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAEAFFFFFAEAFAEA"
    )
        port map (
      I0 => \FSM_sequential_state[1]_i_4_n_0\,
      I1 => overlap_A_reg_n_0,
      I2 => \daddr_C_reg[6]_i_4_n_0\,
      I3 => \FSM_sequential_state[1]_i_5_n_0\,
      I4 => \^state__0\(1),
      I5 => dwe_reg_i_5_n_0,
      O => \FSM_sequential_state[1]_i_3_n_0\
    );
\FSM_sequential_state[1]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"60"
    )
        port map (
      I0 => \^state__0\(1),
      I1 => \^state__0\(0),
      I2 => drdy_C,
      O => \FSM_sequential_state[1]_i_4_n_0\
    );
\FSM_sequential_state[1]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \^overlap_b_reg_0\,
      I1 => den_in,
      O => \FSM_sequential_state[1]_i_5_n_0\
    );
\FSM_sequential_state[2]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7F707F7F"
    )
        port map (
      I0 => eoc_out,
      I1 => channel_out(0),
      I2 => \FSM_sequential_state_reg[3]_0\(0),
      I3 => \^q\(14),
      I4 => \^q\(15),
      O => \FSM_sequential_state_reg[0]_0\
    );
\FSM_sequential_state[3]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00F09999FFFFFFFF"
    )
        port map (
      I0 => \^q\(14),
      I1 => \^q\(15),
      I2 => \FSM_sequential_state_reg[3]\,
      I3 => mode_change,
      I4 => \FSM_sequential_state_reg[3]_0\(0),
      I5 => \FSM_sequential_state_reg[3]_1\,
      O => \do_A_reg_reg[14]_0\
    );
\FSM_sequential_state_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => \FSM_sequential_state[0]_i_1_n_0\,
      Q => \^state__0\(0)
    );
\FSM_sequential_state_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => \FSM_sequential_state[1]_i_1_n_0\,
      Q => \^state__0\(1)
    );
\daddr_C_reg[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \daddr_C_reg[6]_i_6_n_0\,
      I1 => daddr_in(0),
      I2 => \daddr_C_reg[6]_i_7_n_0\,
      I3 => \daddr_C_reg_reg[6]_1\(0),
      I4 => \daddr_reg_reg_n_0_[0]\,
      I5 => \daddr_C_reg[6]_i_8_n_0\,
      O => daddr_C_reg0_in(0)
    );
\daddr_C_reg[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \daddr_C_reg[6]_i_6_n_0\,
      I1 => daddr_in(1),
      I2 => \daddr_C_reg[6]_i_7_n_0\,
      I3 => \daddr_C_reg_reg[6]_1\(1),
      I4 => \daddr_reg_reg_n_0_[1]\,
      I5 => \daddr_C_reg[6]_i_8_n_0\,
      O => daddr_C_reg0_in(1)
    );
\daddr_C_reg[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \daddr_C_reg[6]_i_6_n_0\,
      I1 => daddr_in(2),
      I2 => \daddr_C_reg[6]_i_7_n_0\,
      I3 => \daddr_C_reg_reg[6]_1\(2),
      I4 => \daddr_reg_reg_n_0_[2]\,
      I5 => \daddr_C_reg[6]_i_8_n_0\,
      O => daddr_C_reg0_in(2)
    );
\daddr_C_reg[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \daddr_C_reg[6]_i_6_n_0\,
      I1 => daddr_in(3),
      I2 => \daddr_C_reg[6]_i_7_n_0\,
      I3 => \daddr_C_reg_reg[6]_1\(3),
      I4 => \daddr_reg_reg_n_0_[3]\,
      I5 => \daddr_C_reg[6]_i_8_n_0\,
      O => daddr_C_reg0_in(3)
    );
\daddr_C_reg[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \daddr_C_reg[6]_i_6_n_0\,
      I1 => daddr_in(4),
      I2 => \daddr_C_reg[6]_i_7_n_0\,
      I3 => \daddr_C_reg_reg[6]_1\(4),
      I4 => \daddr_reg_reg_n_0_[4]\,
      I5 => \daddr_C_reg[6]_i_8_n_0\,
      O => daddr_C_reg0_in(4)
    );
\daddr_C_reg[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \daddr_reg_reg_n_0_[5]\,
      I1 => \daddr_C_reg[6]_i_8_n_0\,
      I2 => daddr_in(5),
      I3 => \daddr_C_reg[6]_i_6_n_0\,
      O => daddr_C_reg0_in(5)
    );
\daddr_C_reg[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEEEEEEEFEFEFEEE"
    )
        port map (
      I0 => \daddr_C_reg[6]_i_3_n_0\,
      I1 => \daddr_C_reg[6]_i_4_n_0\,
      I2 => \daddr_C_reg[6]_i_5_n_0\,
      I3 => \^overlap_b_reg_0\,
      I4 => den_in,
      I5 => bbusy_A,
      O => \daddr_C_reg[6]_i_1_n_0\
    );
\daddr_C_reg[6]_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000040000FF0404"
    )
        port map (
      I0 => \^overlap_b_reg_0\,
      I1 => den_A,
      I2 => overlap_A_reg_n_0,
      I3 => drdy_C,
      I4 => \^state__0\(0),
      I5 => \^state__0\(1),
      O => \daddr_C_reg[6]_i_10_n_0\
    );
\daddr_C_reg[6]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \daddr_C_reg[6]_i_6_n_0\,
      I1 => daddr_in(6),
      I2 => \daddr_C_reg[6]_i_7_n_0\,
      I3 => \daddr_C_reg_reg[6]_1\(5),
      I4 => \daddr_reg_reg_n_0_[6]\,
      I5 => \daddr_C_reg[6]_i_8_n_0\,
      O => daddr_C_reg0_in(6)
    );
\daddr_C_reg[6]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"11111111AAA2FFA2"
    )
        port map (
      I0 => \^state__0\(1),
      I1 => drdy_C,
      I2 => overlap_A_reg_n_0,
      I3 => den_A,
      I4 => jtaglocked_i,
      I5 => \^state__0\(0),
      O => \daddr_C_reg[6]_i_3_n_0\
    );
\daddr_C_reg[6]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => bbusy_A,
      I1 => \^state__0\(1),
      I2 => \^state__0\(0),
      I3 => jtaglocked_i,
      O => \daddr_C_reg[6]_i_4_n_0\
    );
\daddr_C_reg[6]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^state__0\(0),
      I1 => \^state__0\(1),
      O => \daddr_C_reg[6]_i_5_n_0\
    );
\daddr_C_reg[6]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"03C003C003F30340"
    )
        port map (
      I0 => \^overlap_b_reg_0\,
      I1 => \^state__0\(0),
      I2 => drdy_C,
      I3 => \^state__0\(1),
      I4 => \daddr_C_reg[6]_i_9_n_0\,
      I5 => bbusy_A,
      O => \daddr_C_reg[6]_i_6_n_0\
    );
\daddr_C_reg[6]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AABAAAFFAABAAAAA"
    )
        port map (
      I0 => \daddr_C_reg[6]_i_10_n_0\,
      I1 => overlap_A_reg_n_0,
      I2 => drdy_C,
      I3 => \^state__0\(0),
      I4 => \^state__0\(1),
      I5 => bbusy_A,
      O => \daddr_C_reg[6]_i_7_n_0\
    );
\daddr_C_reg[6]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4000400040DD4050"
    )
        port map (
      I0 => \^state__0\(0),
      I1 => drdy_C,
      I2 => overlap_A_reg_n_0,
      I3 => \^state__0\(1),
      I4 => \^overlap_b_reg_0\,
      I5 => bbusy_A,
      O => \daddr_C_reg[6]_i_8_n_0\
    );
\daddr_C_reg[6]_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
        port map (
      I0 => den_A,
      I1 => den_in,
      I2 => \^overlap_b_reg_0\,
      I3 => overlap_A_reg_n_0,
      O => \daddr_C_reg[6]_i_9_n_0\
    );
\daddr_C_reg_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => daddr_C_reg0_in(0),
      Q => \daddr_C_reg_reg[6]_0\(0)
    );
\daddr_C_reg_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => daddr_C_reg0_in(1),
      Q => \daddr_C_reg_reg[6]_0\(1)
    );
\daddr_C_reg_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => daddr_C_reg0_in(2),
      Q => \daddr_C_reg_reg[6]_0\(2)
    );
\daddr_C_reg_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => daddr_C_reg0_in(3),
      Q => \daddr_C_reg_reg[6]_0\(3)
    );
\daddr_C_reg_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => daddr_C_reg0_in(4),
      Q => \daddr_C_reg_reg[6]_0\(4)
    );
\daddr_C_reg_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => daddr_C_reg0_in(5),
      Q => \daddr_C_reg_reg[6]_0\(5)
    );
\daddr_C_reg_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => daddr_C_reg0_in(6),
      Q => \daddr_C_reg_reg[6]_0\(6)
    );
\daddr_reg[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => \daddr_C_reg_reg[6]_1\(0),
      I1 => \^state__0\(0),
      I2 => \^state__0\(1),
      I3 => daddr_in(0),
      O => daddr_reg(0)
    );
\daddr_reg[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => \daddr_C_reg_reg[6]_1\(1),
      I1 => \^state__0\(0),
      I2 => \^state__0\(1),
      I3 => daddr_in(1),
      O => daddr_reg(1)
    );
\daddr_reg[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => \daddr_C_reg_reg[6]_1\(2),
      I1 => \^state__0\(0),
      I2 => \^state__0\(1),
      I3 => daddr_in(2),
      O => daddr_reg(2)
    );
\daddr_reg[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => \daddr_C_reg_reg[6]_1\(3),
      I1 => \^state__0\(0),
      I2 => \^state__0\(1),
      I3 => daddr_in(3),
      O => daddr_reg(3)
    );
\daddr_reg[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => \daddr_C_reg_reg[6]_1\(4),
      I1 => \^state__0\(0),
      I2 => \^state__0\(1),
      I3 => daddr_in(4),
      O => daddr_reg(4)
    );
\daddr_reg[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => daddr_in(5),
      I1 => \^state__0\(1),
      O => daddr_reg(5)
    );
\daddr_reg[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => \daddr_C_reg_reg[6]_1\(5),
      I1 => \^state__0\(0),
      I2 => \^state__0\(1),
      I3 => daddr_in(6),
      O => daddr_reg(6)
    );
\daddr_reg_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => daddr_reg(0),
      Q => \daddr_reg_reg_n_0_[0]\
    );
\daddr_reg_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => daddr_reg(1),
      Q => \daddr_reg_reg_n_0_[1]\
    );
\daddr_reg_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => daddr_reg(2),
      Q => \daddr_reg_reg_n_0_[2]\
    );
\daddr_reg_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => daddr_reg(3),
      Q => \daddr_reg_reg_n_0_[3]\
    );
\daddr_reg_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => daddr_reg(4),
      Q => \daddr_reg_reg_n_0_[4]\
    );
\daddr_reg_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => daddr_reg(5),
      Q => \daddr_reg_reg_n_0_[5]\
    );
\daddr_reg_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => daddr_reg(6),
      Q => \daddr_reg_reg_n_0_[6]\
    );
den_C_reg_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFEA"
    )
        port map (
      I0 => den_C_reg_i_2_n_0,
      I1 => \daddr_C_reg[6]_i_8_n_0\,
      I2 => den_reg_reg_n_0,
      I3 => den_C_reg_i_3_n_0,
      I4 => den_C_reg_i_4_n_0,
      I5 => den_C_reg_i_5_n_0,
      O => den_C_reg
    );
den_C_reg_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0202024700000000"
    )
        port map (
      I0 => \^state__0\(0),
      I1 => drdy_C,
      I2 => \^state__0\(1),
      I3 => \^overlap_b_reg_0\,
      I4 => overlap_A_reg_n_0,
      I5 => den_A,
      O => den_C_reg_i_2_n_0
    );
den_C_reg_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"040F040000000000"
    )
        port map (
      I0 => overlap_A_reg_n_0,
      I1 => drdy_C,
      I2 => \^state__0\(0),
      I3 => \^state__0\(1),
      I4 => bbusy_A,
      I5 => den_A,
      O => den_C_reg_i_3_n_0
    );
den_C_reg_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0400"
    )
        port map (
      I0 => drdy_C,
      I1 => den_in,
      I2 => \^state__0\(0),
      I3 => \^state__0\(1),
      O => den_C_reg_i_4_n_0
    );
den_C_reg_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000004000440C"
    )
        port map (
      I0 => \^state__0\(1),
      I1 => dwe_reg_i_4_n_0,
      I2 => \^state__0\(0),
      I3 => drdy_C,
      I4 => overlap_A_reg_n_0,
      I5 => bbusy_A,
      O => den_C_reg_i_5_n_0
    );
den_C_reg_reg: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => den_C_reg,
      Q => den_C
    );
den_reg_reg: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => den_reg,
      Q => den_reg_reg_n_0
    );
\di_C_reg[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \di_reg_reg_n_0_[0]\,
      I1 => \daddr_C_reg[6]_i_8_n_0\,
      I2 => di_in(0),
      I3 => \daddr_C_reg[6]_i_6_n_0\,
      O => di_C_reg(0)
    );
\di_C_reg[10]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \di_reg_reg_n_0_[10]\,
      I1 => \daddr_C_reg[6]_i_8_n_0\,
      I2 => di_in(10),
      I3 => \daddr_C_reg[6]_i_6_n_0\,
      O => di_C_reg(10)
    );
\di_C_reg[11]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \di_reg_reg_n_0_[11]\,
      I1 => \daddr_C_reg[6]_i_8_n_0\,
      I2 => di_in(11),
      I3 => \daddr_C_reg[6]_i_6_n_0\,
      O => di_C_reg(11)
    );
\di_C_reg[12]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \di_reg_reg_n_0_[12]\,
      I1 => \daddr_C_reg[6]_i_8_n_0\,
      I2 => di_in(12),
      I3 => \daddr_C_reg[6]_i_6_n_0\,
      O => di_C_reg(12)
    );
\di_C_reg[13]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \di_reg_reg_n_0_[13]\,
      I1 => \daddr_C_reg[6]_i_8_n_0\,
      I2 => di_in(13),
      I3 => \daddr_C_reg[6]_i_6_n_0\,
      O => di_C_reg(13)
    );
\di_C_reg[14]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \di_reg_reg_n_0_[14]\,
      I1 => \daddr_C_reg[6]_i_8_n_0\,
      I2 => di_in(14),
      I3 => \daddr_C_reg[6]_i_6_n_0\,
      O => di_C_reg(14)
    );
\di_C_reg[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \di_reg_reg_n_0_[15]\,
      I1 => \daddr_C_reg[6]_i_8_n_0\,
      I2 => di_in(15),
      I3 => \daddr_C_reg[6]_i_6_n_0\,
      O => di_C_reg(15)
    );
\di_C_reg[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \di_reg_reg_n_0_[1]\,
      I1 => \daddr_C_reg[6]_i_8_n_0\,
      I2 => di_in(1),
      I3 => \daddr_C_reg[6]_i_6_n_0\,
      O => di_C_reg(1)
    );
\di_C_reg[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \di_reg_reg_n_0_[2]\,
      I1 => \daddr_C_reg[6]_i_8_n_0\,
      I2 => di_in(2),
      I3 => \daddr_C_reg[6]_i_6_n_0\,
      O => di_C_reg(2)
    );
\di_C_reg[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \di_reg_reg_n_0_[3]\,
      I1 => \daddr_C_reg[6]_i_8_n_0\,
      I2 => di_in(3),
      I3 => \daddr_C_reg[6]_i_6_n_0\,
      O => di_C_reg(3)
    );
\di_C_reg[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \di_reg_reg_n_0_[4]\,
      I1 => \daddr_C_reg[6]_i_8_n_0\,
      I2 => di_in(4),
      I3 => \daddr_C_reg[6]_i_6_n_0\,
      O => di_C_reg(4)
    );
\di_C_reg[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \di_reg_reg_n_0_[5]\,
      I1 => \daddr_C_reg[6]_i_8_n_0\,
      I2 => di_in(5),
      I3 => \daddr_C_reg[6]_i_6_n_0\,
      O => di_C_reg(5)
    );
\di_C_reg[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \di_reg_reg_n_0_[6]\,
      I1 => \daddr_C_reg[6]_i_8_n_0\,
      I2 => di_in(6),
      I3 => \daddr_C_reg[6]_i_6_n_0\,
      O => di_C_reg(6)
    );
\di_C_reg[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \di_reg_reg_n_0_[7]\,
      I1 => \daddr_C_reg[6]_i_8_n_0\,
      I2 => di_in(7),
      I3 => \daddr_C_reg[6]_i_6_n_0\,
      O => di_C_reg(7)
    );
\di_C_reg[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \di_reg_reg_n_0_[8]\,
      I1 => \daddr_C_reg[6]_i_8_n_0\,
      I2 => di_in(8),
      I3 => \daddr_C_reg[6]_i_6_n_0\,
      O => di_C_reg(8)
    );
\di_C_reg[9]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \di_reg_reg_n_0_[9]\,
      I1 => \daddr_C_reg[6]_i_8_n_0\,
      I2 => di_in(9),
      I3 => \daddr_C_reg[6]_i_6_n_0\,
      O => di_C_reg(9)
    );
\di_C_reg_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => di_C_reg(0),
      Q => \di_C_reg_reg[15]_0\(0)
    );
\di_C_reg_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => di_C_reg(10),
      Q => \di_C_reg_reg[15]_0\(10)
    );
\di_C_reg_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => di_C_reg(11),
      Q => \di_C_reg_reg[15]_0\(11)
    );
\di_C_reg_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => di_C_reg(12),
      Q => \di_C_reg_reg[15]_0\(12)
    );
\di_C_reg_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => di_C_reg(13),
      Q => \di_C_reg_reg[15]_0\(13)
    );
\di_C_reg_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => di_C_reg(14),
      Q => \di_C_reg_reg[15]_0\(14)
    );
\di_C_reg_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => di_C_reg(15),
      Q => \di_C_reg_reg[15]_0\(15)
    );
\di_C_reg_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => di_C_reg(1),
      Q => \di_C_reg_reg[15]_0\(1)
    );
\di_C_reg_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => di_C_reg(2),
      Q => \di_C_reg_reg[15]_0\(2)
    );
\di_C_reg_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => di_C_reg(3),
      Q => \di_C_reg_reg[15]_0\(3)
    );
\di_C_reg_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => di_C_reg(4),
      Q => \di_C_reg_reg[15]_0\(4)
    );
\di_C_reg_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => di_C_reg(5),
      Q => \di_C_reg_reg[15]_0\(5)
    );
\di_C_reg_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => di_C_reg(6),
      Q => \di_C_reg_reg[15]_0\(6)
    );
\di_C_reg_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => di_C_reg(7),
      Q => \di_C_reg_reg[15]_0\(7)
    );
\di_C_reg_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => di_C_reg(8),
      Q => \di_C_reg_reg[15]_0\(8)
    );
\di_C_reg_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => di_C_reg(9),
      Q => \di_C_reg_reg[15]_0\(9)
    );
\di_reg[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => di_in(0),
      I1 => \^state__0\(1),
      O => di_reg(0)
    );
\di_reg[10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => di_in(10),
      I1 => \^state__0\(1),
      O => di_reg(10)
    );
\di_reg[11]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => di_in(11),
      I1 => \^state__0\(1),
      O => di_reg(11)
    );
\di_reg[12]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => di_in(12),
      I1 => \^state__0\(1),
      O => di_reg(12)
    );
\di_reg[13]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => di_in(13),
      I1 => \^state__0\(1),
      O => di_reg(13)
    );
\di_reg[14]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => di_in(14),
      I1 => \^state__0\(1),
      O => di_reg(14)
    );
\di_reg[15]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => di_in(15),
      I1 => \^state__0\(1),
      O => di_reg(15)
    );
\di_reg[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => di_in(1),
      I1 => \^state__0\(1),
      O => di_reg(1)
    );
\di_reg[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => di_in(2),
      I1 => \^state__0\(1),
      O => di_reg(2)
    );
\di_reg[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => di_in(3),
      I1 => \^state__0\(1),
      O => di_reg(3)
    );
\di_reg[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => di_in(4),
      I1 => \^state__0\(1),
      O => di_reg(4)
    );
\di_reg[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => di_in(5),
      I1 => \^state__0\(1),
      O => di_reg(5)
    );
\di_reg[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => di_in(6),
      I1 => \^state__0\(1),
      O => di_reg(6)
    );
\di_reg[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => di_in(7),
      I1 => \^state__0\(1),
      O => di_reg(7)
    );
\di_reg[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => di_in(8),
      I1 => \^state__0\(1),
      O => di_reg(8)
    );
\di_reg[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => di_in(9),
      I1 => \^state__0\(1),
      O => di_reg(9)
    );
\di_reg_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => di_reg(0),
      Q => \di_reg_reg_n_0_[0]\
    );
\di_reg_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => di_reg(10),
      Q => \di_reg_reg_n_0_[10]\
    );
\di_reg_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => di_reg(11),
      Q => \di_reg_reg_n_0_[11]\
    );
\di_reg_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => di_reg(12),
      Q => \di_reg_reg_n_0_[12]\
    );
\di_reg_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => di_reg(13),
      Q => \di_reg_reg_n_0_[13]\
    );
\di_reg_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => di_reg(14),
      Q => \di_reg_reg_n_0_[14]\
    );
\di_reg_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => di_reg(15),
      Q => \di_reg_reg_n_0_[15]\
    );
\di_reg_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => di_reg(1),
      Q => \di_reg_reg_n_0_[1]\
    );
\di_reg_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => di_reg(2),
      Q => \di_reg_reg_n_0_[2]\
    );
\di_reg_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => di_reg(3),
      Q => \di_reg_reg_n_0_[3]\
    );
\di_reg_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => di_reg(4),
      Q => \di_reg_reg_n_0_[4]\
    );
\di_reg_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => di_reg(5),
      Q => \di_reg_reg_n_0_[5]\
    );
\di_reg_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => di_reg(6),
      Q => \di_reg_reg_n_0_[6]\
    );
\di_reg_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => di_reg(7),
      Q => \di_reg_reg_n_0_[7]\
    );
\di_reg_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => di_reg(8),
      Q => \di_reg_reg_n_0_[8]\
    );
\di_reg_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => di_reg(9),
      Q => \di_reg_reg_n_0_[9]\
    );
\do_A_reg[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(0),
      I1 => DO(0),
      O => do_A_reg0_in(0)
    );
\do_A_reg[10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(0),
      I1 => DO(10),
      O => do_A_reg0_in(10)
    );
\do_A_reg[11]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(0),
      I1 => DO(11),
      O => do_A_reg0_in(11)
    );
\do_A_reg[12]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(0),
      I1 => DO(12),
      O => do_A_reg0_in(12)
    );
\do_A_reg[13]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(0),
      I1 => DO(13),
      O => do_A_reg0_in(13)
    );
\do_A_reg[14]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(0),
      I1 => DO(14),
      O => do_A_reg0_in(14)
    );
\do_A_reg[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"31"
    )
        port map (
      I0 => \^state__0\(0),
      I1 => \^state__0\(1),
      I2 => drdy_C,
      O => \do_A_reg[15]_i_1_n_0\
    );
\do_A_reg[15]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(0),
      I1 => DO(15),
      O => do_A_reg0_in(15)
    );
\do_A_reg[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(0),
      I1 => DO(1),
      O => do_A_reg0_in(1)
    );
\do_A_reg[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(0),
      I1 => DO(2),
      O => do_A_reg0_in(2)
    );
\do_A_reg[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(0),
      I1 => DO(3),
      O => do_A_reg0_in(3)
    );
\do_A_reg[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(0),
      I1 => DO(4),
      O => do_A_reg0_in(4)
    );
\do_A_reg[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(0),
      I1 => DO(5),
      O => do_A_reg0_in(5)
    );
\do_A_reg[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(0),
      I1 => DO(6),
      O => do_A_reg0_in(6)
    );
\do_A_reg[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(0),
      I1 => DO(7),
      O => do_A_reg0_in(7)
    );
\do_A_reg[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(0),
      I1 => DO(8),
      O => do_A_reg0_in(8)
    );
\do_A_reg[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(0),
      I1 => DO(9),
      O => do_A_reg0_in(9)
    );
\do_A_reg_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_A_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_A_reg0_in(0),
      Q => \^q\(0)
    );
\do_A_reg_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_A_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_A_reg0_in(10),
      Q => \^q\(10)
    );
\do_A_reg_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_A_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_A_reg0_in(11),
      Q => \^q\(11)
    );
\do_A_reg_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_A_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_A_reg0_in(12),
      Q => \^q\(12)
    );
\do_A_reg_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_A_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_A_reg0_in(13),
      Q => \^q\(13)
    );
\do_A_reg_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_A_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_A_reg0_in(14),
      Q => \^q\(14)
    );
\do_A_reg_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_A_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_A_reg0_in(15),
      Q => \^q\(15)
    );
\do_A_reg_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_A_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_A_reg0_in(1),
      Q => \^q\(1)
    );
\do_A_reg_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_A_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_A_reg0_in(2),
      Q => \^q\(2)
    );
\do_A_reg_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_A_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_A_reg0_in(3),
      Q => \^q\(3)
    );
\do_A_reg_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_A_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_A_reg0_in(4),
      Q => \^q\(4)
    );
\do_A_reg_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_A_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_A_reg0_in(5),
      Q => \^q\(5)
    );
\do_A_reg_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_A_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_A_reg0_in(6),
      Q => \^q\(6)
    );
\do_A_reg_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_A_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_A_reg0_in(7),
      Q => \^q\(7)
    );
\do_A_reg_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_A_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_A_reg0_in(8),
      Q => \^q\(8)
    );
\do_A_reg_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_A_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_A_reg0_in(9),
      Q => \^q\(9)
    );
\do_B_reg[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(1),
      I1 => DO(0),
      O => do_B_reg0_in(0)
    );
\do_B_reg[10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(1),
      I1 => DO(10),
      O => do_B_reg0_in(10)
    );
\do_B_reg[11]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(1),
      I1 => DO(11),
      O => do_B_reg0_in(11)
    );
\do_B_reg[12]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(1),
      I1 => DO(12),
      O => do_B_reg0_in(12)
    );
\do_B_reg[13]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(1),
      I1 => DO(13),
      O => do_B_reg0_in(13)
    );
\do_B_reg[14]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(1),
      I1 => DO(14),
      O => do_B_reg0_in(14)
    );
\do_B_reg[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"31"
    )
        port map (
      I0 => \^state__0\(1),
      I1 => \^state__0\(0),
      I2 => drdy_C,
      O => \do_B_reg[15]_i_1_n_0\
    );
\do_B_reg[15]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(1),
      I1 => DO(15),
      O => do_B_reg0_in(15)
    );
\do_B_reg[15]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => m_axis_resetn,
      O => \^m_axis_reset\
    );
\do_B_reg[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(1),
      I1 => DO(1),
      O => do_B_reg0_in(1)
    );
\do_B_reg[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(1),
      I1 => DO(2),
      O => do_B_reg0_in(2)
    );
\do_B_reg[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(1),
      I1 => DO(3),
      O => do_B_reg0_in(3)
    );
\do_B_reg[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(1),
      I1 => DO(4),
      O => do_B_reg0_in(4)
    );
\do_B_reg[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(1),
      I1 => DO(5),
      O => do_B_reg0_in(5)
    );
\do_B_reg[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(1),
      I1 => DO(6),
      O => do_B_reg0_in(6)
    );
\do_B_reg[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(1),
      I1 => DO(7),
      O => do_B_reg0_in(7)
    );
\do_B_reg[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(1),
      I1 => DO(8),
      O => do_B_reg0_in(8)
    );
\do_B_reg[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^state__0\(1),
      I1 => DO(9),
      O => do_B_reg0_in(9)
    );
\do_B_reg_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_B_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_B_reg0_in(0),
      Q => do_out(0)
    );
\do_B_reg_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_B_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_B_reg0_in(10),
      Q => do_out(10)
    );
\do_B_reg_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_B_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_B_reg0_in(11),
      Q => do_out(11)
    );
\do_B_reg_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_B_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_B_reg0_in(12),
      Q => do_out(12)
    );
\do_B_reg_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_B_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_B_reg0_in(13),
      Q => do_out(13)
    );
\do_B_reg_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_B_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_B_reg0_in(14),
      Q => do_out(14)
    );
\do_B_reg_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_B_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_B_reg0_in(15),
      Q => do_out(15)
    );
\do_B_reg_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_B_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_B_reg0_in(1),
      Q => do_out(1)
    );
\do_B_reg_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_B_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_B_reg0_in(2),
      Q => do_out(2)
    );
\do_B_reg_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_B_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_B_reg0_in(3),
      Q => do_out(3)
    );
\do_B_reg_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_B_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_B_reg0_in(4),
      Q => do_out(4)
    );
\do_B_reg_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_B_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_B_reg0_in(5),
      Q => do_out(5)
    );
\do_B_reg_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_B_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_B_reg0_in(6),
      Q => do_out(6)
    );
\do_B_reg_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_B_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_B_reg0_in(7),
      Q => do_out(7)
    );
\do_B_reg_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_B_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_B_reg0_in(8),
      Q => do_out(8)
    );
\do_B_reg_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \do_B_reg[15]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => do_B_reg0_in(9),
      Q => do_out(9)
    );
drdy_A_reg_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"C808"
    )
        port map (
      I0 => drdy_C,
      I1 => \^state__0\(0),
      I2 => \^state__0\(1),
      I3 => \^drdy_i\,
      O => drdy_A_reg_i_1_n_0
    );
drdy_A_reg_reg: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => drdy_A_reg_i_1_n_0,
      Q => \^drdy_i\
    );
drdy_B_reg_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E020"
    )
        port map (
      I0 => drdy_C,
      I1 => \^state__0\(0),
      I2 => \^state__0\(1),
      I3 => \^drdy_out\,
      O => drdy_B_reg_i_1_n_0
    );
drdy_B_reg_reg: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => drdy_B_reg_i_1_n_0,
      Q => \^drdy_out\
    );
dwe_C_reg_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => dwe_reg_reg_n_0,
      I1 => \daddr_C_reg[6]_i_8_n_0\,
      I2 => dwe_in,
      I3 => \daddr_C_reg[6]_i_6_n_0\,
      O => dwe_C_reg
    );
dwe_C_reg_reg: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \daddr_C_reg[6]_i_1_n_0\,
      CLR => \^m_axis_reset\,
      D => dwe_C_reg,
      Q => dwe_C
    );
dwe_reg_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF8F888888"
    )
        port map (
      I0 => dwe_reg_i_3_n_0,
      I1 => den_A,
      I2 => overlap_A_reg_n_0,
      I3 => dwe_reg_i_4_n_0,
      I4 => dwe_reg_i_5_n_0,
      I5 => dwe_reg_i_6_n_0,
      O => dwe_reg_i_1_n_0
    );
dwe_reg_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"4"
    )
        port map (
      I0 => \^state__0\(1),
      I1 => dwe_in,
      O => dwe_reg
    );
dwe_reg_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^state__0\(1),
      I1 => \^state__0\(0),
      O => dwe_reg_i_3_n_0
    );
dwe_reg_i_4: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => den_in,
      I1 => \^overlap_b_reg_0\,
      O => dwe_reg_i_4_n_0
    );
dwe_reg_i_5: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
        port map (
      I0 => \^state__0\(0),
      I1 => jtaglocked_i,
      I2 => den_A,
      O => dwe_reg_i_5_n_0
    );
dwe_reg_i_6: unisim.vcomponents.LUT5
    generic map(
      INIT => X"22320000"
    )
        port map (
      I0 => \^state__0\(0),
      I1 => \^state__0\(1),
      I2 => bbusy_A,
      I3 => jtaglocked_i,
      I4 => den_in,
      O => dwe_reg_i_6_n_0
    );
dwe_reg_reg: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => dwe_reg_i_1_n_0,
      CLR => \^m_axis_reset\,
      D => dwe_reg,
      Q => dwe_reg_reg_n_0
    );
overlap_A_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAABB80BF80"
    )
        port map (
      I0 => overlap_A,
      I1 => dwe_reg_i_3_n_0,
      I2 => den_A,
      I3 => overlap_A_reg_n_0,
      I4 => drdy_C,
      I5 => overlap_A_i_3_n_0,
      O => overlap_A_i_1_n_0
    );
overlap_A_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FF44F444"
    )
        port map (
      I0 => bbusy_A,
      I1 => dwe_reg_i_5_n_0,
      I2 => overlap_A_reg_n_0,
      I3 => \daddr_C_reg[6]_i_4_n_0\,
      I4 => den_in,
      I5 => \^overlap_b_reg_0\,
      O => overlap_A_i_3_n_0
    );
overlap_A_reg: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => overlap_A_i_1_n_0,
      Q => overlap_A_reg_n_0
    );
overlap_B_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAAAB88"
    )
        port map (
      I0 => overlap_B,
      I1 => overlap_B_i_3_n_0,
      I2 => \daddr_C_reg[6]_i_4_n_0\,
      I3 => \^overlap_b_reg_0\,
      I4 => overlap_B_i_4_n_0,
      O => overlap_B_i_1_n_0
    );
overlap_B_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000E0F0E0E0"
    )
        port map (
      I0 => bbusy_A,
      I1 => \^state__0\(0),
      I2 => den_in,
      I3 => \^overlap_b_reg_0\,
      I4 => den_A,
      I5 => \^state__0\(1),
      O => overlap_B
    );
overlap_B_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00008888000088F8"
    )
        port map (
      I0 => \daddr_C_reg[6]_i_4_n_0\,
      I1 => den_A,
      I2 => den_in,
      I3 => \^state__0\(1),
      I4 => overlap_A_reg_n_0,
      I5 => jtaglocked_i,
      O => overlap_B_i_3_n_0
    );
overlap_B_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAEAAAAAAAAAAAA"
    )
        port map (
      I0 => dwe_reg_i_6_n_0,
      I1 => \^state__0\(0),
      I2 => \^state__0\(1),
      I3 => bbusy_A,
      I4 => \^overlap_b_reg_0\,
      I5 => drdy_C,
      O => overlap_B_i_4_n_0
    );
overlap_B_reg: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => \^m_axis_reset\,
      D => overlap_B_i_1_n_0,
      Q => \^overlap_b_reg_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity xadc_wiz_0_drp_to_axi4stream is
  port (
    m_axis_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_tid : out STD_LOGIC_VECTOR ( 4 downto 0 );
    \channel_id_reg[6]_0\ : out STD_LOGIC_VECTOR ( 5 downto 0 );
    den_A : out STD_LOGIC;
    bbusy_A : out STD_LOGIC;
    valid_data_wren_reg_0 : out STD_LOGIC;
    \FSM_sequential_state_reg[0]_0\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_aclk_0 : out STD_LOGIC;
    \FSM_sequential_state_reg[1]_0\ : out STD_LOGIC;
    den_reg : out STD_LOGIC;
    overlap_A : out STD_LOGIC;
    busy_o_reg_0 : out STD_LOGIC;
    daddr_in_2_sp_1 : out STD_LOGIC;
    m_axis_tvalid : out STD_LOGIC;
    temp_out : out STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axis_aclk : in STD_LOGIC;
    m_axis_reset : in STD_LOGIC;
    m_axis_aclk : in STD_LOGIC;
    wren_fifo : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 15 downto 0 );
    drdy_i : in STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    eoc_out : in STD_LOGIC;
    mode_change : in STD_LOGIC;
    \FSM_sequential_state_reg[3]_0\ : in STD_LOGIC;
    \FSM_sequential_state_reg[1]_1\ : in STD_LOGIC;
    \FSM_sequential_state_reg[2]_0\ : in STD_LOGIC;
    channel_out : in STD_LOGIC_VECTOR ( 4 downto 0 );
    den_in : in STD_LOGIC;
    \state__0\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \FSM_sequential_state_reg[0]_1\ : in STD_LOGIC;
    mode_change_reg : in STD_LOGIC;
    daddr_in : in STD_LOGIC_VECTOR ( 2 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of xadc_wiz_0_drp_to_axi4stream : entity is "drp_to_axi4stream";
end xadc_wiz_0_drp_to_axi4stream;

architecture STRUCTURE of xadc_wiz_0_drp_to_axi4stream is
  signal FIFO18E1_inst_data_i_1_n_0 : STD_LOGIC;
  signal \FSM_sequential_state[0]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[3]_i_10_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[3]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[3]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[3]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[3]_i_5_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[3]_i_6_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[3]_i_8_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[3]_i_9_n_0\ : STD_LOGIC;
  signal \^fsm_sequential_state_reg[0]_0\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^fsm_sequential_state_reg[1]_0\ : STD_LOGIC;
  signal almost_full : STD_LOGIC;
  signal \^bbusy_a\ : STD_LOGIC;
  signal busy_o_i_1_n_0 : STD_LOGIC;
  signal channel_id : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \channel_id[6]_i_1_n_0\ : STD_LOGIC;
  signal \^channel_id_reg[6]_0\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal daddr_in_2_sn_1 : STD_LOGIC;
  signal \^den_a\ : STD_LOGIC;
  signal den_o_i_1_n_0 : STD_LOGIC;
  signal drp_rdwr_status : STD_LOGIC;
  signal drp_rdwr_status0 : STD_LOGIC;
  signal drp_rdwr_status_i_1_n_0 : STD_LOGIC;
  signal fifo_empty : STD_LOGIC;
  signal \^m_axis_aclk_0\ : STD_LOGIC;
  signal mode_change_sig_reset : STD_LOGIC;
  signal mode_change_sig_reset_i_1_n_0 : STD_LOGIC;
  signal state : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \state__0_0\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \temp_out[11]_i_1_n_0\ : STD_LOGIC;
  signal \timer_cntr[0]_i_2_n_0\ : STD_LOGIC;
  signal \timer_cntr[0]_i_3_n_0\ : STD_LOGIC;
  signal \timer_cntr[0]_i_4_n_0\ : STD_LOGIC;
  signal \timer_cntr[0]_i_5_n_0\ : STD_LOGIC;
  signal \timer_cntr[0]_i_6_n_0\ : STD_LOGIC;
  signal \timer_cntr[12]_i_2_n_0\ : STD_LOGIC;
  signal \timer_cntr[12]_i_3_n_0\ : STD_LOGIC;
  signal \timer_cntr[12]_i_4_n_0\ : STD_LOGIC;
  signal \timer_cntr[12]_i_5_n_0\ : STD_LOGIC;
  signal \timer_cntr[4]_i_2_n_0\ : STD_LOGIC;
  signal \timer_cntr[4]_i_3_n_0\ : STD_LOGIC;
  signal \timer_cntr[4]_i_4_n_0\ : STD_LOGIC;
  signal \timer_cntr[4]_i_5_n_0\ : STD_LOGIC;
  signal \timer_cntr[4]_i_6_n_0\ : STD_LOGIC;
  signal \timer_cntr[8]_i_2_n_0\ : STD_LOGIC;
  signal \timer_cntr[8]_i_3_n_0\ : STD_LOGIC;
  signal \timer_cntr[8]_i_4_n_0\ : STD_LOGIC;
  signal \timer_cntr[8]_i_5_n_0\ : STD_LOGIC;
  signal timer_cntr_reg : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \timer_cntr_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \timer_cntr_reg[0]_i_1_n_1\ : STD_LOGIC;
  signal \timer_cntr_reg[0]_i_1_n_2\ : STD_LOGIC;
  signal \timer_cntr_reg[0]_i_1_n_3\ : STD_LOGIC;
  signal \timer_cntr_reg[0]_i_1_n_4\ : STD_LOGIC;
  signal \timer_cntr_reg[0]_i_1_n_5\ : STD_LOGIC;
  signal \timer_cntr_reg[0]_i_1_n_6\ : STD_LOGIC;
  signal \timer_cntr_reg[0]_i_1_n_7\ : STD_LOGIC;
  signal \timer_cntr_reg[12]_i_1_n_1\ : STD_LOGIC;
  signal \timer_cntr_reg[12]_i_1_n_2\ : STD_LOGIC;
  signal \timer_cntr_reg[12]_i_1_n_3\ : STD_LOGIC;
  signal \timer_cntr_reg[12]_i_1_n_4\ : STD_LOGIC;
  signal \timer_cntr_reg[12]_i_1_n_5\ : STD_LOGIC;
  signal \timer_cntr_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \timer_cntr_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \timer_cntr_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \timer_cntr_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \timer_cntr_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \timer_cntr_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \timer_cntr_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \timer_cntr_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \timer_cntr_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \timer_cntr_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \timer_cntr_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \timer_cntr_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \timer_cntr_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \timer_cntr_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \timer_cntr_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \timer_cntr_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \timer_cntr_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \timer_cntr_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal valid_data_wren_i_1_n_0 : STD_LOGIC;
  signal \^valid_data_wren_reg_0\ : STD_LOGIC;
  signal NLW_FIFO18E1_inst_data_ALMOSTEMPTY_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO18E1_inst_data_FULL_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO18E1_inst_data_RDERR_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO18E1_inst_data_WRERR_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO18E1_inst_data_DO_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 16 );
  signal NLW_FIFO18E1_inst_data_DOP_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_FIFO18E1_inst_data_RDCOUNT_UNCONNECTED : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal NLW_FIFO18E1_inst_data_WRCOUNT_UNCONNECTED : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal NLW_FIFO18E1_inst_tid_ALMOSTEMPTY_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO18E1_inst_tid_ALMOSTFULL_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO18E1_inst_tid_EMPTY_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO18E1_inst_tid_FULL_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO18E1_inst_tid_RDERR_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO18E1_inst_tid_WRERR_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO18E1_inst_tid_DO_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 5 );
  signal NLW_FIFO18E1_inst_tid_DOP_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_FIFO18E1_inst_tid_RDCOUNT_UNCONNECTED : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal NLW_FIFO18E1_inst_tid_WRCOUNT_UNCONNECTED : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal \NLW_timer_cntr_reg[12]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute box_type : string;
  attribute box_type of FIFO18E1_inst_data : label is "PRIMITIVE";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of FIFO18E1_inst_data_i_1 : label is "soft_lutpair39";
  attribute box_type of FIFO18E1_inst_tid : label is "PRIMITIVE";
  attribute SOFT_HLUTNM of \FSM_sequential_state[3]_i_11\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \FSM_sequential_state[3]_i_5\ : label is "soft_lutpair34";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_reg[0]\ : label is "wait_ind_adc:0111,wait_mode_change:0000,wait_seq_s_ch:1000,rd_ctrl_reg_temp:1010,rd_ctrl_reg_41:0010,rd_en_ctrl_reg_41:0001,rd_b_reg_cmd:0101,rd_en_ctrl_reg_temp:1001,rd_b_reg:0110,rd_a_reg:0100,wait_sim_samp:0011";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_reg[1]\ : label is "wait_ind_adc:0111,wait_mode_change:0000,wait_seq_s_ch:1000,rd_ctrl_reg_temp:1010,rd_ctrl_reg_41:0010,rd_en_ctrl_reg_41:0001,rd_b_reg_cmd:0101,rd_en_ctrl_reg_temp:1001,rd_b_reg:0110,rd_a_reg:0100,wait_sim_samp:0011";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_reg[2]\ : label is "wait_ind_adc:0111,wait_mode_change:0000,wait_seq_s_ch:1000,rd_ctrl_reg_temp:1010,rd_ctrl_reg_41:0010,rd_en_ctrl_reg_41:0001,rd_b_reg_cmd:0101,rd_en_ctrl_reg_temp:1001,rd_b_reg:0110,rd_a_reg:0100,wait_sim_samp:0011";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_reg[3]\ : label is "wait_ind_adc:0111,wait_mode_change:0000,wait_seq_s_ch:1000,rd_ctrl_reg_temp:1010,rd_ctrl_reg_41:0010,rd_en_ctrl_reg_41:0001,rd_b_reg_cmd:0101,rd_en_ctrl_reg_temp:1001,rd_b_reg:0110,rd_a_reg:0100,wait_sim_samp:0011";
  attribute SOFT_HLUTNM of \channel_id[0]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \channel_id[2]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \channel_id[3]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \channel_id[6]_i_2\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of den_o_i_2 : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of den_reg_i_1 : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of drp_rdwr_status_i_1 : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of m_axis_tvalid_INST_0 : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of overlap_A_i_2 : label is "soft_lutpair37";
begin
  \FSM_sequential_state_reg[0]_0\(0) <= \^fsm_sequential_state_reg[0]_0\(0);
  \FSM_sequential_state_reg[1]_0\ <= \^fsm_sequential_state_reg[1]_0\;
  bbusy_A <= \^bbusy_a\;
  \channel_id_reg[6]_0\(5 downto 0) <= \^channel_id_reg[6]_0\(5 downto 0);
  daddr_in_2_sp_1 <= daddr_in_2_sn_1;
  den_A <= \^den_a\;
  m_axis_aclk_0 <= \^m_axis_aclk_0\;
  valid_data_wren_reg_0 <= \^valid_data_wren_reg_0\;
FIFO18E1_inst_data: unisim.vcomponents.FIFO18E1
    generic map(
      ALMOST_EMPTY_OFFSET => X"0006",
      ALMOST_FULL_OFFSET => X"03F9",
      DATA_WIDTH => 18,
      DO_REG => 1,
      EN_SYN => false,
      FIFO_MODE => "FIFO18",
      FIRST_WORD_FALL_THROUGH => true,
      INIT => X"000000000",
      IS_RDCLK_INVERTED => '0',
      IS_RDEN_INVERTED => '0',
      IS_RSTREG_INVERTED => '0',
      IS_RST_INVERTED => '0',
      IS_WRCLK_INVERTED => '0',
      IS_WREN_INVERTED => '0',
      SIM_DEVICE => "7SERIES",
      SRVAL => X"000000000"
    )
        port map (
      ALMOSTEMPTY => NLW_FIFO18E1_inst_data_ALMOSTEMPTY_UNCONNECTED,
      ALMOSTFULL => almost_full,
      DI(31 downto 16) => B"0000000000000000",
      DI(15 downto 0) => Q(15 downto 0),
      DIP(3 downto 0) => B"0000",
      DO(31 downto 16) => NLW_FIFO18E1_inst_data_DO_UNCONNECTED(31 downto 16),
      DO(15 downto 0) => m_axis_tdata(15 downto 0),
      DOP(3 downto 0) => NLW_FIFO18E1_inst_data_DOP_UNCONNECTED(3 downto 0),
      EMPTY => fifo_empty,
      FULL => NLW_FIFO18E1_inst_data_FULL_UNCONNECTED,
      RDCLK => s_axis_aclk,
      RDCOUNT(11 downto 0) => NLW_FIFO18E1_inst_data_RDCOUNT_UNCONNECTED(11 downto 0),
      RDEN => FIFO18E1_inst_data_i_1_n_0,
      RDERR => NLW_FIFO18E1_inst_data_RDERR_UNCONNECTED,
      REGCE => '1',
      RST => m_axis_reset,
      RSTREG => '0',
      WRCLK => m_axis_aclk,
      WRCOUNT(11 downto 0) => NLW_FIFO18E1_inst_data_WRCOUNT_UNCONNECTED(11 downto 0),
      WREN => wren_fifo,
      WRERR => NLW_FIFO18E1_inst_data_WRERR_UNCONNECTED
    );
FIFO18E1_inst_data_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => m_axis_tready,
      I1 => fifo_empty,
      O => FIFO18E1_inst_data_i_1_n_0
    );
FIFO18E1_inst_tid: unisim.vcomponents.FIFO18E1
    generic map(
      ALMOST_EMPTY_OFFSET => X"0006",
      ALMOST_FULL_OFFSET => X"03F9",
      DATA_WIDTH => 18,
      DO_REG => 1,
      EN_SYN => false,
      FIFO_MODE => "FIFO18",
      FIRST_WORD_FALL_THROUGH => true,
      INIT => X"000000000",
      IS_RDCLK_INVERTED => '0',
      IS_RDEN_INVERTED => '0',
      IS_RSTREG_INVERTED => '0',
      IS_RST_INVERTED => '0',
      IS_WRCLK_INVERTED => '0',
      IS_WREN_INVERTED => '0',
      SIM_DEVICE => "7SERIES",
      SRVAL => X"000000000"
    )
        port map (
      ALMOSTEMPTY => NLW_FIFO18E1_inst_tid_ALMOSTEMPTY_UNCONNECTED,
      ALMOSTFULL => NLW_FIFO18E1_inst_tid_ALMOSTFULL_UNCONNECTED,
      DI(31 downto 7) => B"0000000000000000000000000",
      DI(6) => \^channel_id_reg[6]_0\(5),
      DI(5) => '0',
      DI(4 downto 0) => \^channel_id_reg[6]_0\(4 downto 0),
      DIP(3 downto 0) => B"0000",
      DO(31 downto 5) => NLW_FIFO18E1_inst_tid_DO_UNCONNECTED(31 downto 5),
      DO(4 downto 0) => m_axis_tid(4 downto 0),
      DOP(3 downto 0) => NLW_FIFO18E1_inst_tid_DOP_UNCONNECTED(3 downto 0),
      EMPTY => NLW_FIFO18E1_inst_tid_EMPTY_UNCONNECTED,
      FULL => NLW_FIFO18E1_inst_tid_FULL_UNCONNECTED,
      RDCLK => s_axis_aclk,
      RDCOUNT(11 downto 0) => NLW_FIFO18E1_inst_tid_RDCOUNT_UNCONNECTED(11 downto 0),
      RDEN => FIFO18E1_inst_data_i_1_n_0,
      RDERR => NLW_FIFO18E1_inst_tid_RDERR_UNCONNECTED,
      REGCE => '1',
      RST => m_axis_reset,
      RSTREG => '0',
      WRCLK => m_axis_aclk,
      WRCOUNT(11 downto 0) => NLW_FIFO18E1_inst_tid_WRCOUNT_UNCONNECTED(11 downto 0),
      WREN => wren_fifo,
      WRERR => NLW_FIFO18E1_inst_tid_WRERR_UNCONNECTED
    );
\FSM_sequential_state[0]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0135313501050105"
    )
        port map (
      I0 => \^fsm_sequential_state_reg[0]_0\(0),
      I1 => state(3),
      I2 => state(1),
      I3 => mode_change,
      I4 => state(2),
      I5 => \FSM_sequential_state[0]_i_2_n_0\,
      O => \state__0_0\(0)
    );
\FSM_sequential_state[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2F0F2FFF2FFF2F0F"
    )
        port map (
      I0 => \^m_axis_aclk_0\,
      I1 => mode_change,
      I2 => \^fsm_sequential_state_reg[1]_0\,
      I3 => \^fsm_sequential_state_reg[0]_0\(0),
      I4 => Q(14),
      I5 => Q(15),
      O => \FSM_sequential_state[0]_i_2_n_0\
    );
\FSM_sequential_state[0]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AB"
    )
        port map (
      I0 => \^bbusy_a\,
      I1 => den_in,
      I2 => \FSM_sequential_state_reg[0]_1\,
      O => busy_o_reg_0
    );
\FSM_sequential_state[1]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"001FAAAA0010AAAA"
    )
        port map (
      I0 => \^fsm_sequential_state_reg[0]_0\(0),
      I1 => mode_change,
      I2 => state(2),
      I3 => state(3),
      I4 => state(1),
      I5 => \FSM_sequential_state_reg[1]_1\,
      O => \state__0_0\(1)
    );
\FSM_sequential_state[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1014"
    )
        port map (
      I0 => state(3),
      I1 => state(1),
      I2 => state(2),
      I3 => \FSM_sequential_state_reg[2]_0\,
      O => \state__0_0\(2)
    );
\FSM_sequential_state[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF1110000"
    )
        port map (
      I0 => \FSM_sequential_state[3]_i_3_n_0\,
      I1 => \FSM_sequential_state[3]_i_4_n_0\,
      I2 => mode_change,
      I3 => drdy_i,
      I4 => \FSM_sequential_state[3]_i_5_n_0\,
      I5 => \FSM_sequential_state[3]_i_6_n_0\,
      O => \FSM_sequential_state[3]_i_1_n_0\
    );
\FSM_sequential_state[3]_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => timer_cntr_reg(10),
      I1 => timer_cntr_reg(9),
      I2 => timer_cntr_reg(11),
      I3 => timer_cntr_reg(8),
      O => \FSM_sequential_state[3]_i_10_n_0\
    );
\FSM_sequential_state[3]_i_11\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"53"
    )
        port map (
      I0 => state(1),
      I1 => state(2),
      I2 => state(3),
      O => \^fsm_sequential_state_reg[1]_0\
    );
\FSM_sequential_state[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"002FBB000000BB00"
    )
        port map (
      I0 => \^fsm_sequential_state_reg[0]_0\(0),
      I1 => mode_change,
      I2 => state(2),
      I3 => state(3),
      I4 => state(1),
      I5 => \FSM_sequential_state_reg[3]_0\,
      O => \state__0_0\(3)
    );
\FSM_sequential_state[3]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFF8"
    )
        port map (
      I0 => timer_cntr_reg(3),
      I1 => \FSM_sequential_state[3]_i_8_n_0\,
      I2 => drp_rdwr_status,
      I3 => mode_change,
      I4 => eoc_out,
      O => \FSM_sequential_state[3]_i_3_n_0\
    );
\FSM_sequential_state[3]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => timer_cntr_reg(14),
      I1 => timer_cntr_reg(15),
      I2 => timer_cntr_reg(12),
      I3 => timer_cntr_reg(13),
      I4 => \FSM_sequential_state[3]_i_9_n_0\,
      I5 => \FSM_sequential_state[3]_i_10_n_0\,
      O => \FSM_sequential_state[3]_i_4_n_0\
    );
\FSM_sequential_state[3]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1F11"
    )
        port map (
      I0 => state(2),
      I1 => state(1),
      I2 => state(3),
      I3 => \^fsm_sequential_state_reg[0]_0\(0),
      O => \FSM_sequential_state[3]_i_5_n_0\
    );
\FSM_sequential_state[3]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"031F001033F330F3"
    )
        port map (
      I0 => \^m_axis_aclk_0\,
      I1 => state(3),
      I2 => \^fsm_sequential_state_reg[0]_0\(0),
      I3 => state(2),
      I4 => drdy_i,
      I5 => state(1),
      O => \FSM_sequential_state[3]_i_6_n_0\
    );
\FSM_sequential_state[3]_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => timer_cntr_reg(0),
      I1 => timer_cntr_reg(2),
      I2 => timer_cntr_reg(1),
      O => \FSM_sequential_state[3]_i_8_n_0\
    );
\FSM_sequential_state[3]_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => timer_cntr_reg(7),
      I1 => timer_cntr_reg(6),
      I2 => timer_cntr_reg(5),
      I3 => timer_cntr_reg(4),
      O => \FSM_sequential_state[3]_i_9_n_0\
    );
\FSM_sequential_state_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \FSM_sequential_state[3]_i_1_n_0\,
      CLR => m_axis_reset,
      D => \state__0_0\(0),
      Q => \^fsm_sequential_state_reg[0]_0\(0)
    );
\FSM_sequential_state_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \FSM_sequential_state[3]_i_1_n_0\,
      CLR => m_axis_reset,
      D => \state__0_0\(1),
      Q => state(1)
    );
\FSM_sequential_state_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \FSM_sequential_state[3]_i_1_n_0\,
      CLR => m_axis_reset,
      D => \state__0_0\(2),
      Q => state(2)
    );
\FSM_sequential_state_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \FSM_sequential_state[3]_i_1_n_0\,
      CLR => m_axis_reset,
      D => \state__0_0\(3),
      Q => state(3)
    );
busy_o_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFA55FA00001000"
    )
        port map (
      I0 => state(2),
      I1 => \^m_axis_aclk_0\,
      I2 => \^fsm_sequential_state_reg[0]_0\(0),
      I3 => state(1),
      I4 => state(3),
      I5 => \^bbusy_a\,
      O => busy_o_i_1_n_0
    );
busy_o_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => eoc_out,
      I1 => channel_out(4),
      O => \^m_axis_aclk_0\
    );
busy_o_reg: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => m_axis_reset,
      D => busy_o_i_1_n_0,
      Q => \^bbusy_a\
    );
\channel_id[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"01FF0003"
    )
        port map (
      I0 => \^fsm_sequential_state_reg[0]_0\(0),
      I1 => state(2),
      I2 => state(1),
      I3 => state(3),
      I4 => channel_out(0),
      O => channel_id(0)
    );
\channel_id[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"222022AA"
    )
        port map (
      I0 => channel_out(1),
      I1 => state(3),
      I2 => state(1),
      I3 => state(2),
      I4 => \^fsm_sequential_state_reg[0]_0\(0),
      O => channel_id(1)
    );
\channel_id[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"222022AA"
    )
        port map (
      I0 => channel_out(2),
      I1 => state(3),
      I2 => state(1),
      I3 => state(2),
      I4 => \^fsm_sequential_state_reg[0]_0\(0),
      O => channel_id(2)
    );
\channel_id[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"212021AA"
    )
        port map (
      I0 => channel_out(3),
      I1 => state(3),
      I2 => state(1),
      I3 => state(2),
      I4 => \^fsm_sequential_state_reg[0]_0\(0),
      O => channel_id(3)
    );
\channel_id[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0044C3C40044CCC4"
    )
        port map (
      I0 => \^fsm_sequential_state_reg[0]_0\(0),
      I1 => channel_out(4),
      I2 => state(1),
      I3 => state(2),
      I4 => state(3),
      I5 => channel_out(3),
      O => channel_id(4)
    );
\channel_id[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"222E"
    )
        port map (
      I0 => \^fsm_sequential_state_reg[0]_0\(0),
      I1 => state(3),
      I2 => state(2),
      I3 => state(1),
      O => \channel_id[6]_i_1_n_0\
    );
\channel_id[6]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => state(2),
      I1 => state(1),
      I2 => state(3),
      O => channel_id(6)
    );
\channel_id_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \channel_id[6]_i_1_n_0\,
      CLR => m_axis_reset,
      D => channel_id(0),
      Q => \^channel_id_reg[6]_0\(0)
    );
\channel_id_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \channel_id[6]_i_1_n_0\,
      CLR => m_axis_reset,
      D => channel_id(1),
      Q => \^channel_id_reg[6]_0\(1)
    );
\channel_id_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \channel_id[6]_i_1_n_0\,
      CLR => m_axis_reset,
      D => channel_id(2),
      Q => \^channel_id_reg[6]_0\(2)
    );
\channel_id_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \channel_id[6]_i_1_n_0\,
      CLR => m_axis_reset,
      D => channel_id(3),
      Q => \^channel_id_reg[6]_0\(3)
    );
\channel_id_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \channel_id[6]_i_1_n_0\,
      CLR => m_axis_reset,
      D => channel_id(4),
      Q => \^channel_id_reg[6]_0\(4)
    );
\channel_id_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \channel_id[6]_i_1_n_0\,
      CLR => m_axis_reset,
      D => channel_id(6),
      Q => \^channel_id_reg[6]_0\(5)
    );
den_o_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F8FCC8EC080C08EC"
    )
        port map (
      I0 => drp_rdwr_status0,
      I1 => \^fsm_sequential_state_reg[0]_0\(0),
      I2 => state(3),
      I3 => state(1),
      I4 => state(2),
      I5 => \^den_a\,
      O => den_o_i_1_n_0
    );
den_o_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => eoc_out,
      I1 => almost_full,
      O => drp_rdwr_status0
    );
den_o_reg: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => m_axis_reset,
      D => den_o_i_1_n_0,
      Q => \^den_a\
    );
den_reg_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00CCAAC8"
    )
        port map (
      I0 => \^den_a\,
      I1 => den_in,
      I2 => \^bbusy_a\,
      I3 => \state__0\(1),
      I4 => \state__0\(0),
      O => den_reg
    );
drp_rdwr_status_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7530"
    )
        port map (
      I0 => drdy_i,
      I1 => almost_full,
      I2 => eoc_out,
      I3 => drp_rdwr_status,
      O => drp_rdwr_status_i_1_n_0
    );
drp_rdwr_status_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => m_axis_reset,
      D => drp_rdwr_status_i_1_n_0,
      Q => drp_rdwr_status
    );
m_axis_tvalid_INST_0: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => fifo_empty,
      O => m_axis_tvalid
    );
mode_change_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0200FFFF02000200"
    )
        port map (
      I0 => mode_change_reg,
      I1 => daddr_in(2),
      I2 => daddr_in(1),
      I3 => daddr_in(0),
      I4 => mode_change_sig_reset,
      I5 => mode_change,
      O => daddr_in_2_sn_1
    );
mode_change_sig_reset_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFD0001"
    )
        port map (
      I0 => \^fsm_sequential_state_reg[0]_0\(0),
      I1 => state(2),
      I2 => state(1),
      I3 => state(3),
      I4 => mode_change_sig_reset,
      O => mode_change_sig_reset_i_1_n_0
    );
mode_change_sig_reset_reg: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => m_axis_reset,
      D => mode_change_sig_reset_i_1_n_0,
      Q => mode_change_sig_reset
    );
overlap_A_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00C8"
    )
        port map (
      I0 => \^bbusy_a\,
      I1 => \^den_a\,
      I2 => \state__0\(1),
      I3 => \state__0\(0),
      O => overlap_A
    );
\temp_out[11]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"10000000"
    )
        port map (
      I0 => \^fsm_sequential_state_reg[0]_0\(0),
      I1 => state(2),
      I2 => drdy_i,
      I3 => state(1),
      I4 => state(3),
      O => \temp_out[11]_i_1_n_0\
    );
\temp_out_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => m_axis_reset,
      D => Q(4),
      Q => temp_out(0)
    );
\temp_out_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => m_axis_reset,
      D => Q(14),
      Q => temp_out(10)
    );
\temp_out_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => m_axis_reset,
      D => Q(15),
      Q => temp_out(11)
    );
\temp_out_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => m_axis_reset,
      D => Q(5),
      Q => temp_out(1)
    );
\temp_out_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => m_axis_reset,
      D => Q(6),
      Q => temp_out(2)
    );
\temp_out_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => m_axis_reset,
      D => Q(7),
      Q => temp_out(3)
    );
\temp_out_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => m_axis_reset,
      D => Q(8),
      Q => temp_out(4)
    );
\temp_out_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => m_axis_reset,
      D => Q(9),
      Q => temp_out(5)
    );
\temp_out_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => m_axis_reset,
      D => Q(10),
      Q => temp_out(6)
    );
\temp_out_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => m_axis_reset,
      D => Q(11),
      Q => temp_out(7)
    );
\temp_out_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => m_axis_reset,
      D => Q(12),
      Q => temp_out(8)
    );
\temp_out_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => \temp_out[11]_i_1_n_0\,
      CLR => m_axis_reset,
      D => Q(13),
      Q => temp_out(9)
    );
\timer_cntr[0]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => timer_cntr_reg(3),
      I1 => timer_cntr_reg(0),
      I2 => timer_cntr_reg(2),
      I3 => timer_cntr_reg(1),
      I4 => \FSM_sequential_state[3]_i_4_n_0\,
      O => \timer_cntr[0]_i_2_n_0\
    );
\timer_cntr[0]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => timer_cntr_reg(3),
      O => \timer_cntr[0]_i_3_n_0\
    );
\timer_cntr[0]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0F0F0F0E"
    )
        port map (
      I0 => \FSM_sequential_state[3]_i_4_n_0\,
      I1 => timer_cntr_reg(1),
      I2 => timer_cntr_reg(2),
      I3 => timer_cntr_reg(0),
      I4 => timer_cntr_reg(3),
      O => \timer_cntr[0]_i_4_n_0\
    );
\timer_cntr[0]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"33333332"
    )
        port map (
      I0 => \FSM_sequential_state[3]_i_4_n_0\,
      I1 => timer_cntr_reg(1),
      I2 => timer_cntr_reg(2),
      I3 => timer_cntr_reg(0),
      I4 => timer_cntr_reg(3),
      O => \timer_cntr[0]_i_5_n_0\
    );
\timer_cntr[0]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00FF00FE"
    )
        port map (
      I0 => \FSM_sequential_state[3]_i_4_n_0\,
      I1 => timer_cntr_reg(1),
      I2 => timer_cntr_reg(2),
      I3 => timer_cntr_reg(0),
      I4 => timer_cntr_reg(3),
      O => \timer_cntr[0]_i_6_n_0\
    );
\timer_cntr[12]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FFFFFFFE"
    )
        port map (
      I0 => \FSM_sequential_state[3]_i_4_n_0\,
      I1 => timer_cntr_reg(1),
      I2 => timer_cntr_reg(2),
      I3 => timer_cntr_reg(0),
      I4 => timer_cntr_reg(3),
      I5 => timer_cntr_reg(15),
      O => \timer_cntr[12]_i_2_n_0\
    );
\timer_cntr[12]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5555555555555556"
    )
        port map (
      I0 => timer_cntr_reg(14),
      I1 => \FSM_sequential_state[3]_i_4_n_0\,
      I2 => timer_cntr_reg(1),
      I3 => timer_cntr_reg(2),
      I4 => timer_cntr_reg(0),
      I5 => timer_cntr_reg(3),
      O => \timer_cntr[12]_i_3_n_0\
    );
\timer_cntr[12]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5555555555555556"
    )
        port map (
      I0 => timer_cntr_reg(13),
      I1 => \FSM_sequential_state[3]_i_4_n_0\,
      I2 => timer_cntr_reg(1),
      I3 => timer_cntr_reg(2),
      I4 => timer_cntr_reg(0),
      I5 => timer_cntr_reg(3),
      O => \timer_cntr[12]_i_4_n_0\
    );
\timer_cntr[12]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5555555555555556"
    )
        port map (
      I0 => timer_cntr_reg(12),
      I1 => \FSM_sequential_state[3]_i_4_n_0\,
      I2 => timer_cntr_reg(1),
      I3 => timer_cntr_reg(2),
      I4 => timer_cntr_reg(0),
      I5 => timer_cntr_reg(3),
      O => \timer_cntr[12]_i_5_n_0\
    );
\timer_cntr[4]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => timer_cntr_reg(3),
      I1 => timer_cntr_reg(0),
      I2 => timer_cntr_reg(2),
      I3 => timer_cntr_reg(1),
      I4 => \FSM_sequential_state[3]_i_4_n_0\,
      O => \timer_cntr[4]_i_2_n_0\
    );
\timer_cntr[4]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5555555555555557"
    )
        port map (
      I0 => timer_cntr_reg(7),
      I1 => \FSM_sequential_state[3]_i_4_n_0\,
      I2 => timer_cntr_reg(1),
      I3 => timer_cntr_reg(2),
      I4 => timer_cntr_reg(0),
      I5 => timer_cntr_reg(3),
      O => \timer_cntr[4]_i_3_n_0\
    );
\timer_cntr[4]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5555555555555557"
    )
        port map (
      I0 => timer_cntr_reg(6),
      I1 => \FSM_sequential_state[3]_i_4_n_0\,
      I2 => timer_cntr_reg(1),
      I3 => timer_cntr_reg(2),
      I4 => timer_cntr_reg(0),
      I5 => timer_cntr_reg(3),
      O => \timer_cntr[4]_i_4_n_0\
    );
\timer_cntr[4]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5555555555555557"
    )
        port map (
      I0 => timer_cntr_reg(5),
      I1 => \FSM_sequential_state[3]_i_4_n_0\,
      I2 => timer_cntr_reg(1),
      I3 => timer_cntr_reg(2),
      I4 => timer_cntr_reg(0),
      I5 => timer_cntr_reg(3),
      O => \timer_cntr[4]_i_5_n_0\
    );
\timer_cntr[4]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5555555555555556"
    )
        port map (
      I0 => timer_cntr_reg(4),
      I1 => \FSM_sequential_state[3]_i_4_n_0\,
      I2 => timer_cntr_reg(1),
      I3 => timer_cntr_reg(2),
      I4 => timer_cntr_reg(0),
      I5 => timer_cntr_reg(3),
      O => \timer_cntr[4]_i_6_n_0\
    );
\timer_cntr[8]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5555555555555556"
    )
        port map (
      I0 => timer_cntr_reg(11),
      I1 => \FSM_sequential_state[3]_i_4_n_0\,
      I2 => timer_cntr_reg(1),
      I3 => timer_cntr_reg(2),
      I4 => timer_cntr_reg(0),
      I5 => timer_cntr_reg(3),
      O => \timer_cntr[8]_i_2_n_0\
    );
\timer_cntr[8]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5555555555555556"
    )
        port map (
      I0 => timer_cntr_reg(10),
      I1 => \FSM_sequential_state[3]_i_4_n_0\,
      I2 => timer_cntr_reg(1),
      I3 => timer_cntr_reg(2),
      I4 => timer_cntr_reg(0),
      I5 => timer_cntr_reg(3),
      O => \timer_cntr[8]_i_3_n_0\
    );
\timer_cntr[8]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5555555555555557"
    )
        port map (
      I0 => timer_cntr_reg(9),
      I1 => \FSM_sequential_state[3]_i_4_n_0\,
      I2 => timer_cntr_reg(1),
      I3 => timer_cntr_reg(2),
      I4 => timer_cntr_reg(0),
      I5 => timer_cntr_reg(3),
      O => \timer_cntr[8]_i_4_n_0\
    );
\timer_cntr[8]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5555555555555557"
    )
        port map (
      I0 => timer_cntr_reg(8),
      I1 => \FSM_sequential_state[3]_i_4_n_0\,
      I2 => timer_cntr_reg(1),
      I3 => timer_cntr_reg(2),
      I4 => timer_cntr_reg(0),
      I5 => timer_cntr_reg(3),
      O => \timer_cntr[8]_i_5_n_0\
    );
\timer_cntr_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => m_axis_reset,
      D => \timer_cntr_reg[0]_i_1_n_7\,
      Q => timer_cntr_reg(0)
    );
\timer_cntr_reg[0]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \timer_cntr_reg[0]_i_1_n_0\,
      CO(2) => \timer_cntr_reg[0]_i_1_n_1\,
      CO(1) => \timer_cntr_reg[0]_i_1_n_2\,
      CO(0) => \timer_cntr_reg[0]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \timer_cntr[0]_i_2_n_0\,
      DI(2 downto 0) => timer_cntr_reg(2 downto 0),
      O(3) => \timer_cntr_reg[0]_i_1_n_4\,
      O(2) => \timer_cntr_reg[0]_i_1_n_5\,
      O(1) => \timer_cntr_reg[0]_i_1_n_6\,
      O(0) => \timer_cntr_reg[0]_i_1_n_7\,
      S(3) => \timer_cntr[0]_i_3_n_0\,
      S(2) => \timer_cntr[0]_i_4_n_0\,
      S(1) => \timer_cntr[0]_i_5_n_0\,
      S(0) => \timer_cntr[0]_i_6_n_0\
    );
\timer_cntr_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => m_axis_reset,
      D => \timer_cntr_reg[8]_i_1_n_5\,
      Q => timer_cntr_reg(10)
    );
\timer_cntr_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => m_axis_reset,
      D => \timer_cntr_reg[8]_i_1_n_4\,
      Q => timer_cntr_reg(11)
    );
\timer_cntr_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => m_axis_reset,
      D => \timer_cntr_reg[12]_i_1_n_7\,
      Q => timer_cntr_reg(12)
    );
\timer_cntr_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timer_cntr_reg[8]_i_1_n_0\,
      CO(3) => \NLW_timer_cntr_reg[12]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \timer_cntr_reg[12]_i_1_n_1\,
      CO(1) => \timer_cntr_reg[12]_i_1_n_2\,
      CO(0) => \timer_cntr_reg[12]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2 downto 0) => timer_cntr_reg(14 downto 12),
      O(3) => \timer_cntr_reg[12]_i_1_n_4\,
      O(2) => \timer_cntr_reg[12]_i_1_n_5\,
      O(1) => \timer_cntr_reg[12]_i_1_n_6\,
      O(0) => \timer_cntr_reg[12]_i_1_n_7\,
      S(3) => \timer_cntr[12]_i_2_n_0\,
      S(2) => \timer_cntr[12]_i_3_n_0\,
      S(1) => \timer_cntr[12]_i_4_n_0\,
      S(0) => \timer_cntr[12]_i_5_n_0\
    );
\timer_cntr_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => m_axis_reset,
      D => \timer_cntr_reg[12]_i_1_n_6\,
      Q => timer_cntr_reg(13)
    );
\timer_cntr_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => m_axis_reset,
      D => \timer_cntr_reg[12]_i_1_n_5\,
      Q => timer_cntr_reg(14)
    );
\timer_cntr_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => m_axis_reset,
      D => \timer_cntr_reg[12]_i_1_n_4\,
      Q => timer_cntr_reg(15)
    );
\timer_cntr_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => m_axis_reset,
      D => \timer_cntr_reg[0]_i_1_n_6\,
      Q => timer_cntr_reg(1)
    );
\timer_cntr_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => m_axis_reset,
      D => \timer_cntr_reg[0]_i_1_n_5\,
      Q => timer_cntr_reg(2)
    );
\timer_cntr_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => m_axis_reset,
      D => \timer_cntr_reg[0]_i_1_n_4\,
      Q => timer_cntr_reg(3)
    );
\timer_cntr_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => m_axis_reset,
      D => \timer_cntr_reg[4]_i_1_n_7\,
      Q => timer_cntr_reg(4)
    );
\timer_cntr_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timer_cntr_reg[0]_i_1_n_0\,
      CO(3) => \timer_cntr_reg[4]_i_1_n_0\,
      CO(2) => \timer_cntr_reg[4]_i_1_n_1\,
      CO(1) => \timer_cntr_reg[4]_i_1_n_2\,
      CO(0) => \timer_cntr_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \timer_cntr[4]_i_2_n_0\,
      DI(2) => \timer_cntr[4]_i_2_n_0\,
      DI(1) => \timer_cntr[4]_i_2_n_0\,
      DI(0) => timer_cntr_reg(4),
      O(3) => \timer_cntr_reg[4]_i_1_n_4\,
      O(2) => \timer_cntr_reg[4]_i_1_n_5\,
      O(1) => \timer_cntr_reg[4]_i_1_n_6\,
      O(0) => \timer_cntr_reg[4]_i_1_n_7\,
      S(3) => \timer_cntr[4]_i_3_n_0\,
      S(2) => \timer_cntr[4]_i_4_n_0\,
      S(1) => \timer_cntr[4]_i_5_n_0\,
      S(0) => \timer_cntr[4]_i_6_n_0\
    );
\timer_cntr_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => m_axis_reset,
      D => \timer_cntr_reg[4]_i_1_n_6\,
      Q => timer_cntr_reg(5)
    );
\timer_cntr_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => m_axis_reset,
      D => \timer_cntr_reg[4]_i_1_n_5\,
      Q => timer_cntr_reg(6)
    );
\timer_cntr_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => m_axis_reset,
      D => \timer_cntr_reg[4]_i_1_n_4\,
      Q => timer_cntr_reg(7)
    );
\timer_cntr_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => m_axis_reset,
      D => \timer_cntr_reg[8]_i_1_n_7\,
      Q => timer_cntr_reg(8)
    );
\timer_cntr_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timer_cntr_reg[4]_i_1_n_0\,
      CO(3) => \timer_cntr_reg[8]_i_1_n_0\,
      CO(2) => \timer_cntr_reg[8]_i_1_n_1\,
      CO(1) => \timer_cntr_reg[8]_i_1_n_2\,
      CO(0) => \timer_cntr_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 2) => timer_cntr_reg(11 downto 10),
      DI(1) => \timer_cntr[4]_i_2_n_0\,
      DI(0) => \timer_cntr[4]_i_2_n_0\,
      O(3) => \timer_cntr_reg[8]_i_1_n_4\,
      O(2) => \timer_cntr_reg[8]_i_1_n_5\,
      O(1) => \timer_cntr_reg[8]_i_1_n_6\,
      O(0) => \timer_cntr_reg[8]_i_1_n_7\,
      S(3) => \timer_cntr[8]_i_2_n_0\,
      S(2) => \timer_cntr[8]_i_3_n_0\,
      S(1) => \timer_cntr[8]_i_4_n_0\,
      S(0) => \timer_cntr[8]_i_5_n_0\
    );
\timer_cntr_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => m_axis_reset,
      D => \timer_cntr_reg[8]_i_1_n_6\,
      Q => timer_cntr_reg(9)
    );
valid_data_wren_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF3FFFC00000200"
    )
        port map (
      I0 => drdy_i,
      I1 => \^fsm_sequential_state_reg[0]_0\(0),
      I2 => state(2),
      I3 => state(1),
      I4 => state(3),
      I5 => \^valid_data_wren_reg_0\,
      O => valid_data_wren_i_1_n_0
    );
valid_data_wren_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => m_axis_reset,
      D => valid_data_wren_i_1_n_0,
      Q => \^valid_data_wren_reg_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity xadc_wiz_0_xadc_wiz_0_xadc_core_drp is
  port (
    m_axis_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_tid : out STD_LOGIC_VECTOR ( 4 downto 0 );
    busy_out : out STD_LOGIC;
    eoc_out : out STD_LOGIC;
    eos_out : out STD_LOGIC;
    ot_out : out STD_LOGIC;
    channel_out : out STD_LOGIC_VECTOR ( 4 downto 0 );
    alarm_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    temp_out : out STD_LOGIC_VECTOR ( 11 downto 0 );
    do_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    drdy_out : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    s_axis_aclk : in STD_LOGIC;
    m_axis_aclk : in STD_LOGIC;
    vn_in : in STD_LOGIC;
    vp_in : in STD_LOGIC;
    VAUXN : in STD_LOGIC_VECTOR ( 2 downto 0 );
    VAUXP : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axis_resetn : in STD_LOGIC;
    daddr_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    den_in : in STD_LOGIC;
    dwe_in : in STD_LOGIC;
    di_in : in STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of xadc_wiz_0_xadc_wiz_0_xadc_core_drp : entity is "xadc_wiz_0_xadc_core_drp";
end xadc_wiz_0_xadc_wiz_0_xadc_core_drp;

architecture STRUCTURE of xadc_wiz_0_xadc_wiz_0_xadc_core_drp is
  signal Inst_drp_arbiter_n_24 : STD_LOGIC;
  signal Inst_drp_arbiter_n_25 : STD_LOGIC;
  signal Inst_drp_arbiter_n_3 : STD_LOGIC;
  signal Inst_drp_arbiter_n_7 : STD_LOGIC;
  signal axi4_stream_inst_n_29 : STD_LOGIC;
  signal axi4_stream_inst_n_31 : STD_LOGIC;
  signal axi4_stream_inst_n_32 : STD_LOGIC;
  signal axi4_stream_inst_n_35 : STD_LOGIC;
  signal axi4_stream_inst_n_36 : STD_LOGIC;
  signal bbusy_A : STD_LOGIC;
  signal \^channel_out\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal daddr_A : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal daddr_C : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal den_A : STD_LOGIC;
  signal den_C : STD_LOGIC;
  signal den_reg : STD_LOGIC;
  signal di_C : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal do_C : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal do_i : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal drdy_C : STD_LOGIC;
  signal drdy_i : STD_LOGIC;
  signal dwe_C : STD_LOGIC;
  signal \^eoc_out\ : STD_LOGIC;
  signal jtaglocked_i : STD_LOGIC;
  signal m_axis_reset : STD_LOGIC;
  signal mode_change : STD_LOGIC;
  signal mode_change_i_2_n_0 : STD_LOGIC;
  signal overlap_A : STD_LOGIC;
  signal state : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \state__0\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal wren_fifo : STD_LOGIC;
  signal NLW_XADC_INST_JTAGBUSY_UNCONNECTED : STD_LOGIC;
  signal NLW_XADC_INST_JTAGMODIFIED_UNCONNECTED : STD_LOGIC;
  signal NLW_XADC_INST_MUXADDR_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  attribute box_type : string;
  attribute box_type of XADC_INST : label is "PRIMITIVE";
begin
  channel_out(4 downto 0) <= \^channel_out\(4 downto 0);
  eoc_out <= \^eoc_out\;
Inst_drp_arbiter: entity work.xadc_wiz_0_drp_arbiter
     port map (
      DO(15 downto 0) => do_C(15 downto 0),
      \FSM_sequential_state_reg[0]_0\ => Inst_drp_arbiter_n_24,
      \FSM_sequential_state_reg[0]_1\ => axi4_stream_inst_n_35,
      \FSM_sequential_state_reg[3]\ => axi4_stream_inst_n_31,
      \FSM_sequential_state_reg[3]_0\(0) => state(0),
      \FSM_sequential_state_reg[3]_1\ => axi4_stream_inst_n_32,
      Q(15 downto 0) => do_i(15 downto 0),
      bbusy_A => bbusy_A,
      channel_out(0) => \^channel_out\(4),
      \daddr_C_reg_reg[6]_0\(6 downto 0) => daddr_C(6 downto 0),
      \daddr_C_reg_reg[6]_1\(5) => daddr_A(6),
      \daddr_C_reg_reg[6]_1\(4 downto 0) => daddr_A(4 downto 0),
      daddr_in(6 downto 0) => daddr_in(6 downto 0),
      den_A => den_A,
      den_C => den_C,
      den_in => den_in,
      den_reg => den_reg,
      \di_C_reg_reg[15]_0\(15 downto 0) => di_C(15 downto 0),
      di_in(15 downto 0) => di_in(15 downto 0),
      \do_A_reg_reg[14]_0\ => Inst_drp_arbiter_n_7,
      \do_A_reg_reg[15]_0\ => Inst_drp_arbiter_n_25,
      do_out(15 downto 0) => do_out(15 downto 0),
      drdy_C => drdy_C,
      drdy_i => drdy_i,
      drdy_out => drdy_out,
      dwe_C => dwe_C,
      dwe_in => dwe_in,
      eoc_out => \^eoc_out\,
      jtaglocked_i => jtaglocked_i,
      m_axis_aclk => m_axis_aclk,
      m_axis_reset => m_axis_reset,
      m_axis_resetn => m_axis_resetn,
      \m_axis_tdata[15]\ => axi4_stream_inst_n_29,
      mode_change => mode_change,
      overlap_A => overlap_A,
      overlap_B_reg_0 => Inst_drp_arbiter_n_3,
      \state__0\(1 downto 0) => \state__0\(1 downto 0),
      wren_fifo => wren_fifo
    );
XADC_INST: unisim.vcomponents.XADC
    generic map(
      INIT_40 => X"0000",
      INIT_41 => X"20A0",
      INIT_42 => X"0400",
      INIT_43 => X"0000",
      INIT_44 => X"0000",
      INIT_45 => X"0000",
      INIT_46 => X"0000",
      INIT_47 => X"0000",
      INIT_48 => X"4700",
      INIT_49 => X"0103",
      INIT_4A => X"4700",
      INIT_4B => X"0103",
      INIT_4C => X"0000",
      INIT_4D => X"0000",
      INIT_4E => X"0000",
      INIT_4F => X"0000",
      INIT_50 => X"B5ED",
      INIT_51 => X"57E4",
      INIT_52 => X"A147",
      INIT_53 => X"CA33",
      INIT_54 => X"A93A",
      INIT_55 => X"52C6",
      INIT_56 => X"9555",
      INIT_57 => X"AE4E",
      INIT_58 => X"5999",
      INIT_59 => X"0000",
      INIT_5A => X"0000",
      INIT_5B => X"0000",
      INIT_5C => X"5111",
      INIT_5D => X"0000",
      INIT_5E => X"0000",
      INIT_5F => X"0000",
      IS_CONVSTCLK_INVERTED => '0',
      IS_DCLK_INVERTED => '0',
      SIM_DEVICE => "7SERIES",
      SIM_MONITOR_FILE => "design.txt"
    )
        port map (
      ALM(7 downto 0) => alarm_out(7 downto 0),
      BUSY => busy_out,
      CHANNEL(4 downto 0) => \^channel_out\(4 downto 0),
      CONVST => '0',
      CONVSTCLK => '0',
      DADDR(6 downto 0) => daddr_C(6 downto 0),
      DCLK => m_axis_aclk,
      DEN => den_C,
      DI(15 downto 0) => di_C(15 downto 0),
      DO(15 downto 0) => do_C(15 downto 0),
      DRDY => drdy_C,
      DWE => dwe_C,
      EOC => \^eoc_out\,
      EOS => eos_out,
      JTAGBUSY => NLW_XADC_INST_JTAGBUSY_UNCONNECTED,
      JTAGLOCKED => jtaglocked_i,
      JTAGMODIFIED => NLW_XADC_INST_JTAGMODIFIED_UNCONNECTED,
      MUXADDR(4 downto 0) => NLW_XADC_INST_MUXADDR_UNCONNECTED(4 downto 0),
      OT => ot_out,
      RESET => m_axis_reset,
      VAUXN(15 downto 9) => B"0000000",
      VAUXN(8) => VAUXN(2),
      VAUXN(7 downto 2) => B"000000",
      VAUXN(1 downto 0) => VAUXN(1 downto 0),
      VAUXP(15 downto 9) => B"0000000",
      VAUXP(8) => VAUXP(2),
      VAUXP(7 downto 2) => B"000000",
      VAUXP(1 downto 0) => VAUXP(1 downto 0),
      VN => vn_in,
      VP => vp_in
    );
axi4_stream_inst: entity work.xadc_wiz_0_drp_to_axi4stream
     port map (
      \FSM_sequential_state_reg[0]_0\(0) => state(0),
      \FSM_sequential_state_reg[0]_1\ => Inst_drp_arbiter_n_3,
      \FSM_sequential_state_reg[1]_0\ => axi4_stream_inst_n_32,
      \FSM_sequential_state_reg[1]_1\ => Inst_drp_arbiter_n_25,
      \FSM_sequential_state_reg[2]_0\ => Inst_drp_arbiter_n_24,
      \FSM_sequential_state_reg[3]_0\ => Inst_drp_arbiter_n_7,
      Q(15 downto 0) => do_i(15 downto 0),
      bbusy_A => bbusy_A,
      busy_o_reg_0 => axi4_stream_inst_n_35,
      \channel_id_reg[6]_0\(5) => daddr_A(6),
      \channel_id_reg[6]_0\(4 downto 0) => daddr_A(4 downto 0),
      channel_out(4 downto 0) => \^channel_out\(4 downto 0),
      daddr_in(2 downto 0) => daddr_in(2 downto 0),
      daddr_in_2_sp_1 => axi4_stream_inst_n_36,
      den_A => den_A,
      den_in => den_in,
      den_reg => den_reg,
      drdy_i => drdy_i,
      eoc_out => \^eoc_out\,
      m_axis_aclk => m_axis_aclk,
      m_axis_aclk_0 => axi4_stream_inst_n_31,
      m_axis_reset => m_axis_reset,
      m_axis_tdata(15 downto 0) => m_axis_tdata(15 downto 0),
      m_axis_tid(4 downto 0) => m_axis_tid(4 downto 0),
      m_axis_tready => m_axis_tready,
      m_axis_tvalid => m_axis_tvalid,
      mode_change => mode_change,
      mode_change_reg => mode_change_i_2_n_0,
      overlap_A => overlap_A,
      s_axis_aclk => s_axis_aclk,
      \state__0\(1 downto 0) => \state__0\(1 downto 0),
      temp_out(11 downto 0) => temp_out(11 downto 0),
      valid_data_wren_reg_0 => axi4_stream_inst_n_29,
      wren_fifo => wren_fifo
    );
mode_change_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0002000000000000"
    )
        port map (
      I0 => daddr_in(6),
      I1 => daddr_in(5),
      I2 => daddr_in(3),
      I3 => daddr_in(4),
      I4 => den_in,
      I5 => dwe_in,
      O => mode_change_i_2_n_0
    );
mode_change_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => m_axis_aclk,
      CE => '1',
      CLR => m_axis_reset,
      D => axi4_stream_inst_n_36,
      Q => mode_change
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity xadc_wiz_0_xadc_wiz_0_axi_xadc is
  port (
    daddr_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    den_in : in STD_LOGIC;
    di_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    dwe_in : in STD_LOGIC;
    do_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    drdy_out : out STD_LOGIC;
    s_axis_aclk : in STD_LOGIC;
    m_axis_aclk : in STD_LOGIC;
    m_axis_resetn : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tid : out STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axis_tready : in STD_LOGIC;
    vauxp0 : in STD_LOGIC;
    vauxn0 : in STD_LOGIC;
    vauxp1 : in STD_LOGIC;
    vauxn1 : in STD_LOGIC;
    vauxp8 : in STD_LOGIC;
    vauxn8 : in STD_LOGIC;
    busy_out : out STD_LOGIC;
    channel_out : out STD_LOGIC_VECTOR ( 4 downto 0 );
    eoc_out : out STD_LOGIC;
    eos_out : out STD_LOGIC;
    ot_out : out STD_LOGIC;
    alarm_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    temp_out : out STD_LOGIC_VECTOR ( 11 downto 0 );
    vp_in : in STD_LOGIC;
    vn_in : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of xadc_wiz_0_xadc_wiz_0_axi_xadc : entity is "xadc_wiz_0_axi_xadc";
end xadc_wiz_0_xadc_wiz_0_axi_xadc;

architecture STRUCTURE of xadc_wiz_0_xadc_wiz_0_axi_xadc is
begin
AXI_XADC_CORE_I: entity work.xadc_wiz_0_xadc_wiz_0_xadc_core_drp
     port map (
      VAUXN(2) => vauxn8,
      VAUXN(1) => vauxn1,
      VAUXN(0) => vauxn0,
      VAUXP(2) => vauxp8,
      VAUXP(1) => vauxp1,
      VAUXP(0) => vauxp0,
      alarm_out(7 downto 0) => alarm_out(7 downto 0),
      busy_out => busy_out,
      channel_out(4 downto 0) => channel_out(4 downto 0),
      daddr_in(6 downto 0) => daddr_in(6 downto 0),
      den_in => den_in,
      di_in(15 downto 0) => di_in(15 downto 0),
      do_out(15 downto 0) => do_out(15 downto 0),
      drdy_out => drdy_out,
      dwe_in => dwe_in,
      eoc_out => eoc_out,
      eos_out => eos_out,
      m_axis_aclk => m_axis_aclk,
      m_axis_resetn => m_axis_resetn,
      m_axis_tdata(15 downto 0) => m_axis_tdata(15 downto 0),
      m_axis_tid(4 downto 0) => m_axis_tid(4 downto 0),
      m_axis_tready => m_axis_tready,
      m_axis_tvalid => m_axis_tvalid,
      ot_out => ot_out,
      s_axis_aclk => s_axis_aclk,
      temp_out(11 downto 0) => temp_out(11 downto 0),
      vn_in => vn_in,
      vp_in => vp_in
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity xadc_wiz_0 is
  port (
    daddr_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    den_in : in STD_LOGIC;
    di_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    dwe_in : in STD_LOGIC;
    do_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    drdy_out : out STD_LOGIC;
    s_axis_aclk : in STD_LOGIC;
    m_axis_aclk : in STD_LOGIC;
    m_axis_resetn : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tid : out STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axis_tready : in STD_LOGIC;
    vauxp0 : in STD_LOGIC;
    vauxn0 : in STD_LOGIC;
    vauxp1 : in STD_LOGIC;
    vauxn1 : in STD_LOGIC;
    vauxp8 : in STD_LOGIC;
    vauxn8 : in STD_LOGIC;
    channel_out : out STD_LOGIC_VECTOR ( 4 downto 0 );
    busy_out : out STD_LOGIC;
    eoc_out : out STD_LOGIC;
    eos_out : out STD_LOGIC;
    ot_out : out STD_LOGIC;
    vccaux_alarm_out : out STD_LOGIC;
    vccint_alarm_out : out STD_LOGIC;
    user_temp_alarm_out : out STD_LOGIC;
    vbram_alarm_out : out STD_LOGIC;
    alarm_out : out STD_LOGIC;
    temp_out : out STD_LOGIC_VECTOR ( 11 downto 0 );
    vp_in : in STD_LOGIC;
    vn_in : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of xadc_wiz_0 : entity is true;
end xadc_wiz_0;

architecture STRUCTURE of xadc_wiz_0 is
  signal NLW_inst_alarm_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 4 );
begin
inst: entity work.xadc_wiz_0_xadc_wiz_0_axi_xadc
     port map (
      alarm_out(7) => alarm_out,
      alarm_out(6 downto 4) => NLW_inst_alarm_out_UNCONNECTED(6 downto 4),
      alarm_out(3) => vbram_alarm_out,
      alarm_out(2) => vccaux_alarm_out,
      alarm_out(1) => vccint_alarm_out,
      alarm_out(0) => user_temp_alarm_out,
      busy_out => busy_out,
      channel_out(4 downto 0) => channel_out(4 downto 0),
      daddr_in(6 downto 0) => daddr_in(6 downto 0),
      den_in => den_in,
      di_in(15 downto 0) => di_in(15 downto 0),
      do_out(15 downto 0) => do_out(15 downto 0),
      drdy_out => drdy_out,
      dwe_in => dwe_in,
      eoc_out => eoc_out,
      eos_out => eos_out,
      m_axis_aclk => m_axis_aclk,
      m_axis_resetn => m_axis_resetn,
      m_axis_tdata(15 downto 0) => m_axis_tdata(15 downto 0),
      m_axis_tid(4 downto 0) => m_axis_tid(4 downto 0),
      m_axis_tready => m_axis_tready,
      m_axis_tvalid => m_axis_tvalid,
      ot_out => ot_out,
      s_axis_aclk => s_axis_aclk,
      temp_out(11 downto 0) => temp_out(11 downto 0),
      vauxn0 => vauxn0,
      vauxn1 => vauxn1,
      vauxn8 => vauxn8,
      vauxp0 => vauxp0,
      vauxp1 => vauxp1,
      vauxp8 => vauxp8,
      vn_in => vn_in,
      vp_in => vp_in
    );
end STRUCTURE;
