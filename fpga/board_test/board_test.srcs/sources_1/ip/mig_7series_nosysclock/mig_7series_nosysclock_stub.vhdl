-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
-- Date        : Tue Nov  2 13:46:19 2021
-- Host        : red running 64-bit Ubuntu 18.04.6 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/jpnewae/git/bergen/cw310-bergen-board/fpga/board_test/board_test.srcs/sources_1/ip/mig_7series_nosysclock/mig_7series_nosysclock_stub.vhdl
-- Design      : mig_7series_nosysclock
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k160tfbg676-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mig_7series_nosysclock is
  Port ( 
    ddr3_dq : inout STD_LOGIC_VECTOR ( 7 downto 0 );
    ddr3_dqs_n : inout STD_LOGIC_VECTOR ( 0 to 0 );
    ddr3_dqs_p : inout STD_LOGIC_VECTOR ( 0 to 0 );
    ddr3_addr : out STD_LOGIC_VECTOR ( 15 downto 0 );
    ddr3_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
    ddr3_ras_n : out STD_LOGIC;
    ddr3_cas_n : out STD_LOGIC;
    ddr3_we_n : out STD_LOGIC;
    ddr3_reset_n : out STD_LOGIC;
    ddr3_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr3_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr3_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr3_cs_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr3_dm : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr3_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    sys_clk_p : in STD_LOGIC;
    sys_clk_n : in STD_LOGIC;
    app_addr : in STD_LOGIC_VECTOR ( 29 downto 0 );
    app_cmd : in STD_LOGIC_VECTOR ( 2 downto 0 );
    app_en : in STD_LOGIC;
    app_wdf_data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    app_wdf_end : in STD_LOGIC;
    app_wdf_mask : in STD_LOGIC_VECTOR ( 3 downto 0 );
    app_wdf_wren : in STD_LOGIC;
    app_rd_data : out STD_LOGIC_VECTOR ( 31 downto 0 );
    app_rd_data_end : out STD_LOGIC;
    app_rd_data_valid : out STD_LOGIC;
    app_rdy : out STD_LOGIC;
    app_wdf_rdy : out STD_LOGIC;
    app_sr_req : in STD_LOGIC;
    app_ref_req : in STD_LOGIC;
    app_zq_req : in STD_LOGIC;
    app_sr_active : out STD_LOGIC;
    app_ref_ack : out STD_LOGIC;
    app_zq_ack : out STD_LOGIC;
    ui_clk : out STD_LOGIC;
    ui_clk_sync_rst : out STD_LOGIC;
    ddr3_ila_wrpath : out STD_LOGIC_VECTOR ( 390 downto 0 );
    ddr3_ila_rdpath : out STD_LOGIC_VECTOR ( 1023 downto 0 );
    ddr3_ila_basic : out STD_LOGIC_VECTOR ( 119 downto 0 );
    ddr3_vio_sync_out : in STD_LOGIC_VECTOR ( 13 downto 0 );
    dbg_byte_sel : in STD_LOGIC_VECTOR ( 1 downto 0 );
    dbg_sel_pi_incdec : in STD_LOGIC;
    dbg_pi_f_inc : in STD_LOGIC;
    dbg_pi_f_dec : in STD_LOGIC;
    dbg_sel_po_incdec : in STD_LOGIC;
    dbg_po_f_inc : in STD_LOGIC;
    dbg_po_f_dec : in STD_LOGIC;
    dbg_po_f_stg23_sel : in STD_LOGIC;
    dbg_pi_counter_read_val : out STD_LOGIC_VECTOR ( 5 downto 0 );
    dbg_po_counter_read_val : out STD_LOGIC_VECTOR ( 8 downto 0 );
    dbg_prbs_final_dqs_tap_cnt_r : out STD_LOGIC_VECTOR ( 107 downto 0 );
    dbg_prbs_first_edge_taps : out STD_LOGIC_VECTOR ( 107 downto 0 );
    dbg_prbs_second_edge_taps : out STD_LOGIC_VECTOR ( 107 downto 0 );
    init_calib_complete : out STD_LOGIC;
    device_temp_i : in STD_LOGIC_VECTOR ( 11 downto 0 );
    device_temp : out STD_LOGIC_VECTOR ( 11 downto 0 );
    sys_rst : in STD_LOGIC
  );

end mig_7series_nosysclock;

architecture stub of mig_7series_nosysclock is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "ddr3_dq[7:0],ddr3_dqs_n[0:0],ddr3_dqs_p[0:0],ddr3_addr[15:0],ddr3_ba[2:0],ddr3_ras_n,ddr3_cas_n,ddr3_we_n,ddr3_reset_n,ddr3_ck_p[0:0],ddr3_ck_n[0:0],ddr3_cke[0:0],ddr3_cs_n[0:0],ddr3_dm[0:0],ddr3_odt[0:0],sys_clk_p,sys_clk_n,app_addr[29:0],app_cmd[2:0],app_en,app_wdf_data[31:0],app_wdf_end,app_wdf_mask[3:0],app_wdf_wren,app_rd_data[31:0],app_rd_data_end,app_rd_data_valid,app_rdy,app_wdf_rdy,app_sr_req,app_ref_req,app_zq_req,app_sr_active,app_ref_ack,app_zq_ack,ui_clk,ui_clk_sync_rst,ddr3_ila_wrpath[390:0],ddr3_ila_rdpath[1023:0],ddr3_ila_basic[119:0],ddr3_vio_sync_out[13:0],dbg_byte_sel[1:0],dbg_sel_pi_incdec,dbg_pi_f_inc,dbg_pi_f_dec,dbg_sel_po_incdec,dbg_po_f_inc,dbg_po_f_dec,dbg_po_f_stg23_sel,dbg_pi_counter_read_val[5:0],dbg_po_counter_read_val[8:0],dbg_prbs_final_dqs_tap_cnt_r[107:0],dbg_prbs_first_edge_taps[107:0],dbg_prbs_second_edge_taps[107:0],init_calib_complete,device_temp_i[11:0],device_temp[11:0],sys_rst";
begin
end;
