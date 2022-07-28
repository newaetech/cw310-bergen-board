//*****************************************************************************
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
//
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor             : Xilinx
// \   \   \/     Version            : 4.2
//  \   \         Application        : MIG
//  /   /         Filename           : example_top.v
// /___/   /\     Date Last Modified : $Date: 2011/06/02 08:35:03 $
// \   \  /  \    Date Created       : Tue Sept 21 2010
//  \___\/\___\
//
// Device           : 7 Series
// Design Name      : DDR3 SDRAM
// Purpose          :
//   Top-level  module. This module serves as an example,
//   and allows the user to synthesize a self-contained design,
//   which they can be used to test their hardware.
//   In addition to the memory controller, the module instantiates:
//     1. Synthesizable testbench - used to model user's backend logic
//        and generate different traffic patterns
// Reference        :
// Revision History :
//*****************************************************************************

//`define SKIP_CALIB
`timescale 1ps/1ps

module example_top #
  (

   //***************************************************************************
   // Traffic Gen related parameters
   //***************************************************************************
   parameter PORT_MODE             = "BI_MODE",
   parameter DATA_MODE             = 4'b0010,
   parameter TST_MEM_INSTR_MODE    = "R_W_INSTR_MODE",
   parameter EYE_TEST              = "FALSE",
                                     // set EYE_TEST = "TRUE" to probe memory
                                     // signals. Traffic Generator will only
                                     // write to one single location and no
                                     // read transactions will be generated.
   parameter DATA_PATTERN          = "DGEN_ALL",
                                      // For small devices, choose one only.
                                      // For large device, choose "DGEN_ALL"
                                      // "DGEN_HAMMER", "DGEN_WALKING1",
                                      // "DGEN_WALKING0","DGEN_ADDR","
                                      // "DGEN_NEIGHBOR","DGEN_PRBS","DGEN_ALL"
   parameter CMD_PATTERN           = "CGEN_ALL",
                                      // "CGEN_PRBS","CGEN_FIXED","CGEN_BRAM",
                                      // "CGEN_SEQUENTIAL", "CGEN_ALL"
   parameter CMD_WDT               = 'h3FF,
   parameter WR_WDT                = 'h1FFF,
   parameter RD_WDT                = 'h3FF,
   parameter SEL_VICTIM_LINE       = 0,
   parameter BEGIN_ADDRESS         = 32'h00000000,
   parameter END_ADDRESS           = 32'h00ffffff,
   parameter PRBS_EADDR_MASK_POS   = 32'hff000000,

   //***************************************************************************
   // The following parameters refer to width of various ports
   //***************************************************************************
   parameter CK_WIDTH              = 1,
                                     // # of CK/CK# outputs to memory.
   parameter nCS_PER_RANK          = 1,
                                     // # of unique CS outputs per rank for phy
   parameter CKE_WIDTH             = 1,
                                     // # of CKE outputs to memory.
   parameter DM_WIDTH              = 1,
                                     // # of DM (data mask)
   parameter ODT_WIDTH             = 1,
                                     // # of ODT outputs to memory.
   parameter BANK_WIDTH            = 3,
                                     // # of memory Bank Address bits.
   parameter COL_WIDTH             = 10,
                                     // # of memory Column Address bits.
   parameter CS_WIDTH              = 1,
                                     // # of unique CS outputs to memory.
   parameter DQ_WIDTH              = 8,
                                     // # of DQ (data)
   parameter DQS_WIDTH             = 1,
   parameter DQS_CNT_WIDTH         = 1,
                                     // = ceil(log2(DQS_WIDTH))
   parameter DRAM_WIDTH            = 8,
                                     // # of DQ per DQS
   parameter ECC                   = "OFF",
   parameter ECC_TEST              = "OFF",
   //parameter nBANK_MACHS           = 4,
   parameter nBANK_MACHS           = 3,
   parameter RANKS                 = 1,
                                     // # of Ranks.
   parameter ROW_WIDTH             = 16,
                                     // # of memory Row Address bits.
   parameter ADDR_WIDTH            = 30,
                                     // # = RANK_WIDTH + BANK_WIDTH
                                     //     + ROW_WIDTH + COL_WIDTH;
                                     // Chip Select is always tied to low for
                                     // single rank devices

   //***************************************************************************
   // The following parameters are mode register settings
   //***************************************************************************
   parameter BURST_MODE            = "8",
                                     // DDR3 SDRAM:
                                     // Burst Length (Mode Register 0).
                                     // # = "8", "4", "OTF".
                                     // DDR2 SDRAM:
                                     // Burst Length (Mode Register).
                                     // # = "8", "4".

   
   //***************************************************************************
   // The following parameters are multiplier and divisor factors for PLLE2.
   // Based on the selected design frequency these parameters vary.
   //***************************************************************************
   parameter CLKIN_PERIOD          = 4230,
                                     // Input Clock Period
   parameter CLKFBOUT_MULT         = 11,
                                     // write PLL VCO multiplier
   parameter DIVCLK_DIVIDE         = 2,
                                     // write PLL VCO divisor
   parameter CLKOUT0_PHASE         = 315.0,
                                     // Phase for PLL output clock (CLKOUT0)
   parameter CLKOUT0_DIVIDE        = 2,
                                     // VCO output divisor for PLL output clock (CLKOUT0)
   parameter CLKOUT1_DIVIDE        = 4,
                                     // VCO output divisor for PLL output clock (CLKOUT1)
   parameter CLKOUT2_DIVIDE        = 64,
                                     // VCO output divisor for PLL output clock (CLKOUT2)
   parameter CLKOUT3_DIVIDE        = 8,
                                     // VCO output divisor for PLL output clock (CLKOUT3)
   parameter MMCM_VCO              = 650,
                                     // Max Freq (MHz) of MMCM VCO
   parameter MMCM_MULT_F           = 4,
                                     // write MMCM VCO multiplier
   parameter MMCM_DIVCLK_DIVIDE    = 1,
                                     // write MMCM VCO divisor

   //***************************************************************************
   // Simulation parameters
   //***************************************************************************
   parameter SIMULATION            = "FALSE",
                                     // Should be TRUE during design simulations and
                                     // FALSE during implementations

   //***************************************************************************
   // IODELAY and PHY related parameters
   //***************************************************************************
   parameter TCQ                   = 100,
   
   parameter DRAM_TYPE             = "DDR3",

   
   //***************************************************************************
   // System clock frequency parameters
   //***************************************************************************
   parameter nCK_PER_CLK           = 2,
                                     // # of memory CKs per fabric CLK

   

   //***************************************************************************
   // Debug parameters
   //***************************************************************************
   parameter DEBUG_PORT            = "ON",
                                     // # = "ON" Enable debug signals/controls.
                                     //   = "OFF" Disable debug signals/controls.
      
   parameter RST_ACT_LOW           = 1
                                     // =1 for active low reset,
                                     // =0 for active high.
   )
  (

   // Inouts
   inout [7:0]                         ddr3_dq,
   inout [0:0]                        ddr3_dqs_n,
   inout [0:0]                        ddr3_dqs_p,

   // Outputs
   output [15:0]                       ddr3_addr,
   output [2:0]                      ddr3_ba,
   output                                       ddr3_ras_n,
   output                                       ddr3_cas_n,
   output                                       ddr3_we_n,
   output                                       ddr3_reset_n,
   output [0:0]                        ddr3_ck_p,
   output [0:0]                        ddr3_ck_n,
   output [0:0]                       ddr3_cke,
   
   output [0:0]           ddr3_cs_n,
   
   output [0:0]                        ddr3_dm,
   
   output [0:0]                       ddr3_odt,
   

   // Inputs
   
   // Differential system clocks
   input                                        sys_clk_p,
   input                                        sys_clk_n,
   

   output                                       tg_compare_error,
   output                                       init_calib_complete,
   input  [11:0]                                device_temp_i,
                      // The 12 MSB bits of the temperature sensor transfer
                      // function need to be connected to this port. This port
                      // will be synchronized w.r.t. to fabric clock internally.
      

   // System reset - Default polarity of sys_rst pin is Active Low.
   // System reset polarity will change based on the option 
   // selected in GUI.
   input                                        sys_rst
   );

function integer clogb2 (input integer size);
    begin
      size = size - 1;
      for (clogb2=1; size>1; clogb2=clogb2+1)
        size = size >> 1;
    end
  endfunction // clogb2

  function integer STR_TO_INT;
    input [7:0] in;
    begin
      if(in == "8")
        STR_TO_INT = 8;
      else if(in == "4")
        STR_TO_INT = 4;
      else
        STR_TO_INT = 0;
    end
  endfunction


  localparam DATA_WIDTH            = 8;
  localparam RANK_WIDTH = clogb2(RANKS);
  localparam PAYLOAD_WIDTH         = (ECC_TEST == "OFF") ? DATA_WIDTH : DQ_WIDTH;
  localparam BURST_LENGTH          = STR_TO_INT(BURST_MODE);
  localparam APP_DATA_WIDTH        = 2 * nCK_PER_CLK * PAYLOAD_WIDTH;
  localparam APP_MASK_WIDTH        = APP_DATA_WIDTH / 8;

  //***************************************************************************
  // Traffic Gen related parameters (derived)
  //***************************************************************************
  localparam  TG_ADDR_WIDTH = ((CS_WIDTH == 1) ? 0 : RANK_WIDTH)
                                 + BANK_WIDTH + ROW_WIDTH + COL_WIDTH;
  localparam MASK_SIZE             = DATA_WIDTH/8;
      

  // Wire declarations
      
  wire [(2*nCK_PER_CLK)-1:0]              app_ecc_multiple_err;
  wire [(2*nCK_PER_CLK)-1:0]              app_ecc_single_err;
  wire [ADDR_WIDTH-1:0]                 app_addr;
  wire [2:0]                            app_cmd;
  wire                                  app_en;
  wire                                  app_rdy;
  wire [APP_DATA_WIDTH-1:0]             app_rd_data;
  wire                                  app_rd_data_end;
  wire                                  app_rd_data_valid;
  wire [APP_DATA_WIDTH-1:0]             app_wdf_data;
  wire                                  app_wdf_end;
  wire [APP_MASK_WIDTH-1:0]             app_wdf_mask;
  wire                                  app_wdf_rdy;
  wire                                  app_sr_active;
  wire                                  app_ref_ack;
  wire                                  app_zq_ack;
  wire                                  app_wdf_wren;
  wire [(64+(2*APP_DATA_WIDTH))-1:0]      error_status;
  wire [(PAYLOAD_WIDTH/8)-1:0] cumlative_dq_lane_error;
  wire                                  mem_pattern_init_done;
  wire [47:0]                           tg_wr_data_counts;
  wire [47:0]                           tg_rd_data_counts;
  wire                                  modify_enable_sel;
  wire [2:0]                            data_mode_manual_sel;
  wire [2:0]                            addr_mode_manual_sel;
  wire [APP_DATA_WIDTH-1:0]             cmp_data;
  reg [63:0]                            cmp_data_r;
  wire                                  cmp_data_valid;
  reg                                   cmp_data_valid_r;
  wire                                  cmp_error;
  wire [(PAYLOAD_WIDTH/8)-1:0]            dq_error_bytelane_cmp;

  wire                                  clk;
  wire                                  rst;

  wire                                  dbg_sel_pi_incdec;
  wire                                  dbg_pi_f_inc;
  wire                                  dbg_pi_f_dec;
  wire                                  dbg_sel_po_incdec;
  wire                                  dbg_po_f_inc;
  wire                                  dbg_po_f_stg23_sel;
  wire                                  dbg_po_f_dec;
  
    // Debug port wire declarations

  wire [255:0]                            ddr3_ila_basic_w;
  reg  [255:0]                            ddr3_ila_basic;
  wire [390:0]                            ddr3_ila_wrpath_w;
  reg  [390:0]                            ddr3_ila_wrpath;
  wire [1023:0]                           ddr3_ila_rdpath_w;
  reg  [1023:0]                           ddr3_ila_rdpath;

  // Signals for creating rising edge pulses for VIO outputs
  reg                                     vio_dbg_pi_f_inc_r1;
  reg                                     vio_dbg_pi_f_dec_r1;
  reg                                     vio_dbg_po_f_inc_r1;
  reg                                     vio_dbg_po_f_dec_r1;
  reg                                     vio_win_byte_select_inc_r1;
  reg                                     vio_win_byte_select_dec_r1;

  reg                                     vio_dbg_pi_f_inc_r2;
  reg                                     vio_dbg_pi_f_dec_r2;
  reg                                     vio_dbg_po_f_inc_r2;
  reg                                     vio_dbg_po_f_dec_r2;
  reg                                     vio_win_byte_select_inc_r2;
  reg                                     vio_win_byte_select_dec_r2;

  wire                                    vio_dbg_pi_f_inc_re;
  wire                                    vio_dbg_pi_f_dec_re;
  wire                                    vio_dbg_po_f_inc_re;
  wire                                    vio_dbg_po_f_dec_re;
  wire                                    vio_win_byte_select_inc_re;
  wire                                    vio_win_byte_select_dec_re;

  (* mark_debug = "TRUE" *) wire          dbg_mem_pattern_init_done;
  (* mark_debug = "TRUE" *) wire          dbg_tg_compare_error;
  (* mark_debug = "TRUE" *) wire [47:0]   dbg_tg_wr_data_counts;
  (* mark_debug = "TRUE" *) wire [47:0]   dbg_tg_rd_data_counts;

  (* mark_debug = "TRUE" *) wire [4:0]    dbg_dqs;
  (* mark_debug = "TRUE" *) wire [8:0]    dbg_bit;

  reg  [7:0]                              dbg_extn_trig_out_ack_r;
  (* mark_debug = "TRUE" *) wire          vio_modify_enable;
  (* mark_debug = "TRUE" *) wire [3:0]    vio_data_mode_value;
  (* mark_debug = "TRUE" *) wire          vio_pause_traffic;
  (* mark_debug = "TRUE" *) wire [2:0]    vio_addr_mode_value;
  (* mark_debug = "TRUE" *) wire [3:0]    vio_instr_mode_value;
  (* mark_debug = "TRUE" *) wire [1:0]    vio_bl_mode_value;
  (* mark_debug = "TRUE" *) wire [9:0]    vio_fixed_bl_value;
  (* mark_debug = "TRUE" *) wire [2:0]    vio_fixed_instr_value;
  (* mark_debug = "TRUE" *) wire          vio_data_mask_gen;
  (* mark_debug = "TRUE" *) wire          vio_tg_rst;
  (* mark_debug = "TRUE" *) wire          vio_dbg_sel_pi_incdec;
  (* mark_debug = "TRUE" *) wire          vio_dbg_pi_f_inc;
  (* mark_debug = "TRUE" *) wire          vio_dbg_pi_f_dec;
  (* mark_debug = "TRUE" *) wire          vio_dbg_sel_po_incdec;
  (* mark_debug = "TRUE" *) wire          vio_dbg_po_f_inc;
  (* mark_debug = "TRUE" *) wire          vio_dbg_po_f_stg23_sel;
  (* mark_debug = "TRUE" *) wire          vio_dbg_po_f_dec;
  (* mark_debug = "TRUE" *) wire          dbg_extn_trig_out;
  (* mark_debug = "TRUE" *) wire          dbg_extn_trig_out_ack;
  (* mark_debug = "TRUE" *) wire          dbg_init_calib_complete;
  (* mark_debug = "TRUE" *) wire          dbg_wrlvl_start;
  (* mark_debug = "TRUE" *) wire          dbg_wrlvl_done;
  (* mark_debug = "TRUE" *) wire          dbg_wrlvl_err;
  (* mark_debug = "TRUE" *) wire          dbg_pi_phaselock_start;
  (* mark_debug = "TRUE" *) wire          dbg_pi_phaselocked_done;
  (* mark_debug = "TRUE" *) wire          dbg_pi_phaselock_err;
  (* mark_debug = "TRUE" *) wire          dbg_pi_dqsfound_start;
  (* mark_debug = "TRUE" *) wire          dbg_pi_dqsfound_done;
  (* mark_debug = "TRUE" *) wire          dbg_pi_dqsfound_err;
  (* mark_debug = "TRUE" *) wire [1:0]    dbg_rdlvl_start;
  (* mark_debug = "TRUE" *) wire [1:0]    dbg_rdlvl_done;
  (* mark_debug = "TRUE" *) wire [1:0]    dbg_rdlvl_err;
  (* mark_debug = "TRUE" *) wire          dbg_oclkdelay_calib_start;
  (* mark_debug = "TRUE" *) wire          dbg_oclkdelay_calib_done;
  (* mark_debug = "TRUE" *) wire          dbg_wrcal_start;
  (* mark_debug = "TRUE" *) wire          dbg_wrcal_done;
  (* mark_debug = "TRUE" *) wire          dbg_wrcal_err;
  (* mark_debug = "TRUE" *) wire [5:0]    dbg_phy_init_5_0;
  (* mark_debug = "TRUE" *) wire          dbg_rddata_valid_r;
  (* mark_debug = "TRUE" *) wire [63:0]   dbg_rddata_r;
  (* mark_debug = "TRUE" *) wire          dbg_fine_adjust_done_r;
  (* mark_debug = "TRUE" *) wire          dbg_cmd_wdt_err_w;
  (* mark_debug = "TRUE" *) wire          dbg_rd_wdt_err_w;
  (* mark_debug = "TRUE" *) wire          dbg_wr_wdt_err_w;
  (* mark_debug = "TRUE" *) wire          dbg_cmp_data_valid;
  (* mark_debug = "TRUE" *) wire          dbg_cmp_error;
  (* mark_debug = "TRUE" *) wire [63:0]   dbg_cmp_data_r;
  (* mark_debug = "TRUE" *) wire [7:0]    dbg_dq_error_bytelane_cmp;
  (* mark_debug = "TRUE" *) wire [7:0]    dbg_cumlative_dq_lane_error;
  (* mark_debug = "TRUE" *) wire [31:0]   dbg_cmp_addr_i;
  (* mark_debug = "TRUE" *) wire [5:0]    dbg_cmp_bl_i;
  (* mark_debug = "TRUE" *) wire          dbg_mcb_cmd_full_i;
  (* mark_debug = "TRUE" *) wire          dbg_mcb_wr_full_i;
  (* mark_debug = "TRUE" *) wire          dbg_mcb_rd_empty_i;
  (* mark_debug = "TRUE" *) wire [1:0]    dbg_ddrx_ila_rdpath_765_764;
  (* mark_debug = "TRUE" *) wire [31:0]   dbg_axi_cmp_data;
  (* mark_debug = "TRUE" *) wire [31:0]   dbg_axi_rdata_cmp;

  // Write path debug signals
  (* mark_debug = "TRUE" *) wire [4:0]    dbg_wl_state_r;
  (* mark_debug = "TRUE" *) wire [3:0]    dbg_dqs_cnt_r;
  (* mark_debug = "TRUE" *) wire          dbg_wl_edge_detect_valid_r;
  (* mark_debug = "TRUE" *) wire          dbg_rd_data_edge_detect_r_by_dqs;
  (* mark_debug = "TRUE" *) wire [5:0]    dbg_wl_po_fine_cnt_by_dqs;
  (* mark_debug = "TRUE" *) wire [2:0]    dbg_wl_po_coarse_cnt_by_dqs;

  (* mark_debug = "TRUE" *) wire [3:0]    dbg_phy_oclkdelay_zfo;
  (* mark_debug = "TRUE" *) wire [5:0]    dbg_ocal_fuzz2oneeighty;
  (* mark_debug = "TRUE" *) wire [5:0]    dbg_ocal_fuzz2zero;
  (* mark_debug = "TRUE" *) wire [5:0]    dbg_ocal_oneeighty2fuzz;
  (* mark_debug = "TRUE" *) wire [5:0]    dbg_ocal_zero2fuzz;
  (* mark_debug = "TRUE" *) wire [2:0]    dbg_ocal_oclkdelay_calib_cnt;
  (* mark_debug = "TRUE" *) wire          dbg_ocal_scan_win_not_found;
  (* mark_debug = "TRUE" *) wire          dbg_ocal_lim_done;
  (* mark_debug = "TRUE" *) wire [5:0]    dbg_ocal_stg3_lim_left;
  (* mark_debug = "TRUE" *) wire [5:0]    dbg_ocal_stg3_lim_right;
  (* mark_debug = "TRUE" *) wire          dbg_ocal_center_calib_start;
  (* mark_debug = "TRUE" *) wire          dbg_ocal_center_calib_done;
  (* mark_debug = "TRUE" *) wire [53:0]   dbg_phy_oclkdelay_cal_taps;
  (* mark_debug = "TRUE" *) wire [5:0]    dbg_ocal_tap_cnt;

  (* mark_debug = "TRUE" *) wire          dbg_wrcal_pat_data_match_r;
  (* mark_debug = "TRUE" *) wire          dbg_wrcal_pat_data_match_valid_r;
  (* mark_debug = "TRUE" *) wire [3:0]    dbg_wrcal_dqs_cnt_r;
  (* mark_debug = "TRUE" *) wire [4:0]    cal2_state_r;
  (* mark_debug = "TRUE" *) wire [4:0]    not_empty_wait_cnt;
  (* mark_debug = "TRUE" *) wire          dbg_early1_data;
  (* mark_debug = "TRUE" *) wire          dbg_early2_data;
  (* mark_debug = "TRUE" *) wire          dbg_early1_data_match_r;
  (* mark_debug = "TRUE" *) wire          dbg_early2_data_match_r;
  (* mark_debug = "TRUE" *) wire          dbg_wcal_sanity_pat_data_match_valid_r;
  (* mark_debug = "TRUE" *) wire          dbg_wcal_sanity_chk_start;
  (* mark_debug = "TRUE" *) wire          dbg_wcal_sanity_chk_done;
  (* mark_debug = "TRUE" *) wire [7:0]    dbg_wcal_mux_rd_rise0_r;
  (* mark_debug = "TRUE" *) wire [7:0]    dbg_wcal_mux_rd_fall0_r;
  (* mark_debug = "TRUE" *) wire [7:0]    dbg_wcal_mux_rd_rise1_r;
  (* mark_debug = "TRUE" *) wire [7:0]    dbg_wcal_mux_rd_fall1_r;
  (* mark_debug = "TRUE" *) wire [7:0]    dbg_wcal_mux_rd_rise2_r;
  (* mark_debug = "TRUE" *) wire [7:0]    dbg_wcal_mux_rd_fall2_r;
  (* mark_debug = "TRUE" *) wire [7:0]    dbg_wcal_mux_rd_rise3_r;
  (* mark_debug = "TRUE" *) wire [7:0]    dbg_wcal_mux_rd_fall3_r;
  (* mark_debug = "TRUE" *) wire [3:0]    dbg_phy_oclkdelay_cal_57_54;
  (* mark_debug = "TRUE" *) wire [26:0]   dbg_phy_wrcal_po_coarse_cnt;
  (* mark_debug = "TRUE" *) wire [53:0]   dbg_phy_wrcal_po_fine_cnt;
  (* mark_debug = "TRUE" *) wire [53:0]   dbg_phy_wrlvl_128_75;
  (* mark_debug = "TRUE" *) wire [26:0]   dbg_phy_wrlvl_155_129;
  // Read path debug signals

  (* mark_debug = "TRUE" *) wire [11:0]   dbg_pi_phase_locked_phy4lanes;
  (* mark_debug = "TRUE" *) wire [11:0]   dbg_pi_dqs_found_lanes_phy4lanes;
  (* mark_debug = "TRUE" *) wire [11:0]   dbg_rd_data_offset;
  (* mark_debug = "TRUE" *) wire [5:0]    dbg_cal1_state_r;
  (* mark_debug = "TRUE" *) wire [3:0]    dbg_cal1_cnt_cpt_r;
  (* mark_debug = "TRUE" *) wire [7:0]    dbg_mux_rd_rise0_r;
  (* mark_debug = "TRUE" *) wire [7:0]    dbg_mux_rd_fall0_r;
  (* mark_debug = "TRUE" *) wire [7:0]    dbg_mux_rd_rise1_r;
  (* mark_debug = "TRUE" *) wire [7:0]    dbg_mux_rd_fall1_r;
  (* mark_debug = "TRUE" *) wire [7:0]    dbg_mux_rd_rise2_r;
  (* mark_debug = "TRUE" *) wire [7:0]    dbg_mux_rd_fall2_r;
  (* mark_debug = "TRUE" *) wire [7:0]    dbg_mux_rd_rise3_r;
  (* mark_debug = "TRUE" *) wire [7:0]    dbg_mux_rd_fall3_r;
  (* mark_debug = "TRUE" *) wire          dbg_rdlvl_pat_data_match_r;
  (* mark_debug = "TRUE" *) wire          dbg_mux_rd_valid_r;
  (* mark_debug = "TRUE" *) wire [5:0]    dbg_cpt_first_edge_cnt_by_dqs;
  (* mark_debug = "TRUE" *) wire [5:0]    dbg_cpt_second_edge_cnt_by_dqs;
  (* mark_debug = "TRUE" *) wire [5:0]    dbg_cpt_tap_cnt_by_dqs;
  (* mark_debug = "TRUE" *) wire [4:0]    dbg_dq_idelay_tap_cnt_by_dqs;
  (* mark_debug = "TRUE" *) wire [11:0]   dbg_dbg_calib_rd_data_offset_1;
  (* mark_debug = "TRUE" *) wire [11:0]   dbg_dbg_calib_rd_data_offset_2;
  (* mark_debug = "TRUE" *) wire [5:0]    dbg_data_offset;
  (* mark_debug = "TRUE" *) wire [5:0]    dbg_data_offset_1;
  (* mark_debug = "TRUE" *) wire [5:0]    dbg_data_offset_2;
  (* mark_debug = "TRUE" *) wire [107:0]  dbg_cpt_first_edge_cnt;
  (* mark_debug = "TRUE" *) wire [107:0]  dbg_cpt_second_edge_cnt;
  (* mark_debug = "TRUE" *) wire [107:0]  dbg_cpt_tap_cnt;
  (* mark_debug = "TRUE" *) wire [89:0]   dbg_dq_idelay_tap_cnt;

                            wire [254:0]  dbg_prbs_rdlvl;

  (* mark_debug = "TRUE" *) wire [ 47:0]  dbg_prbs_rdlvl_left_edge_pb;
  (* mark_debug = "TRUE" *) wire [ 15:0]  dbg_prbs_rdlvl_left_loss_pb;
  (* mark_debug = "TRUE" *) wire [ 47:0]  dbg_prbs_rdlvl_right_edge_pb;
  (* mark_debug = "TRUE" *) wire [ 15:0]  dbg_prbs_rdlvl_right_gain_pb;
  (* mark_debug = "TRUE" *) wire [  5:0]  dbg_prbs_rdlvl_pi_counter_read_val;
  (* mark_debug = "TRUE" *) wire [  5:0]  dbg_prbs_rdlvl_prbs_dqs_tap_cnt_r;
  (* mark_debug = "TRUE" *) wire          dbg_prbs_rdlvl_prbs_found_1st_edge_r;
  (* mark_debug = "TRUE" *) wire          dbg_prbs_rdlvl_prbs_found_2nd_edge_r;
  (* mark_debug = "TRUE" *) wire          dbg_prbs_rdlvl_compare_err;
  (* mark_debug = "TRUE" *) wire          dbg_prbs_rdlvl_phy_if_empty;
  (* mark_debug = "TRUE" *) wire          dbg_prbs_rdlvl_prbs_rdlvl_start;
  (* mark_debug = "TRUE" *) wire          dbg_prbs_rdlvl_prbs_rdlvl_done;
  (* mark_debug = "TRUE" *) wire [  4:0]  dbg_prbs_rdlvl_prbs_dqs_cnt_r;
  (* mark_debug = "TRUE" *) wire [  5:0]  dbg_prbs_rdlvl_left_edge_pb_dqs_cnt;
  (* mark_debug = "TRUE" *) wire [  5:0]  dbg_prbs_rdlvl_right_edge_pb_dqs_cnt;
  (* mark_debug = "TRUE" *) wire [  2:0]  dbg_prbs_rdlvl_rd_victim_sel;
  (* mark_debug = "TRUE" *) wire          dbg_prbs_rdlvl_complex_victim_inc;
  (* mark_debug = "TRUE" *) wire [  5:0]  dbg_prbs_rdlvl_right_gain_pb_dqs_cnt;
  (* mark_debug = "TRUE" *) wire [  2:0]  dbg_prbs_rdlvl_ref_bit;
  (* mark_debug = "TRUE" *) wire [  5:0]  dbg_prbs_rdlvl_prbs_state_r1;
  (* mark_debug = "TRUE" *) wire          dbg_prbs_rdlvl_rd_valid_r2;
  (* mark_debug = "TRUE" *) wire          dbg_prbs_rdlvl_compare_err_r0;
  (* mark_debug = "TRUE" *) wire          dbg_prbs_rdlvl_compare_err_f0;
  (* mark_debug = "TRUE" *) wire          dbg_prbs_rdlvl_compare_err_r1;
  (* mark_debug = "TRUE" *) wire          dbg_prbs_rdlvl_compare_err_f1;
  (* mark_debug = "TRUE" *) wire          dbg_prbs_rdlvl_compare_err_r2;
  (* mark_debug = "TRUE" *) wire          dbg_prbs_rdlvl_compare_err_f2;
  (* mark_debug = "TRUE" *) wire          dbg_prbs_rdlvl_compare_err_r3;
  (* mark_debug = "TRUE" *) wire          dbg_prbs_rdlvl_compare_err_f3;
  (* mark_debug = "TRUE" *) wire [  7:0]  dbg_prbs_rdlvl_left_edge_found_pb;
  (* mark_debug = "TRUE" *) wire [  7:0]  dbg_prbs_rdlvl_right_edge_found_pb;
  (* mark_debug = "TRUE" *) wire [  5:0]  dbg_prbs_rdlvl_largest_left_edge;
  (* mark_debug = "TRUE" *) wire [  5:0]  dbg_prbs_rdlvl_smallest_right_edge;
  (* mark_debug = "TRUE" *) wire [  7:0]  dbg_prbs_rdlvl_fine_delay_incdec_pb;
  (* mark_debug = "TRUE" *) wire          dbg_prbs_rdlvl_fine_delay_sel;
  (* mark_debug = "TRUE" *) wire [  7:0]  dbg_prbs_rdlvl_compare_err_pb_latch_r;
  (* mark_debug = "TRUE" *) wire [  5:0]  dbg_prbs_rdlvl_fine_pi_dec_cnt;
  (* mark_debug = "TRUE" *) wire [  4:0]  dbg_prbs_rdlvl_match_flag_and;
  (* mark_debug = "TRUE" *) wire [  1:0]  dbg_prbs_rdlvl_stage_cnt;
  (* mark_debug = "TRUE" *) wire          dbg_prbs_rdlvl_fine_inc_stage;
  (* mark_debug = "TRUE" *) wire          dbg_prbs_rdlvl_compare_err_pb_and;
  (* mark_debug = "TRUE" *) wire          dbg_prbs_rdlvl_right_edge_found;
  (* mark_debug = "TRUE" *) wire          dbg_prbs_rdlvl_fine_dly_error;

  (* mark_debug = "TRUE" *) wire          win_start;
  (* mark_debug = "TRUE" *) wire          win_sel_pi_pon;
  (* mark_debug = "TRUE" *) wire          vio_win_byte_select_inc;
  (* mark_debug = "TRUE" *) wire          vio_win_byte_select_dec;
  (* mark_debug = "TRUE" *) wire [5:0]    dbg_pi_counter_read_val;
  (* mark_debug = "TRUE" *) wire [8:0]    dbg_po_counter_read_val;
  (* mark_debug = "TRUE" *) wire [107:0]  dbg_prbs_final_dqs_tap_cnt_r;
  (* mark_debug = "TRUE" *) wire [107:0]  dbg_prbs_first_edge_taps;
  (* mark_debug = "TRUE" *) wire [107:0]  dbg_prbs_second_edge_taps;
  (* mark_debug = "TRUE" *) wire [5:0]    pi_win_left_ram_out;
  (* mark_debug = "TRUE" *) wire [5:0]    pi_win_right_ram_out;
  (* mark_debug = "TRUE" *) wire [8:0]    po_win_left_ram_out;
  (* mark_debug = "TRUE" *) wire [8:0]    po_win_right_ram_out;
  (* mark_debug = "TRUE" *) wire          win_clr_error;
  (* mark_debug = "TRUE" *) wire          manual_clear_error;

  (* mark_debug = "TRUE" *) wire          win_active;
  (* mark_debug = "TRUE" *) wire [4:0]    vio_sel_mux_rdd;
  (* mark_debug = "TRUE" *) wire [6:0]    win_current_bit;
  (* mark_debug = "TRUE" *) wire [4:0]    win_current_byte;
  (* mark_debug = "TRUE" *) wire [164:0]  dbg_win_chk;
  wire                                    pi_win_up;
  wire                                    pi_win_down;
  wire                                    po_win_up;
  wire                                    po_stg23_sel;
  wire                                    po_win_down;
  wire                                    po_win_tg_rst;

  reg                                     app_rd_data_valid_r1;
  reg                                     app_rd_data_valid_r2;
  reg                                     app_rd_data_valid_r3;
  (* mark_debug = "TRUE" *) reg [6:0]     win_byte_select;
  reg [(2*nCK_PER_CLK*PAYLOAD_WIDTH)-1:0]    app_rd_data_r1;
  reg [(2*nCK_PER_CLK*PAYLOAD_WIDTH)-1:0]    app_rd_data_r2;
  reg [(2*nCK_PER_CLK*PAYLOAD_WIDTH)-1:0]    app_rd_data_r3;
  reg [DQS_CNT_WIDTH:0]                       dbg_byte_sel_r;
  reg [255:0]                             tg_simple_data;
  (* mark_debug = "TRUE" *) wire [1:0]    vio_tg_simple_data_sel;
  (* mark_debug = "TRUE" *) wire          wdt_en_w;
  wire                                    cmd_wdt_err_w;
  wire                                    wr_wdt_err_w;
  wire                                    rd_wdt_err_w;
  (* mark_debug = "TRUE" *) wire          dbg_clear_error;
  
  wire [11:0]                           device_temp;
  
`ifdef SKIP_CALIB
  // skip calibration wires
  wire                          calib_tap_req;
  reg                           calib_tap_load;
  reg [6:0]                     calib_tap_addr;
  reg [7:0]                     calib_tap_val;
  reg                           calib_tap_load_done;
`endif
      
  

//***************************************************************************






      
// Start of User Design top instance
//***************************************************************************
// The User design is instantiated below. The memory interface ports are
// connected to the top-level and the application interface ports are
// connected to the traffic generator module. This provides a reference
// for connecting the memory controller to system.
//***************************************************************************

  mig_7series_nosysclock u_mig_7series_nosysclock
      (
       
       
// Memory interface ports
       .ddr3_addr                      (ddr3_addr),
       .ddr3_ba                        (ddr3_ba),
       .ddr3_cas_n                     (ddr3_cas_n),
       .ddr3_ck_n                      (ddr3_ck_n),
       .ddr3_ck_p                      (ddr3_ck_p),
       .ddr3_cke                       (ddr3_cke),
       .ddr3_ras_n                     (ddr3_ras_n),
       .ddr3_we_n                      (ddr3_we_n),
       .ddr3_dq                        (ddr3_dq),
       .ddr3_dqs_n                     (ddr3_dqs_n),
       .ddr3_dqs_p                     (ddr3_dqs_p),
       .ddr3_reset_n                   (ddr3_reset_n),
       .init_calib_complete            (init_calib_complete),
      
       .ddr3_cs_n                      (ddr3_cs_n),
       .ddr3_dm                        (ddr3_dm),
       .ddr3_odt                       (ddr3_odt),
// Application interface ports
       .app_addr                       (app_addr),
       .app_cmd                        (app_cmd),
       .app_en                         (app_en),
       .app_wdf_data                   (app_wdf_data),
       .app_wdf_end                    (app_wdf_end),
       .app_wdf_wren                   (app_wdf_wren),
       .app_rd_data                    (app_rd_data),
       .app_rd_data_end                (app_rd_data_end),
       .app_rd_data_valid              (app_rd_data_valid),
       .app_rdy                        (app_rdy),
       .app_wdf_rdy                    (app_wdf_rdy),
       .app_sr_req                     (1'b0),
       .app_ref_req                    (1'b0),
       .app_zq_req                     (1'b0),
       .app_sr_active                  (app_sr_active),
       .app_ref_ack                    (app_ref_ack),
       .app_zq_ack                     (app_zq_ack),
       .ui_clk                         (clk),
       .ui_clk_sync_rst                (rst),
      
       .app_wdf_mask                   (app_wdf_mask),
      
// Debug Ports
       .ddr3_ila_basic                           (ddr3_ila_basic_w[119:0]),
       .ddr3_ila_wrpath                          (ddr3_ila_wrpath_w),
       .ddr3_ila_rdpath                          (ddr3_ila_rdpath_w),

       .ddr3_vio_sync_out                        ({dbg_dqs,dbg_bit}),

       .dbg_pi_counter_read_val        (dbg_pi_counter_read_val),
       .dbg_sel_pi_incdec              (dbg_sel_pi_incdec),
       .dbg_po_counter_read_val        (dbg_po_counter_read_val),
       .dbg_prbs_final_dqs_tap_cnt_r   (dbg_prbs_final_dqs_tap_cnt_r),
       .dbg_prbs_first_edge_taps       (dbg_prbs_first_edge_taps),
       .dbg_prbs_second_edge_taps      (dbg_prbs_second_edge_taps),
       .dbg_sel_po_incdec              (dbg_sel_po_incdec),
       .dbg_byte_sel                   (dbg_byte_sel_r),
       .dbg_pi_f_inc                   (dbg_pi_f_inc),
       .dbg_pi_f_dec                   (dbg_pi_f_dec),
       .dbg_po_f_inc                   (dbg_po_f_inc),
       .dbg_po_f_stg23_sel             (dbg_po_f_stg23_sel),
       .dbg_po_f_dec                   (dbg_po_f_dec),
       
// System Clock Ports
       .sys_clk_p                       (sys_clk_p),
       .sys_clk_n                       (sys_clk_n),
       .device_temp_i                  (device_temp_i),
       .device_temp            (device_temp),
       `ifdef SKIP_CALIB
       .calib_tap_req                    (calib_tap_req),
       .calib_tap_load                   (calib_tap_load),
       .calib_tap_addr                   (calib_tap_addr),
       .calib_tap_val                    (calib_tap_val),
       .calib_tap_load_done              (calib_tap_load_done),
       `endif
      
       .sys_rst                        (sys_rst)
       );
// End of User Design top instance


//***************************************************************************
// The traffic generation module instantiated below drives traffic (patterns)
// on the application interface of the memory controller
//***************************************************************************

  mig_7series_v4_2_traffic_gen_top #
    (
     .TCQ                 (TCQ),
     .SIMULATION          (SIMULATION),
     .FAMILY              ("VIRTEX7"),
     .MEM_TYPE            (DRAM_TYPE),
     .TST_MEM_INSTR_MODE  (TST_MEM_INSTR_MODE),
     //.BL_WIDTH            (BL_WIDTH),
     .nCK_PER_CLK         (nCK_PER_CLK),
     .NUM_DQ_PINS         (PAYLOAD_WIDTH),
     .MEM_BURST_LEN       (BURST_LENGTH),
     .MEM_COL_WIDTH       (COL_WIDTH),
     .PORT_MODE           (PORT_MODE),
     .DATA_PATTERN        (DATA_PATTERN),
     .CMD_PATTERN         (CMD_PATTERN),
     .DATA_WIDTH          (APP_DATA_WIDTH),
     .ADDR_WIDTH          (TG_ADDR_WIDTH),
     .MASK_SIZE           (MASK_SIZE),
     .BEGIN_ADDRESS       (BEGIN_ADDRESS),
     .DATA_MODE           (DATA_MODE),
     .END_ADDRESS         (END_ADDRESS),
     .PRBS_EADDR_MASK_POS (PRBS_EADDR_MASK_POS),
     .SEL_VICTIM_LINE     (SEL_VICTIM_LINE),
     .CMD_WDT             (CMD_WDT),
     .RD_WDT              (RD_WDT),
     .WR_WDT              (WR_WDT),
     .EYE_TEST            (EYE_TEST)
     )
    u_traffic_gen_top
      (
       .clk                  (clk),
       .rst                  (rst),
       .tg_only_rst          (po_win_tg_rst | vio_tg_rst),
       .manual_clear_error   (manual_clear_error),
       .memc_init_done       (init_calib_complete),
       .memc_cmd_full        (~app_rdy),
       .memc_cmd_en          (app_en),
       .memc_cmd_instr       (app_cmd),
       .memc_cmd_bl          (),
       .memc_cmd_addr        (app_addr),
       .memc_wr_en           (app_wdf_wren),
       .memc_wr_end          (app_wdf_end),
       .memc_wr_mask         (app_wdf_mask),
       .memc_wr_data         (app_wdf_data),
       .memc_wr_full         (~app_wdf_rdy),
       .memc_rd_en           (),
       .memc_rd_data         (app_rd_data),
       .memc_rd_empty        (~app_rd_data_valid),
       .qdr_wr_cmd_o         (),
       .qdr_rd_cmd_o         (),
       .vio_pause_traffic    (vio_pause_traffic),
       .vio_modify_enable    (vio_modify_enable),
       .vio_data_mode_value  (vio_data_mode_value),
       .vio_addr_mode_value  (vio_addr_mode_value),
       .vio_instr_mode_value (vio_instr_mode_value),
       .vio_bl_mode_value    (vio_bl_mode_value),
       .vio_fixed_bl_value   (vio_fixed_bl_value),
       .vio_fixed_instr_value(vio_fixed_instr_value),
       .vio_data_mask_gen    (vio_data_mask_gen),
       .fixed_addr_i         (32'b0),
       .fixed_data_i         (32'b0),
       .simple_data0         (32'b0),
       .simple_data1         (32'b0),
       .simple_data2         (32'b0),
       .simple_data3         (32'b0),
       .simple_data4         (32'b0),
       .simple_data5         (32'b0),
       .simple_data6         (32'b0),
       .simple_data7         (32'b0),
       .wdt_en_i             (wdt_en_w),
       .bram_cmd_i           (39'b0),
       .bram_valid_i         (1'b0),
       .bram_rdy_o           (),
       .cmp_data             (cmp_data),
       .cmp_data_valid       (cmp_data_valid),
       .cmp_error            (cmp_error),
       .wr_data_counts       (tg_wr_data_counts),
       .rd_data_counts       (tg_rd_data_counts),
       .dq_error_bytelane_cmp (dq_error_bytelane_cmp),
       .error                (tg_compare_error),
       .error_status         (error_status),
       .cumlative_dq_lane_error (cumlative_dq_lane_error),
       .cmd_wdt_err_o         (cmd_wdt_err_w),
       .wr_wdt_err_o          (wr_wdt_err_w),
       .rd_wdt_err_o          (rd_wdt_err_w),
       .mem_pattern_init_done   (mem_pattern_init_done)
       );


 generate
    if (DEBUG_PORT=="ON") begin: CHIPSCOPE_INST


       always @(posedge clk) begin
         cmp_data_valid_r  <= #TCQ cmp_data_valid;
         if (cmp_data_valid_r) begin
           cmp_data_r[7:0]   <= #TCQ cmp_data[(8*dbg_dqs)+:8];
           cmp_data_r[15:8]  <= #TCQ cmp_data[(8*dbg_dqs)+PAYLOAD_WIDTH+:8];
           cmp_data_r[23:16] <= #TCQ cmp_data[(8*dbg_dqs)+2*PAYLOAD_WIDTH+:8];
           cmp_data_r[31:24] <= #TCQ cmp_data[(8*dbg_dqs)+3*PAYLOAD_WIDTH+:8];
           cmp_data_r[39:32] <= #TCQ (nCK_PER_CLK == 2 && DQ_WIDTH == 8) ? 8'h0 :
                                      cmp_data[(8*dbg_dqs)+4*PAYLOAD_WIDTH+:8];
           cmp_data_r[47:40] <= #TCQ (nCK_PER_CLK == 2 && DQ_WIDTH == 8) ? 8'h0 :
                                      cmp_data[(8*dbg_dqs)+5*PAYLOAD_WIDTH+:8];
           cmp_data_r[55:48] <= #TCQ (nCK_PER_CLK == 2 && DQ_WIDTH == 8) ? 8'h0 :
                                      cmp_data[(8*dbg_dqs)+6*PAYLOAD_WIDTH+:8];
           cmp_data_r[63:56] <= #TCQ (nCK_PER_CLK == 2 && DQ_WIDTH == 8) ? 8'h0 :
                                      cmp_data[(8*dbg_dqs)+7*PAYLOAD_WIDTH+:8];
         end else begin
            cmp_data_r <= #TCQ 'b0;
         end
       end



       assign ddr3_ila_basic_w[124:120]   = 'b0;
       assign ddr3_ila_basic_w[125]       = cmd_wdt_err_w;
       assign ddr3_ila_basic_w[126]       = rd_wdt_err_w;
       assign ddr3_ila_basic_w[127]       = wr_wdt_err_w;
       assign ddr3_ila_basic_w[128]       = tg_compare_error;
       assign ddr3_ila_basic_w[129]       = cmp_data_valid_r;
       assign ddr3_ila_basic_w[130]       = cmp_error;
       assign ddr3_ila_basic_w[131+:64]   = cmp_data_r;
       assign ddr3_ila_basic_w[195+:9]    = dq_error_bytelane_cmp;
       assign ddr3_ila_basic_w[212:204]   = cumlative_dq_lane_error;
       assign ddr3_ila_basic_w[244:213]   = error_status[31:0];  // cmp_addr_i
       assign ddr3_ila_basic_w[250:245]   = error_status[37:32]; // cmp_bl_i
       assign ddr3_ila_basic_w[251]       = error_status[40];    // mcb_cmd_full_i
       assign ddr3_ila_basic_w[252]       = error_status[41];    // mcb_wr_full_i
       assign ddr3_ila_basic_w[253]       = error_status[42];    // mcb_rd_empty_i
       assign ddr3_ila_basic_w[255:254]   = ddr3_ila_rdpath[765:764];

        vio_twm_ddrx u_vio_twm_ddrx (
            .clk         (clk),
            .probe_in0   (win_start),//1
            .probe_in1   (dbg_pi_counter_read_val),//6
            .probe_in2   (pi_win_left_ram_out),//6
            .probe_in3   (pi_win_right_ram_out),//6
            .probe_in4   (win_active),//1
            .probe_in5   (dbg_win_chk),//165
            .probe_in6   (win_current_bit),//7
            .probe_in7   (win_current_byte[3:0]),//4
            .probe_in8   (win_byte_select),//7
            .probe_in9   (po_win_left_ram_out),//9
            .probe_in10  (po_win_right_ram_out),//9
            .probe_in11  (dbg_po_counter_read_val),//9
            .probe_in12  (dbg_mem_pattern_init_done),//1
            .probe_in13  (dbg_tg_compare_error),//1
            .probe_in14  (dbg_tg_wr_data_counts),//48
            .probe_in15  (dbg_tg_rd_data_counts),//48
            .probe_out0  (dbg_bit),//9
            .probe_out1  (dbg_dqs),//5
            .probe_out2  (vio_modify_enable),//1
            .probe_out3  (vio_data_mode_value),//4
            .probe_out4  (vio_addr_mode_value),//3
            .probe_out5  (vio_instr_mode_value),//4
            .probe_out6  (vio_bl_mode_value),//2
            .probe_out7  (vio_fixed_bl_value),//10
            .probe_out8  (vio_data_mask_gen),//1
            .probe_out9  (vio_pause_traffic),//1
            .probe_out10 (vio_fixed_instr_value),//3
            .probe_out11 (dbg_clear_error),//1
            .probe_out12 (vio_tg_rst),//1
            .probe_out13 (wdt_en_w),//1
            .probe_out14 (win_start),//1
            .probe_out15 (win_sel_pi_pon),//1
            .probe_out16 (vio_dbg_sel_pi_incdec),//1
            .probe_out17 (vio_dbg_sel_po_incdec),//1
            .probe_out18 (vio_dbg_pi_f_inc),//1
            .probe_out19 (vio_dbg_pi_f_dec),//1
            .probe_out20 (vio_dbg_po_f_inc),//1
            .probe_out21 (vio_dbg_po_f_dec),//1
            .probe_out22 (vio_dbg_po_f_stg23_sel),//1
            .probe_out23 (vio_win_byte_select_inc),//1
            .probe_out24 (vio_win_byte_select_dec),//1
            .probe_out25 (vio_sel_mux_rdd[3:0]),//4
            .probe_out26 (vio_tg_simple_data_sel)//2
        );

          always @ (posedge clk)
          begin
            if (rst)
            begin
              ddr3_ila_basic    <= 'b0;
              ddr3_ila_rdpath   <= 'b0;
              ddr3_ila_wrpath   <= 'b0;
            end
            else
            begin
              ddr3_ila_basic    <= ddr3_ila_basic_w;
              ddr3_ila_rdpath   <= ddr3_ila_rdpath_w;
              ddr3_ila_wrpath   <= ddr3_ila_wrpath_w;
            end
          end

       assign dbg_mem_pattern_init_done = mem_pattern_init_done;
       assign dbg_tg_wr_data_counts     = tg_wr_data_counts;
       assign dbg_tg_rd_data_counts     = tg_rd_data_counts;

       // Code for creating rising edge pulse for VIO outputs
       always @(posedge clk)
       begin
         vio_dbg_pi_f_inc_r1            <= #TCQ  vio_dbg_pi_f_inc        ;
         vio_dbg_pi_f_dec_r1            <= #TCQ  vio_dbg_pi_f_dec        ;
         vio_dbg_po_f_inc_r1            <= #TCQ  vio_dbg_po_f_inc        ;
         vio_dbg_po_f_dec_r1            <= #TCQ  vio_dbg_po_f_dec        ;
         vio_win_byte_select_inc_r1     <= #TCQ  vio_win_byte_select_inc ;
         vio_win_byte_select_dec_r1     <= #TCQ  vio_win_byte_select_dec ;

         vio_dbg_pi_f_inc_r2            <= #TCQ  vio_dbg_pi_f_inc_r1        ;
         vio_dbg_pi_f_dec_r2            <= #TCQ  vio_dbg_pi_f_dec_r1        ;
         vio_dbg_po_f_inc_r2            <= #TCQ  vio_dbg_po_f_inc_r1        ;
         vio_dbg_po_f_dec_r2            <= #TCQ  vio_dbg_po_f_dec_r1        ;
         vio_win_byte_select_inc_r2     <= #TCQ  vio_win_byte_select_inc_r1 ;
         vio_win_byte_select_dec_r2     <= #TCQ  vio_win_byte_select_dec_r1 ;
       end

       assign vio_dbg_pi_f_inc_re        = vio_dbg_pi_f_inc_r1        & ~vio_dbg_pi_f_inc_r2        ;
       assign vio_dbg_pi_f_dec_re        = vio_dbg_pi_f_dec_r1        & ~vio_dbg_pi_f_dec_r2        ;
       assign vio_dbg_po_f_inc_re        = vio_dbg_po_f_inc_r1        & ~vio_dbg_po_f_inc_r2        ;
       assign vio_dbg_po_f_dec_re        = vio_dbg_po_f_dec_r1        & ~vio_dbg_po_f_dec_r2        ;
       assign vio_win_byte_select_inc_re = vio_win_byte_select_inc_r1 & ~vio_win_byte_select_inc_r2 ;
       assign vio_win_byte_select_dec_re = vio_win_byte_select_dec_r1 & ~vio_win_byte_select_dec_r2 ;

       assign manual_clear_error = (!win_active) ? dbg_clear_error : win_clr_error;
       assign dbg_sel_pi_incdec  = (!win_active) ? vio_dbg_sel_pi_incdec : 1'b1;
       assign dbg_sel_po_incdec  = (!win_active) ? vio_dbg_sel_po_incdec : 1'b1;
       assign dbg_pi_f_inc       = (!win_active) ? vio_dbg_pi_f_inc_re : pi_win_up;
       assign dbg_pi_f_dec       = (!win_active) ? vio_dbg_pi_f_dec_re : pi_win_down;
       assign dbg_po_f_inc       = (!win_active) ? vio_dbg_po_f_inc_re : po_win_up;
       assign dbg_po_f_dec       = (!win_active) ? vio_dbg_po_f_dec_re : po_win_down;
       assign dbg_po_f_stg23_sel = (!win_active) ? vio_dbg_po_f_stg23_sel : po_stg23_sel;

        assign dbg_init_calib_complete          = ddr3_ila_basic[0];
        assign dbg_wrlvl_start                  = ddr3_ila_basic[1];
        assign dbg_wrlvl_done                   = ddr3_ila_basic[2];
        assign dbg_wrlvl_err                    = ddr3_ila_basic[3];
        assign dbg_pi_phaselock_start           = ddr3_ila_basic[4];
        assign dbg_pi_phaselocked_done          = ddr3_ila_basic[5];
        assign dbg_pi_phaselock_err             = ddr3_ila_basic[6];
        assign dbg_pi_dqsfound_start            = ddr3_ila_basic[7];
        assign dbg_pi_dqsfound_done             = ddr3_ila_basic[8];
        assign dbg_pi_dqsfound_err              = ddr3_ila_basic[9];
        assign dbg_rdlvl_start                  = ddr3_ila_basic[11:10];    // 2
        assign dbg_rdlvl_done                   = ddr3_ila_basic[13:12];    // 2
        assign dbg_rdlvl_err                    = ddr3_ila_basic[15:14];    // 2
        assign dbg_oclkdelay_calib_start        = ddr3_ila_basic[16];
        assign dbg_oclkdelay_calib_done         = ddr3_ila_basic[17];
        assign dbg_wrcal_start                  = ddr3_ila_basic[19];
        assign dbg_wrcal_done                   = ddr3_ila_basic[20];
        assign dbg_wrcal_err                    = ddr3_ila_basic[21];
        assign dbg_phy_init_5_0                 = ddr3_ila_basic[27:22];    // 6
        assign dbg_rddata_valid_r               = ddr3_ila_basic[28];
        assign dbg_rddata_r                     = ddr3_ila_basic[92:29];    // 64
        assign dbg_fine_adjust_done_r           = ddr3_ila_basic[93];
        assign dbg_cmd_wdt_err_w                = ddr3_ila_basic[125];
        assign dbg_rd_wdt_err_w                 = ddr3_ila_basic[126];
        assign dbg_wr_wdt_err_w                 = ddr3_ila_basic[127];
        assign dbg_tg_compare_error             = ddr3_ila_basic[128];
        assign dbg_cmp_data_valid               = ddr3_ila_basic[129];
        assign dbg_cmp_error                    = ddr3_ila_basic[130];
        assign dbg_cmp_data_r                   = ddr3_ila_basic[194:131];  // 64
        assign dbg_dq_error_bytelane_cmp        = ddr3_ila_basic[202:195];  // this is only 8 bits, not 9
        assign dbg_cumlative_dq_lane_error      = ddr3_ila_basic[211:204];  // this is only 8 bits, not 9
        assign dbg_cmp_addr_i                   = ddr3_ila_basic[244:213];
        assign dbg_cmp_bl_i                     = ddr3_ila_basic[250:245];
        assign dbg_mcb_cmd_full_i               = ddr3_ila_basic[251];
        assign dbg_mcb_wr_full_i                = ddr3_ila_basic[252];
        assign dbg_mcb_rd_empty_i               = ddr3_ila_basic[253];
        assign dbg_ddrx_ila_rdpath_765_764      = ddr3_ila_basic[255:254];

        assign dbg_wl_state_r                   = ddr3_ila_wrpath[4:0];     // 5
        assign dbg_dqs_cnt_r                    = ddr3_ila_wrpath[9:6];     // 4
        assign dbg_wl_edge_detect_valid_r       = ddr3_ila_wrpath[10];
        assign dbg_rd_data_edge_detect_r_by_dqs = ddr3_ila_wrpath[11];
        assign dbg_wl_po_fine_cnt_by_dqs        = ddr3_ila_wrpath[17:12];   // 6
        assign dbg_wl_po_coarse_cnt_by_dqs      = ddr3_ila_wrpath[20:18];   // 3

        assign dbg_phy_oclkdelay_zfo            = ddr3_ila_wrpath[ 30+: 4];   // 4
        assign dbg_ocal_fuzz2oneeighty          = ddr3_ila_wrpath[ 34+: 6];   // 6
        assign dbg_ocal_fuzz2zero               = ddr3_ila_wrpath[ 40+: 6];   // 6
        assign dbg_ocal_oneeighty2fuzz          = ddr3_ila_wrpath[ 46+: 6];   // 6
        assign dbg_ocal_zero2fuzz               = ddr3_ila_wrpath[ 52+: 6];   // 6
        assign dbg_ocal_oclkdelay_calib_cnt     = ddr3_ila_wrpath[ 58+: 3];   // 3
        assign dbg_ocal_scan_win_not_found      = ddr3_ila_wrpath[ 61+: 1];   // 1
        assign dbg_ocal_lim_done                = ddr3_ila_wrpath[ 62+: 1];   // 1
        assign dbg_ocal_stg3_lim_left           = ddr3_ila_wrpath[241+: 6];   // 6
        assign dbg_ocal_stg3_lim_right          = ddr3_ila_wrpath[247+: 6];   // 6
        assign dbg_ocal_center_calib_start      = ddr3_ila_wrpath[253+: 1];   // 1
        assign dbg_ocal_center_calib_done       = ddr3_ila_wrpath[254+: 1];   // 1
        assign dbg_phy_oclkdelay_cal_taps       = ddr3_ila_wrpath[255+:54];   // 54
        assign dbg_ocal_tap_cnt                 = ddr3_ila_wrpath[ 87+: 6];   // 6

        assign dbg_wrcal_pat_data_match_r       = ddr3_ila_wrpath[64];
        assign dbg_wrcal_pat_data_match_valid_r = ddr3_ila_wrpath[65];
        assign dbg_wrcal_dqs_cnt_r              = ddr3_ila_wrpath[69:66];   // 4
        assign cal2_state_r                     = ddr3_ila_wrpath[74:70];   // 5
        assign not_empty_wait_cnt               = ddr3_ila_wrpath[79:75];   // 5
        assign dbg_early1_data                  = ddr3_ila_wrpath[80];
        assign dbg_early2_data                  = ddr3_ila_wrpath[81];
        assign dbg_early1_data_match_r          = ddr3_ila_wrpath[82];
        assign dbg_early2_data_match_r          = ddr3_ila_wrpath[83];
        assign dbg_wcal_sanity_pat_data_match_valid_r = ddr3_ila_wrpath[84];
        assign dbg_wcal_sanity_chk_start        = ddr3_ila_wrpath[85];
        assign dbg_wcal_sanity_chk_done         = ddr3_ila_wrpath[86];
        assign dbg_wcal_mux_rd_rise0_r          = ddr3_ila_wrpath[184:177]; // 8
        assign dbg_wcal_mux_rd_fall0_r          = ddr3_ila_wrpath[192:185]; // 8
        assign dbg_wcal_mux_rd_rise1_r          = ddr3_ila_wrpath[200:193]; // 8
        assign dbg_wcal_mux_rd_fall1_r          = ddr3_ila_wrpath[208:201]; // 8
        assign dbg_wcal_mux_rd_rise2_r          = ddr3_ila_wrpath[216:209]; // 8
        assign dbg_wcal_mux_rd_fall2_r          = ddr3_ila_wrpath[224:217]; // 8
        assign dbg_wcal_mux_rd_rise3_r          = ddr3_ila_wrpath[232:225]; // 8
        assign dbg_wcal_mux_rd_fall3_r          = ddr3_ila_wrpath[240:233]; // 8
        assign dbg_phy_oclkdelay_cal_57_54      = ddr3_ila_wrpath[91:88];   // 4
        assign dbg_phy_wrlvl_128_75             = ddr3_ila_wrpath[149:96];  // 54
        assign dbg_phy_wrlvl_155_129            = ddr3_ila_wrpath[176:150]; // 27
        assign dbg_phy_wrcal_po_coarse_cnt      = ddr3_ila_wrpath[336:310]; // 27
        assign dbg_phy_wrcal_po_fine_cnt        = ddr3_ila_wrpath[390:337]; // 54

        assign dbg_pi_phase_locked_phy4lanes    = ddr3_ila_rdpath[11:0];    // 12
        assign dbg_pi_dqs_found_lanes_phy4lanes = ddr3_ila_rdpath[23:12];   // 12
        assign dbg_rd_data_offset               = ddr3_ila_rdpath[35:24];   // 12
        assign dbg_cal1_state_r                 = ddr3_ila_rdpath[45:40];   // 6
        assign dbg_cal1_cnt_cpt_r               = ddr3_ila_rdpath[49:46];   // 4
        assign dbg_mux_rd_rise0_r               = ddr3_ila_rdpath[57:50];   // 8
        assign dbg_mux_rd_fall0_r               = ddr3_ila_rdpath[65:58];   // 8
        assign dbg_mux_rd_rise1_r               = ddr3_ila_rdpath[73:66];   // 8
        assign dbg_mux_rd_fall1_r               = ddr3_ila_rdpath[81:74];   // 8
        assign dbg_mux_rd_rise2_r               = ddr3_ila_rdpath[89:82];   // 8
        assign dbg_mux_rd_fall2_r               = ddr3_ila_rdpath[97:90];   // 8
        assign dbg_mux_rd_rise3_r               = ddr3_ila_rdpath[105:98];  // 8
        assign dbg_mux_rd_fall3_r               = ddr3_ila_rdpath[113:106]; // 8
        assign dbg_rdlvl_pat_data_match_r       = ddr3_ila_rdpath[114];
        assign dbg_mux_rd_valid_r               = ddr3_ila_rdpath[115];
        assign dbg_cpt_first_edge_cnt_by_dqs    = ddr3_ila_rdpath[121:116]; // 6
        assign dbg_cpt_second_edge_cnt_by_dqs   = ddr3_ila_rdpath[127:122]; // 6
        assign dbg_cpt_tap_cnt_by_dqs           = ddr3_ila_rdpath[133:128]; // 6
        assign dbg_dq_idelay_tap_cnt_by_dqs     = ddr3_ila_rdpath[138:134]; // 5
        assign dbg_dbg_calib_rd_data_offset_1   = ddr3_ila_rdpath[175:164]; // 12
        assign dbg_dbg_calib_rd_data_offset_2   = ddr3_ila_rdpath[187:176]; // 12
        assign dbg_data_offset                  = ddr3_ila_rdpath[193:188]; // 6
        assign dbg_data_offset_1                = ddr3_ila_rdpath[199:194]; // 6
        assign dbg_data_offset_2                = ddr3_ila_rdpath[205:200]; // 6
        assign dbg_cpt_first_edge_cnt           = ddr3_ila_rdpath[313:206]; // 108
        assign dbg_cpt_second_edge_cnt          = ddr3_ila_rdpath[421:314]; // 108
        assign dbg_cpt_tap_cnt                  = ddr3_ila_rdpath[529:422]; // 108
        assign dbg_dq_idelay_tap_cnt            = ddr3_ila_rdpath[619:530]; // 90
        assign dbg_prbs_rdlvl                   = ddr3_ila_rdpath[874:620]; // 255


        assign dbg_prbs_rdlvl_left_edge_pb[ 0+:6]       = dbg_prbs_rdlvl [0+:6] ;
        assign dbg_prbs_rdlvl_left_loss_pb[ 0+:2]       = dbg_prbs_rdlvl [7:6]  ;
        assign dbg_prbs_rdlvl_left_edge_pb[ 6+:6]       = dbg_prbs_rdlvl [8+:6] ;
        assign dbg_prbs_rdlvl_left_loss_pb[ 2+:2]       = dbg_prbs_rdlvl [15:14];
        assign dbg_prbs_rdlvl_left_edge_pb[12+:6]       = dbg_prbs_rdlvl [16+:6];
        assign dbg_prbs_rdlvl_left_loss_pb[ 4+:2]       = dbg_prbs_rdlvl [23:22];
        assign dbg_prbs_rdlvl_left_edge_pb[18+:6]       = dbg_prbs_rdlvl [24+:6];
        assign dbg_prbs_rdlvl_left_loss_pb[ 6+:2]       = dbg_prbs_rdlvl [31:30];
        assign dbg_prbs_rdlvl_left_edge_pb[24+:6]       = dbg_prbs_rdlvl [32+:6];
        assign dbg_prbs_rdlvl_left_loss_pb[ 8+:2]       = dbg_prbs_rdlvl [39:38];
        assign dbg_prbs_rdlvl_left_edge_pb[30+:6]       = dbg_prbs_rdlvl [40+:6];
        assign dbg_prbs_rdlvl_left_loss_pb[10+:2]       = dbg_prbs_rdlvl [47:46];
        assign dbg_prbs_rdlvl_left_edge_pb[36+:6]       = dbg_prbs_rdlvl [48+:6];
        assign dbg_prbs_rdlvl_left_loss_pb[12+:2]       = dbg_prbs_rdlvl [55:54];
        assign dbg_prbs_rdlvl_left_edge_pb[42+:6]       = dbg_prbs_rdlvl [56+:6];
        assign dbg_prbs_rdlvl_left_loss_pb[14+:2]       = dbg_prbs_rdlvl [63:62];
        assign dbg_prbs_rdlvl_right_edge_pb[ 0+:6]      = dbg_prbs_rdlvl [64+:6]  ;
        assign dbg_prbs_rdlvl_right_gain_pb[ 0+:2]      = dbg_prbs_rdlvl [71:70]  ;
        assign dbg_prbs_rdlvl_right_edge_pb[ 6+:6]      = dbg_prbs_rdlvl [72+:6]  ;
        assign dbg_prbs_rdlvl_right_gain_pb[ 2+:2]      = dbg_prbs_rdlvl [79:78]  ;
        assign dbg_prbs_rdlvl_right_edge_pb[12+:6]      = dbg_prbs_rdlvl [80+:6]  ;
        assign dbg_prbs_rdlvl_right_gain_pb[ 4+:2]      = dbg_prbs_rdlvl [87:86]  ;
        assign dbg_prbs_rdlvl_right_edge_pb[18+:6]      = dbg_prbs_rdlvl [88+:6]  ;
        assign dbg_prbs_rdlvl_right_gain_pb[ 6+:2]      = dbg_prbs_rdlvl [95:94]  ;
        assign dbg_prbs_rdlvl_right_edge_pb[24+:6]      = dbg_prbs_rdlvl [96+:6]  ;
        assign dbg_prbs_rdlvl_right_gain_pb[ 8+:2]      = dbg_prbs_rdlvl [103:102];
        assign dbg_prbs_rdlvl_right_edge_pb[30+:6]      = dbg_prbs_rdlvl [104+:6] ;
        assign dbg_prbs_rdlvl_right_gain_pb[10+:2]      = dbg_prbs_rdlvl [111:110];
        assign dbg_prbs_rdlvl_right_edge_pb[36+:6]      = dbg_prbs_rdlvl [112+:6] ;
        assign dbg_prbs_rdlvl_right_gain_pb[12+:2]      = dbg_prbs_rdlvl [119:118];
        assign dbg_prbs_rdlvl_right_edge_pb[42+:6]      = dbg_prbs_rdlvl [120+:6] ;
        assign dbg_prbs_rdlvl_right_gain_pb[14+:2]      = dbg_prbs_rdlvl [127:126];
        assign dbg_prbs_rdlvl_pi_counter_read_val       = dbg_prbs_rdlvl [128+:6];
        assign dbg_prbs_rdlvl_prbs_dqs_tap_cnt_r        = dbg_prbs_rdlvl [134+:6];
        assign dbg_prbs_rdlvl_prbs_found_1st_edge_r     = dbg_prbs_rdlvl [140]    ;
        assign dbg_prbs_rdlvl_prbs_found_2nd_edge_r     = dbg_prbs_rdlvl [141]    ;
        assign dbg_prbs_rdlvl_compare_err               = dbg_prbs_rdlvl [142]    ;
        assign dbg_prbs_rdlvl_phy_if_empty              = dbg_prbs_rdlvl [143]    ;
        assign dbg_prbs_rdlvl_prbs_rdlvl_start          = dbg_prbs_rdlvl [144]    ;
        assign dbg_prbs_rdlvl_prbs_rdlvl_done           = dbg_prbs_rdlvl [145]    ;
        assign dbg_prbs_rdlvl_prbs_dqs_cnt_r            = dbg_prbs_rdlvl [146+:5] ;
        assign dbg_prbs_rdlvl_left_edge_pb_dqs_cnt      = dbg_prbs_rdlvl [151+:6] ;
        assign dbg_prbs_rdlvl_right_edge_pb_dqs_cnt     = dbg_prbs_rdlvl [157+:6] ;
        assign dbg_prbs_rdlvl_rd_victim_sel             = dbg_prbs_rdlvl [163+:3] ;
        assign dbg_prbs_rdlvl_complex_victim_inc        = dbg_prbs_rdlvl [166]    ;
        assign dbg_prbs_rdlvl_right_gain_pb_dqs_cnt     = dbg_prbs_rdlvl [169+:6] ;
        assign dbg_prbs_rdlvl_ref_bit                   = dbg_prbs_rdlvl [177:175];
        assign dbg_prbs_rdlvl_prbs_state_r1             = dbg_prbs_rdlvl [178+:6];
        assign dbg_prbs_rdlvl_rd_valid_r2               = dbg_prbs_rdlvl [184];
        assign dbg_prbs_rdlvl_compare_err_r0            = dbg_prbs_rdlvl [185];
        assign dbg_prbs_rdlvl_compare_err_f0            = dbg_prbs_rdlvl [186];
        assign dbg_prbs_rdlvl_compare_err_r1            = dbg_prbs_rdlvl [187];
        assign dbg_prbs_rdlvl_compare_err_f1            = dbg_prbs_rdlvl [188];
        assign dbg_prbs_rdlvl_compare_err_r2            = dbg_prbs_rdlvl [189];
        assign dbg_prbs_rdlvl_compare_err_f2            = dbg_prbs_rdlvl [190];
        assign dbg_prbs_rdlvl_compare_err_r3            = dbg_prbs_rdlvl [191];
        assign dbg_prbs_rdlvl_compare_err_f3            = dbg_prbs_rdlvl [192];
        assign dbg_prbs_rdlvl_left_edge_found_pb        = dbg_prbs_rdlvl [193+:8];
        assign dbg_prbs_rdlvl_right_edge_found_pb       = dbg_prbs_rdlvl [201+:8];
        assign dbg_prbs_rdlvl_largest_left_edge         = dbg_prbs_rdlvl [209+:6];
        assign dbg_prbs_rdlvl_smallest_right_edge       = dbg_prbs_rdlvl [215+:6];
        assign dbg_prbs_rdlvl_fine_delay_incdec_pb      = dbg_prbs_rdlvl [221+:8];
        assign dbg_prbs_rdlvl_fine_delay_sel            = dbg_prbs_rdlvl [229];
        assign dbg_prbs_rdlvl_compare_err_pb_latch_r    = dbg_prbs_rdlvl [230+:8];
        assign dbg_prbs_rdlvl_fine_pi_dec_cnt           = dbg_prbs_rdlvl [238+:6];
        assign dbg_prbs_rdlvl_match_flag_and            = dbg_prbs_rdlvl [244+:5];
        assign dbg_prbs_rdlvl_stage_cnt                 = dbg_prbs_rdlvl [249+:2];
        assign dbg_prbs_rdlvl_fine_inc_stage            = dbg_prbs_rdlvl [251];
        assign dbg_prbs_rdlvl_compare_err_pb_and        = dbg_prbs_rdlvl [252];
        assign dbg_prbs_rdlvl_right_edge_found          = dbg_prbs_rdlvl [253];
        assign dbg_prbs_rdlvl_fine_dly_error            = dbg_prbs_rdlvl [254];


        always @(posedge clk)
        begin
            dbg_extn_trig_out_ack_r[0]    <= dbg_extn_trig_out;
            dbg_extn_trig_out_ack_r[7:1]  <= dbg_extn_trig_out_ack_r[6:0];
        end
        assign dbg_extn_trig_out_ack            = dbg_extn_trig_out_ack_r[7];

        ila_ddr3_native u_ila_ddr3_native (
          .clk          (clk),
          .trig_out     (dbg_extn_trig_out),
          .trig_out_ack (dbg_extn_trig_out_ack),
          .probe0       (dbg_init_calib_complete),
          .probe1       (dbg_wrlvl_start),
          .probe2       (dbg_wrlvl_done),
          .probe3       (dbg_wrlvl_err),
          .probe4       (dbg_pi_phaselock_start),
          .probe5       (dbg_pi_phaselocked_done),
          .probe6       (dbg_pi_phaselock_err),
          .probe7       (dbg_pi_dqsfound_start),
          .probe8       (dbg_pi_dqsfound_done),
          .probe9       (dbg_pi_dqsfound_err),
          .probe10      (dbg_rdlvl_start),
          .probe11      (dbg_rdlvl_done),
          .probe12      (dbg_rdlvl_err),
          .probe13      (dbg_oclkdelay_calib_start),
          .probe14      (dbg_oclkdelay_calib_done),
          .probe15      (dbg_wrcal_start),
          .probe16      (dbg_wrcal_done),
          .probe17      (dbg_wrcal_err),
          .probe18      (dbg_phy_init_5_0),
          .probe19      (dbg_rddata_valid_r),
          .probe20      (dbg_rddata_r),
          .probe21      (dbg_fine_adjust_done_r),
          .probe22      (dbg_cmd_wdt_err_w),
          .probe23      (dbg_rd_wdt_err_w),
          .probe24      (dbg_wr_wdt_err_w),
          .probe25      (dbg_tg_compare_error),
          .probe26      (dbg_cmp_data_valid),
          .probe27      (dbg_cmp_error),
          .probe28      (dbg_cmp_data_r),
          .probe29      (dbg_dq_error_bytelane_cmp),
          .probe30      (dbg_cumlative_dq_lane_error),
          .probe31      (dbg_cmp_addr_i),
          .probe32      (dbg_cmp_bl_i),
          .probe33      (dbg_mcb_cmd_full_i),
          .probe34      (dbg_mcb_wr_full_i),
          .probe35      (dbg_mcb_rd_empty_i),
          .probe36      (dbg_ddrx_ila_rdpath_765_764),
          .probe37      (dbg_wl_state_r),
          .probe38      (dbg_dqs_cnt_r),
          .probe39      (dbg_wl_edge_detect_valid_r),
          .probe40      (dbg_rd_data_edge_detect_r_by_dqs),
          .probe41      (dbg_wl_po_fine_cnt_by_dqs),
          .probe42      (dbg_wl_po_coarse_cnt_by_dqs),

          .probe43      (dbg_phy_oclkdelay_zfo),
          .probe44      (dbg_ocal_fuzz2oneeighty),
          .probe45      (dbg_ocal_fuzz2zero),
          .probe46      (dbg_ocal_oneeighty2fuzz),
          .probe47      (dbg_ocal_zero2fuzz),
          .probe48      (dbg_ocal_oclkdelay_calib_cnt),
          .probe49      (dbg_ocal_scan_win_not_found),

          .probe50      (dbg_wrcal_pat_data_match_r),
          .probe51      (dbg_wrcal_pat_data_match_valid_r),
          .probe52      (dbg_wrcal_dqs_cnt_r),
          .probe53      (cal2_state_r),
          .probe54      (not_empty_wait_cnt),
          .probe55      (dbg_early1_data),
          .probe56      (dbg_early2_data),
          .probe57      (dbg_phy_oclkdelay_cal_57_54),
          .probe58      (dbg_phy_wrlvl_128_75),
          .probe59      (dbg_phy_wrlvl_155_129),
          .probe60      (dbg_pi_phase_locked_phy4lanes),
          .probe61      (dbg_pi_dqs_found_lanes_phy4lanes),
          .probe62      (dbg_rd_data_offset),
          .probe63      (dbg_cal1_state_r),
          .probe64      (dbg_cal1_cnt_cpt_r),
          .probe65      (dbg_mux_rd_rise0_r),
          .probe66      (dbg_mux_rd_fall0_r),
          .probe67      (dbg_mux_rd_rise1_r),
          .probe68      (dbg_mux_rd_fall1_r),
          .probe69      (dbg_mux_rd_rise2_r),
          .probe70      (dbg_mux_rd_fall2_r),
          .probe71      (dbg_mux_rd_rise3_r),
          .probe72      (dbg_mux_rd_fall3_r),
          .probe73      (dbg_rdlvl_pat_data_match_r),
          .probe74      (dbg_mux_rd_valid_r),
          .probe75      (dbg_cpt_first_edge_cnt_by_dqs),
          .probe76      (dbg_cpt_second_edge_cnt_by_dqs),
          .probe77      (dbg_cpt_tap_cnt_by_dqs),
          .probe78      (dbg_dq_idelay_tap_cnt_by_dqs),
          .probe79      (dbg_dbg_calib_rd_data_offset_1),
          .probe80      (dbg_dbg_calib_rd_data_offset_2),
          .probe81      (dbg_data_offset),
          .probe82      (dbg_data_offset_1),
          .probe83      (dbg_data_offset_2),
          .probe84      (dbg_cpt_first_edge_cnt),
          .probe85      (dbg_cpt_second_edge_cnt),
          .probe86      (dbg_cpt_tap_cnt),
          .probe87      (dbg_dq_idelay_tap_cnt),

          .probe88      (dbg_prbs_rdlvl_left_edge_pb),
          .probe89      (dbg_prbs_rdlvl_left_loss_pb),
          .probe90      (dbg_prbs_rdlvl_right_edge_pb),
          .probe91      (dbg_prbs_rdlvl_right_gain_pb),
          .probe92      (dbg_prbs_rdlvl_pi_counter_read_val),
          .probe93      (dbg_prbs_rdlvl_prbs_dqs_tap_cnt_r),
          .probe94      (dbg_prbs_rdlvl_prbs_found_1st_edge_r),
          .probe95      (dbg_prbs_rdlvl_prbs_found_2nd_edge_r),
          .probe96      (dbg_prbs_rdlvl_compare_err),
          .probe97      (dbg_prbs_rdlvl_phy_if_empty),
          .probe98      (dbg_prbs_rdlvl_prbs_rdlvl_start),
          .probe99      (dbg_prbs_rdlvl_prbs_rdlvl_done),
          .probe100     (dbg_prbs_rdlvl_prbs_dqs_cnt_r),
          .probe101     (dbg_prbs_rdlvl_left_edge_pb_dqs_cnt),
          .probe102     (dbg_prbs_rdlvl_right_edge_pb_dqs_cnt),
          .probe103     (dbg_prbs_rdlvl_rd_victim_sel),
          .probe104     (dbg_prbs_rdlvl_complex_victim_inc),
          .probe105     (dbg_prbs_rdlvl_right_gain_pb_dqs_cnt),
          .probe106     (dbg_prbs_rdlvl_ref_bit),
          .probe107     (dbg_prbs_rdlvl_prbs_state_r1),
          .probe108     (dbg_prbs_rdlvl_rd_valid_r2),
          .probe109     (dbg_prbs_rdlvl_compare_err_r0),
          .probe110     (dbg_prbs_rdlvl_compare_err_f0),
          .probe111     (dbg_prbs_rdlvl_compare_err_r1),
          .probe112     (dbg_prbs_rdlvl_compare_err_f1),
          .probe113     (dbg_prbs_rdlvl_compare_err_r2),
          .probe114     (dbg_prbs_rdlvl_compare_err_f2),
          .probe115     (dbg_prbs_rdlvl_compare_err_r3),
          .probe116     (dbg_prbs_rdlvl_compare_err_f3),
          .probe117     (dbg_prbs_rdlvl_left_edge_found_pb),
          .probe118     (dbg_prbs_rdlvl_right_edge_found_pb),
          .probe119     (dbg_prbs_rdlvl_largest_left_edge),
          .probe120     (dbg_prbs_rdlvl_smallest_right_edge),
          .probe121     (dbg_prbs_rdlvl_fine_delay_incdec_pb),
          .probe122     (dbg_prbs_rdlvl_fine_delay_sel),
          .probe123     (dbg_prbs_rdlvl_compare_err_pb_latch_r),
          .probe124     (dbg_prbs_rdlvl_fine_pi_dec_cnt),
          .probe125     (dbg_prbs_rdlvl_match_flag_and),
          .probe126     (dbg_prbs_rdlvl_stage_cnt),
          .probe127     (dbg_prbs_rdlvl_fine_inc_stage),
          .probe128     (dbg_prbs_rdlvl_compare_err_pb_and),
          .probe129     (dbg_prbs_rdlvl_right_edge_found),
          .probe130     (dbg_prbs_rdlvl_fine_dly_error),

          .probe131     (dbg_ocal_lim_done),
          .probe132     (dbg_ocal_stg3_lim_left),
          .probe133     (dbg_ocal_stg3_lim_right),
          .probe134     (dbg_ocal_center_calib_start),

          .probe135     (dbg_wcal_mux_rd_rise0_r),
          .probe136     (dbg_wcal_mux_rd_fall0_r),
          .probe137     (dbg_wcal_mux_rd_rise1_r),
          .probe138     (dbg_wcal_mux_rd_fall1_r),
          .probe139     (dbg_wcal_mux_rd_rise2_r),
          .probe140     (dbg_wcal_mux_rd_fall2_r),
          .probe141     (dbg_wcal_mux_rd_rise3_r),
          .probe142     (dbg_wcal_mux_rd_fall3_r),
          .probe143     (dbg_early1_data_match_r),
          .probe144     (dbg_early2_data_match_r),
          .probe145     (dbg_wcal_sanity_pat_data_match_valid_r),
          .probe146     (dbg_prbs_final_dqs_tap_cnt_r),//108
          .probe147     (dbg_prbs_first_edge_taps),//108
          .probe148     (dbg_prbs_second_edge_taps),//108
          .probe149     (dbg_ocal_center_calib_done),
          .probe150     (dbg_phy_oclkdelay_cal_taps),
          .probe151     (dbg_ocal_tap_cnt),
          .probe152     (device_temp)

        );

       always @(posedge clk)
       begin
         app_rd_data_valid_r1  <= #TCQ app_rd_data_valid;
         app_rd_data_valid_r2  <= #TCQ app_rd_data_valid_r1;
         app_rd_data_valid_r3  <= #TCQ app_rd_data_valid_r2;
         app_rd_data_r1        <= app_rd_data;
         app_rd_data_r2        <= app_rd_data_r1;
         app_rd_data_r3        <= app_rd_data_r2;
       end

       always @(posedge clk)
         if (rst)
           win_byte_select <= #TCQ 'b0;
         else if (vio_win_byte_select_inc_re) begin
           if (win_byte_select == (DQ_WIDTH/DRAM_WIDTH))
             win_byte_select <= #TCQ 'b0;
           else
             win_byte_select <= #TCQ win_byte_select + 1;
         end else if (vio_win_byte_select_dec_re) begin
           if (win_byte_select == 0)
             win_byte_select <= #TCQ (DQ_WIDTH/DRAM_WIDTH)-1;
           else
             win_byte_select <= #TCQ win_byte_select - 1;
         end

       always @(posedge clk) begin
         if (rst)
           dbg_byte_sel_r <= #TCQ 'd0;
         else begin
           if (!win_active)
             dbg_byte_sel_r <= #TCQ vio_sel_mux_rdd;
           else
             dbg_byte_sel_r <= #TCQ win_current_byte;
         end
       end

       mig_7series_v4_2_chk_win #
         (
          .TCQ         (TCQ),
          .nCK_PER_CLK (nCK_PER_CLK),
          .DLY_WIDTH   (26),
          .DQ_PER_DQS  (DRAM_WIDTH),
          .DQ_WIDTH    (PAYLOAD_WIDTH),
          .SC_WIDTH    (3),
          .SDC_WIDTH   (5),
          .WIN_SIZE    (6),
          .SIM_OPTION  (SIMULATION)
          )
         u_chk_win
           (
            .clk                   (clk),
            .rst                   (rst),
            .mem_pattern_init_done (mem_pattern_init_done),
            .win_start             (win_start),
            .read_valid            (app_rd_data_valid_r2),
            .win_byte_select       (win_byte_select),
            .cmp_data              (cmp_data),
            .rd_data               (app_rd_data_r2),
            .win_sel_pi_pon        (win_sel_pi_pon),
            .pi_curr_tap_cnt       (dbg_pi_counter_read_val),
            .po_curr_tap_cnt       (dbg_po_counter_read_val),
            .pi_left_ram_out       (pi_win_left_ram_out),
            .pi_right_ram_out      (pi_win_right_ram_out),
            .po_left_ram_out       (po_win_left_ram_out),
            .po_right_ram_out      (po_win_right_ram_out),
            .win_active            (win_active),
            .win_clr_error         (win_clr_error),
            .pi_win_up             (pi_win_up),
            .pi_win_down           (pi_win_down),
            .po_win_up             (po_win_up),
            .po_stg23_sel          (po_stg23_sel),
            .po_win_down           (po_win_down),
            .po_win_tg_rst         (po_win_tg_rst),
            .win_current_bit       (win_current_bit),
            .win_current_byte      (win_current_byte[3:0]),
            .dbg_clear_error       (dbg_clear_error),
            .dbg_win_chk           (dbg_win_chk)
            );

    end
    else begin: NO_CHIPSCOPE
       assign vio_modify_enable     = 1'b0;
       assign vio_data_mode_value   = 4'b0010;
       assign vio_addr_mode_value   = 3'b011;
       assign vio_instr_mode_value  = 4'b0010;
       assign vio_bl_mode_value     = 2'b10;
       assign vio_fixed_bl_value    = 'd16;
       assign vio_data_mask_gen     = 1'b0;
       assign vio_pause_traffic     = 1'b0;
       assign vio_fixed_instr_value = 3'b001;
       assign dbg_clear_error       = 1'b0;

       assign dbg_sel_pi_incdec       = 'b0;
       assign dbg_sel_po_incdec       = 'b0;
       assign manual_clear_error      = 'b0;
       assign dbg_pi_f_inc            = 'b0;
       assign dbg_pi_f_dec            = 'b0;
       assign dbg_po_f_inc            = 'b0;
       assign dbg_po_f_dec            = 'b0;
       assign dbg_po_f_stg23_sel      = 'b0;
       assign win_start               = 'b0;
       assign win_sel_pi_pon          = 'b0;

       assign vio_win_byte_select_inc = 'b0;
       assign vio_win_byte_select_dec = 'b0;
       assign vio_sel_mux_rdd         = 'b0;
       assign vio_tg_simple_data_sel  = 'b0;
       assign po_win_tg_rst           = 'b0;
       assign vio_tg_rst              = 'b0;
       assign wdt_en_w                = 'b1;

    end
 endgenerate

       
`ifdef SKIP_CALIB
  //***************************************************************************
  // Skip calib test logic
  //***************************************************************************

  reg[3*DQS_WIDTH-1:0]        po_coarse_tap;
  reg[6*DQS_WIDTH-1:0]        po_stg3_taps;
  reg[6*DQS_WIDTH-1:0]        po_stg2_taps;
  reg[6*DQS_WIDTH-1:0]        pi_stg2_taps;
  reg[5*DQS_WIDTH-1:0]        idelay_taps;
  reg[11:0]                   cal_device_temp;


  always @(posedge clk) begin
    // tap values from golden run (factory)
    po_coarse_tap   <= #TCQ 'h2;
    po_stg3_taps    <= #TCQ 'h0D;
    po_stg2_taps    <= #TCQ 'h1D;
    pi_stg2_taps    <= #TCQ 'h1E;
    idelay_taps     <= #TCQ 'h08;
        cal_device_temp <= #TCQ 'h000;
  end

  always @(posedge clk) begin
    if (rst)
      calib_tap_load <= #TCQ 1'b0;
    else if (calib_tap_req)
      calib_tap_load <= #TCQ 1'b1;
  end

  always @(posedge clk) begin
    if (rst) begin
      calib_tap_addr      <= #TCQ 'd0;
      calib_tap_val       <= #TCQ po_coarse_tap[3*calib_tap_addr[6:3]+:3]; //'d1;
      calib_tap_load_done <= #TCQ 1'b0;
    end else if (calib_tap_load) begin
      case (calib_tap_addr[2:0])
        3'b000: begin
          calib_tap_addr[2:0] <= #TCQ 3'b001;
          calib_tap_val       <= #TCQ po_stg3_taps[6*calib_tap_addr[6:3]+:6]; //'d19;
        end
        3'b001: begin
          calib_tap_addr[2:0] <= #TCQ 3'b010;
          calib_tap_val       <= #TCQ po_stg2_taps[6*calib_tap_addr[6:3]+:6]; //'d45;
        end
        3'b010: begin
          calib_tap_addr[2:0] <= #TCQ 3'b011;
          calib_tap_val       <= #TCQ pi_stg2_taps[6*calib_tap_addr[6:3]+:6]; //'d20;
        end
        3'b011: begin
          calib_tap_addr[2:0] <= #TCQ 3'b100;
          calib_tap_val       <= #TCQ idelay_taps[5*calib_tap_addr[6:3]+:5]; //'d1;
        end
        3'b100: begin
          if (calib_tap_addr[6:3] < DQS_WIDTH-1) begin
            calib_tap_addr[2:0] <= #TCQ 3'b000;
            calib_tap_val       <= #TCQ po_coarse_tap[3*(calib_tap_addr[6:3]+1)+:3]; //'d1;
            calib_tap_addr[6:3] <= #TCQ calib_tap_addr[6:3] + 1;
          end else begin
            calib_tap_addr[2:0] <= #TCQ 3'b110;
            calib_tap_val       <= #TCQ cal_device_temp[7:0];
            calib_tap_addr[6:3] <= #TCQ 4'b1111;
          end
        end
        3'b110: begin
            calib_tap_addr[2:0] <= #TCQ 3'b111;
            calib_tap_val       <= #TCQ {4'h0,cal_device_temp[11:8]};
            calib_tap_addr[6:3] <= #TCQ 4'b1111;
        end
        3'b111: begin
            calib_tap_load_done <= #TCQ 1'b1;
        end
      endcase
    end
  end


//****************skip calib test logic end**********************************
`endif    

endmodule


