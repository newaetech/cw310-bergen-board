-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
-- Date        : Wed Nov  3 19:03:41 2021
-- Host        : red running 64-bit Ubuntu 18.04.6 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/jpnewae/git/bergen/cw310-bergen-board/fpga/board_test/board_test.srcs/sources_1/ip/ila_simple_ddr3/ila_simple_ddr3_stub.vhdl
-- Design      : ila_simple_ddr3
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k160tfbg676-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ila_simple_ddr3 is
  Port ( 
    clk : in STD_LOGIC;
    probe0 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe2 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe3 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe4 : in STD_LOGIC_VECTOR ( 29 downto 0 );
    probe5 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    probe6 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe7 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe8 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe9 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe10 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe11 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe12 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe13 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe14 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe15 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe16 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    probe17 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe18 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    probe19 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe20 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe21 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe22 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe23 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe24 : in STD_LOGIC_VECTOR ( 29 downto 0 );
    probe25 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe26 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe27 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );

end ila_simple_ddr3;

architecture stub of ila_simple_ddr3 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe0[0:0],probe1[0:0],probe2[0:0],probe3[0:0],probe4[29:0],probe5[2:0],probe6[0:0],probe7[31:0],probe8[0:0],probe9[0:0],probe10[0:0],probe11[31:0],probe12[0:0],probe13[0:0],probe14[0:0],probe15[0:0],probe16[3:0],probe17[0:0],probe18[15:0],probe19[0:0],probe20[0:0],probe21[0:0],probe22[0:0],probe23[31:0],probe24[29:0],probe25[31:0],probe26[0:0],probe27[0:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "ila,Vivado 2020.2";
begin
end;
