
-------------------------------------------------------------------------------
-- xadc_wiz_0_xadc_core_drp.vhd - entity/architecture pair
-------------------------------------------------------------------------------
--
-- ************************************************************************
-- ** DISCLAIMER OF LIABILITY                                            **
-- **                                                                    **
-- ** This file contains proprietary and confidential information of     **
-- ** Xilinx, Inc. ("Xilinx"), that is distributed under a license       **
-- ** from Xilinx, and may be used, copied and/or disclosed only         **
-- ** pursuant to the terms of a valid license agreement with Xilinx.    **
-- **                                                                    **
-- ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION              **
-- ** ("MATERIALS") "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER         **
-- ** EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING WITHOUT                **
-- ** LIMITATION, ANY WARRANTY WITH RESPECT TO NONINFRINGEMENT,          **
-- ** MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. Xilinx      **
-- ** does not warrant that functions included in the Materials will     **
-- ** meet the requirements of Licensee, or that the operation of the    **
-- ** Materials will be uninterrupted or error-free, or that defects     **
-- ** in the Materials will be corrected. Furthermore, Xilinx does       **
-- ** not warrant or make any representations regarding use, or the      **
-- ** results of the use, of the Materials in terms of correctness,      **
-- ** accuracy, reliability or otherwise.                                **
-- **                                                                    **
-- ** Xilinx products are not designed or intended to be fail-safe,      **
-- ** or for use in any application requiring fail-safe performance,     **
-- ** such as life-support or safety devices or systems, Class III       **
-- ** medical devices, nuclear facilities, applications related to       **
-- ** the deployment of airbags, or any other applications that could    **
-- ** lead to death, personal injury or severe property or               **
-- ** environmental damage (individually and collectively, "critical     **
-- ** applications"). Customer assumes the sole risk and liability       **
-- ** of any use of Xilinx products in critical applications,            **
-- ** subject only to applicable laws and regulations governing          **
-- ** limitations on product liability.                                  **
-- **                                                                    **
-- ** Copyright 2010, 2011 Xilinx, Inc.                                  **
-- ** All rights reserved.                                               **
-- **                                                                    **
-- ** This disclaimer and copyright notice must be retained as part      **
-- ** of this file at all times.                                         **
-- ************************************************************************
-------------------------------------------------------------------------------
-- File          : xadc_wiz_0_xadc_core_drp.vhd
-- Version       : v1.00.a
-- Description   : XADC for AXI bus on new FPGA devices.
--                 This file containts actual interface between the core
--                 and XADC hard macro.
-- Standard      : VHDL-93
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Structure:
--             axi_xadc.vhd
--               -xadc_wiz_0_xadc_core_drp.vhd
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Naming Conventions:
--      active low signals:                     "*_n"
--      clock signals:                          "clk", "clk_div#", "clk_#x"
--      reset signals:                          "rst", "rst_n"
--      generics:                               "C_*"
--      user defined types:                     "*_TYPE"
--      state machine next state:               "*_ns"
--      state machine current state:            "*_cs"
--      combinatorial signals:                  "*_cmb"
--      pipelined or register delay signals:    "*_d#"
--      counter signals:                        "*cnt*"
--      clock enable signals:                   "*_ce"
--      internal version of output port         "*_i"
--      device pins:                            "*_pin"
--      ports:                                  - Names begin with Uppercase
--      processes:                              "*_PROCESS"
--      component instantiations:               "<ENTITY_>I_<#|FUNC>
-------------------------------------------------------------------------------

library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.std_logic_arith.conv_std_logic_vector;
    use IEEE.std_logic_arith.unsigned;
    use IEEE.std_logic_arith.all;
    use IEEE.std_logic_misc.or_reduce;
    use IEEE.numeric_std.all;

Library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- un-comment below line if testing locally with BLH or UNISIM model
--use unisim.XADC;

-------------------------------------------------------------------------------
--   AXI4STREAM MASTER SIGNALS 
-------------------------------------------------------------------------------
--    m_axis_tdata         -- 16 bit Axi4Stream Data
--    m_axis_tvalid        -- Valid 
--    m_axis_tid          -- 5 bit Tag ID 
--    m_axis_tready        -- Ready 

-------------------------------------------------------------------------------
-- XADC EXTERNAL INTERFACE --   INPUT Signals
-------------------------------------------------------------------------------
--    VAUXN                  -- user selectable differential inputs
--    VAUXP                  -- user selectable differential inputs
--    CONVST                 -- Conversion start signal for event-driven
                             -- sampling mode
-------------------------------------------------------------------------------
-- XADC Interrupt  --   OUTPUT Signal to Interrupt Module
-------------------------------------------------------------------------------
--    Interrupt_status       -- interrupt from the sysmon core
--    ALARM                  -- XADC alarm output signals of the hard macro
-------------------------------------------------------------------------------

entity xadc_wiz_0_xadc_core_drp is
   port
   (
     daddr_in               : in  std_logic_vector (6 downto 0);  
     den_in                 : in  std_logic;                      
     di_in                  : in  std_logic_vector (15 downto 0); 
     dwe_in                 : in  std_logic;                      
     do_out                 : out  std_logic_vector (15 downto 0);
     drdy_out               : out  std_logic;                
  -- axi4stream master signals 
     s_axis_aclk            : in  std_logic;
     m_axis_aclk            : in  std_logic;
     m_axis_resetn          : in  std_logic;                                      
     m_axis_tdata           : out std_logic_vector(15 downto 0);
     m_axis_tvalid          : out std_logic;
     m_axis_tid             : out std_logic_vector(4 downto 0);
     m_axis_tready          : in  std_logic;
     ----------------  sysmon macro interface  -------------------
     vauxp0                 : in  STD_LOGIC;                         -- Auxiliary Channel 0
     vauxn0                 : in  STD_LOGIC;
     vauxp1                 : in  STD_LOGIC;                         -- Auxiliary Channel 1
     vauxn1                 : in  STD_LOGIC;
     vauxp8                 : in  STD_LOGIC;                         -- Auxiliary Channel 8
     vauxn8                 : in  STD_LOGIC;
     busy_out               : out  STD_LOGIC;                        -- ADC Busy signal
     channel_out            : out  STD_LOGIC_VECTOR (4 downto 0);    -- Channel Selection Outputs
     eoc_out                : out  STD_LOGIC;                        -- End of Conversion Signal
     eos_out                : out  STD_LOGIC;                        -- End of Sequence Signal
     ot_out                 : out STD_LOGIC;
     alarm_out              : out STD_LOGIC_VECTOR (7 downto 0);
     temp_out               : out std_logic_vector(11 downto 0);
     vp_in                  : in  STD_LOGIC;                         -- Dedicated Analog Input Pair
     vn_in                  : in  STD_LOGIC
   );

end entity xadc_wiz_0_xadc_core_drp;
-------------------------------------------------------------------------------
-- Architecture Section
-------------------------------------------------------------------------------
architecture imp of xadc_wiz_0_xadc_core_drp is

  component drp_to_axi4stream
  port (
    m_axis_reset    : in  std_logic;                      
    m_axis_aclk     : in  std_logic;
    s_axis_aclk     : in  std_logic;
    mode_change     : in  std_logic;                      
    mode_change_sig_reset: out std_logic;  
    temp_bus_update : in std_logic;
    wait_cycle      : in   std_logic_vector(15 downto 0);
    temp_out        : out std_logic_vector(11 downto 0);
    -- DRP signals for Arbiter
    daddr_o         : out std_logic_vector(7 downto 0);    
    den_o           : out std_logic;
    di_o            : out std_logic_vector(15 downto 0);
    dwe_o           : out std_logic;
    do_i            : in  std_logic_vector(15 downto 0);
    drdy_i          : in  std_logic;
    busy_o          : out std_logic;
    -- Control signals for stream generation
    channel_in      : in  std_logic_vector(4 downto 0);
    eoc_in          : in  std_logic;
    eos_in          : in  std_logic;
    -- axi4stream master signals for FIFO
    m_axis_tdata    : out std_logic_vector(15 downto 0);
    m_axis_tvalid   : out std_logic;
    m_axis_tid      : out std_logic_vector(4 downto 0);
    m_axis_tready   : in  std_logic
  );
  end component;
component  drp_arbiter
  port (
  reset   : in     std_logic;                  
  clk     : in     std_logic;                   -- input clock
  jtaglocked: in     std_logic;                   -- input clock
  bgrant_A : out    std_logic;  -- bus grant
  bgrant_B : out    std_logic;  -- bus grant
  bbusy_A   : in    std_logic;                    -- bus busy
  bbusy_B   : in    std_logic := '0';                    -- bus busy
  daddr_A  : in  std_logic_vector(7 downto 0);
  den_A    : in  std_logic;
  di_A     : in  std_logic_vector(15 downto 0);
  dwe_A    : in  std_logic;
  do_A     : out   std_logic_vector(15 downto 0);
  drdy_A   : out   std_logic;
  daddr_B  : in  std_logic_vector(7 downto 0);
  den_B    : in  std_logic;
  di_B     : in  std_logic_vector(15 downto 0);
  dwe_B    : in  std_logic;
  do_B     : out   std_logic_vector(15 downto 0);
  drdy_B   : out   std_logic;
  daddr_C  : out  std_logic_vector(7 downto 0);
  den_C    : out  std_logic;
  di_C     : out  std_logic_vector(15 downto 0);
  dwe_C    : out  std_logic;
  do_C     : in   std_logic_vector(15 downto 0);
  drdy_C   : in   std_logic
);
	end component;

signal sysmon_hard_block_reset   : std_logic;
-------------------------------------------------------------------------------
-- Constant Declarations
-------------------------------------------------------------------------------
constant DATA_SIZE_DRP     : integer := 16;

constant ADDR_SIZE_DRP     : integer := 7;

constant CHANNEL_NO        : integer := 5;

constant ALARM_NO          : integer := 8; -- updated from 3 to 8 for XADC

constant ALARM_REG_LENGTH  : integer := 9;-- internal constant-- updated from 4 to 9 for XADC

constant STATUS_REG_LENGTH : integer := 11;--internal constant

-------------------------------------------------------------------------------
-- Signal Declarations
-------------------------------------------------------------------------------
signal daddr_i        : std_logic_vector(ADDR_SIZE_DRP-1 downto 0);
signal alm_i          : std_logic_vector(ALARM_NO-1 downto 0);
signal channel_i      : std_logic_vector(CHANNEL_NO-1 downto 0);
signal mode_change    : std_logic := '0';
signal mode_change_sig_reset: std_logic := '0';  

signal mux_addr_no_i  : std_logic_vector(4 downto 0);

signal do_i           : std_logic_vector(DATA_SIZE_DRP-1 downto 0);
signal di_i           : std_logic_vector(DATA_SIZE_DRP-1 downto 0);

signal den_i          : std_logic;
signal dwe_i          : std_logic;
signal busy_i         : std_logic;
signal drdy_i         : std_logic;
signal eoc_i          : std_logic;
signal eos_i          : std_logic;
signal ot_i           : std_logic;

signal daddr_C        :  std_logic_vector(7 downto 0);
signal den_C          :  std_logic;
signal di_C           :  std_logic_vector(15 downto 0);
signal dwe_C          :  std_logic;
signal do_C           :  std_logic_vector(15 downto 0);
signal drdy_C         :  std_logic;
signal bgrant_B       :  std_logic;
signal daddr_i_int    : std_logic_vector(ADDR_SIZE_DRP downto 0);
signal temp_bus_update: std_logic := '0';
signal temp_rd_wait_cycle_reg :   std_logic_vector(15 downto 0) := X"03E8";

-- JTAG related signals
signal jtaglocked_i      : std_logic;
signal jtagbusy_i        : std_logic;
signal jtagmodified_i    : std_logic;
signal jtagmodified_d1   : std_logic;
signal jtag_modified_info: std_logic;
signal aux_channel_p : std_logic_vector (15 downto 0);
signal aux_channel_n : std_logic_vector (15 downto 0);

signal	daddr_A :  std_logic_vector(7 downto 0);
signal	den_A :  std_logic;
signal	di_A :  std_logic_vector(15 downto 0);
signal	dwe_A :  std_logic;
signal	do_A :  std_logic_vector(15 downto 0);
signal	drdy_A :  std_logic;
signal	bbusy_A :  std_logic;
signal	drp_addr :  std_logic_vector(7 downto 0);

-------------------------------------------------------------------------------
begin

   daddr_i_int <= '0' & daddr_i;
  sysmon_hard_block_reset <= not m_axis_resetn;
  drp_addr <= '0' & daddr_in;

mode_change_gen: process(m_axis_aclk,sysmon_hard_block_reset) is
begin
   if (sysmon_hard_block_reset = '1') then
      mode_change <= '0';
   elsif (m_axis_aclk'event and m_axis_aclk='1') then
     if (drp_addr = X"41" and dwe_in = '1' and den_in = '1') then
         mode_change <= '1';
     elsif mode_change_sig_reset = '1' then 
         mode_change <= '0';
     end if;
   end if;
end process mode_change_gen;

-- Instantiate the axi4stream arbiter
   axi4_stream_inst: drp_to_axi4stream port map (
      m_axis_reset    => sysmon_hard_block_reset,
      m_axis_aclk     => m_axis_aclk,  
      s_axis_aclk     => s_axis_aclk,  
      wait_cycle      => temp_rd_wait_cycle_reg,
      temp_out => temp_out,
      temp_bus_update => '1',
      mode_change     => mode_change,  
      mode_change_sig_reset => mode_change_sig_reset,  
      daddr_o         => daddr_A,   
      den_o           => den_A,     
      di_o            => di_A,      
      dwe_o           => dwe_A,     
      do_i            => do_A,      
      drdy_i          => drdy_A,    
      busy_o          => bbusy_A,    
      channel_in      => channel_i,
      eoc_in          => eoc_i,    
      eos_in          => eos_i,    
      m_axis_tdata    => m_axis_tdata,  
      m_axis_tvalid   => m_axis_tvalid, 
      m_axis_tid      => m_axis_tid,   
      m_axis_tready   => m_axis_tready 
   );

   Inst_drp_arbiter: drp_arbiter PORT MAP(
      reset           => sysmon_hard_block_reset,
      clk             => m_axis_aclk ,
      jtaglocked      => jtaglocked_i,
      bgrant_A        => open ,
      bgrant_B        => bgrant_B ,
      bbusy_A         => bbusy_A ,
      bbusy_B         => '0',
      daddr_A         => daddr_A ,
      den_A           => den_A ,
      di_A            => di_A ,
      dwe_A           => dwe_A ,
      do_A            => do_A ,
      drdy_A          => drdy_A ,
      daddr_B         => drp_addr ,
      den_B           => den_in ,
      di_B            => di_in ,
      dwe_B           => dwe_in ,
      do_B            => do_out ,
      drdy_B          => drdy_out ,
      daddr_C         => daddr_C ,
      den_C           => den_C ,
      di_C            => di_C ,
      dwe_C           => dwe_C ,
      do_C            => do_C ,
      drdy_C          => drdy_C	
   );

     alarm_out <= alm_i;

     ot_out <= ot_i;

     busy_out  <= busy_i;
     channel_out <= channel_i;
     eoc_out <= eoc_i;
     eos_out <= eos_i;



-- Added interface to MUX ADDRESS for external address multiplexer from the
-- XADC macro to core ports.

-------------------------------------------------------------------------------
-- == XADC INTERFACE --  OUTPUT Signals ==
-------------------------------------------------------------------------------
--    BUSY          -- ADC busy signal
--    DRDY          -- Data ready signal for Dynamic Reconfigurable Port
--    EOC           -- End of conversion for ADC
--    EOS           -- End of sequence used in auto sequence mode
--    JTAGBUSY      -- Used to indicate that the JTAG DRP is doing transaction
--    JTAGLOCKED    -- Used to indicate the DRP port lock is requested
--    JTAGMODIFIED  -- Used to indicate that the JTAG write to JTAG is happened
--    OT            -- Signal for Over Temperature alarm
--    ALM           -- Sysmon Alarm outputs
--    CHANNEL       -- Channel selection outputs
--    DO            -- Output data bus for Dynamic Reconfigurable Port
-------------------------------------------------------------------------------
-- == XADC INTERFACE --   INPUT Signals ==
-------------------------------------------------------------------------------
--    VN            -- High Bandwidth Dedicated analog input pair
--    VP               which provides differential analog input. These pins are
--                     just like dedicated suply pins and user dont have control
--                     over these pins.
--    CONVST        -- Conversion start input used in event driven sampling
--    CONVSTCLK     -- Conversion start clock input
--    DCLK          -- Clock input for Dynamic Reconfigurable Port
--    DEN           -- Enable signal for Dynamic Reconfigurable Port
--    DWE           -- Write Enable signal for Dynamic Reconfigurable Port
--    RESET         -- External hard Reset input
--    DADDR         -- Address bus for Dynamic Reconfigurable Port
--    DI            -- Input data bus for Dynamic Reconfigurable Port
--    VAUXN         -- Low Bandwidth, Sixteen auxiliary analog input pairs
--    VAUXP            which provides differential analog inputs
--    MUXADDR       -- External address multiplexer driven by Channel selection
--                     Registers
        aux_channel_p(0) <= vauxp0;
        aux_channel_n(0) <= vauxn0;

        aux_channel_p(1) <= vauxp1;
        aux_channel_n(1) <= vauxn1;

        aux_channel_p(2) <= '0';
        aux_channel_n(2) <= '0';

        aux_channel_p(3) <= '0';
        aux_channel_n(3) <= '0';

        aux_channel_p(4) <= '0';
        aux_channel_n(4) <= '0';

        aux_channel_p(5) <= '0';
        aux_channel_n(5) <= '0';

        aux_channel_p(6) <= '0';
        aux_channel_n(6) <= '0';

        aux_channel_p(7) <= '0';
        aux_channel_n(7) <= '0';

        aux_channel_p(8) <= vauxp8;
        aux_channel_n(8) <= vauxn8;

        aux_channel_p(9) <= '0';
        aux_channel_n(9) <= '0';

        aux_channel_p(10) <= '0';
        aux_channel_n(10) <= '0';

        aux_channel_p(11) <= '0';
        aux_channel_n(11) <= '0';

        aux_channel_p(12) <= '0';
        aux_channel_n(12) <= '0';

        aux_channel_p(13) <= '0';
        aux_channel_n(13) <= '0';

        aux_channel_p(14) <= '0';
        aux_channel_n(14) <= '0';

        aux_channel_p(15) <= '0';
        aux_channel_n(15) <= '0';

 XADC_INST : XADC
     generic map(
        INIT_40 => X"0000", -- config reg 0
        INIT_41 => X"20A0", -- config reg 1
        INIT_42 => X"0400", -- config reg 2
        INIT_48 => X"4700", -- Sequencer channel selection
        INIT_49 => X"0103", -- Sequencer channel selection
        INIT_4A => X"4700", -- Sequencer Average selection
        INIT_4B => X"0103", -- Sequencer Average selection
        INIT_4C => X"0000", -- Sequencer Bipolar selection
        INIT_4D => X"0000", -- Sequencer Bipolar selection
        INIT_4E => X"0000", -- Sequencer Acq time selection
        INIT_4F => X"0000", -- Sequencer Acq time selection
        INIT_50 => X"B5ED", -- Temp alarm trigger
        INIT_51 => X"57E4", -- Vccint upper alarm limit
        INIT_52 => X"A147", -- Vccaux upper alarm limit
        INIT_53 => X"CA33",  -- Temp alarm OT upper
        INIT_54 => X"A93A", -- Temp alarm reset
        INIT_55 => X"52C6", -- Vccint lower alarm limit
        INIT_56 => X"9555", -- Vccaux lower alarm limit
        INIT_57 => X"AE4E",  -- Temp alarm OT reset
        INIT_58 => X"5999",  -- Vccbram upper alarm limit
        INIT_5C => X"5111",  -- Vccbram lower alarm limit
        SIM_DEVICE => "7SERIES",
        SIM_MONITOR_FILE => "design.txt"
        )

port map (
        CONVST              => '0',
        CONVSTCLK           => '0',
        DADDR               => daddr_C(6 downto 0),            --: in (6 downto 0)
        DCLK                => m_axis_aclk,         --: in
        DEN                 => den_C,         --: in
        DI                  => di_C,               --: in (15 downto 0)
        DWE                 => dwe_C,              --: in
        RESET               => sysmon_hard_block_reset,  --: in
        VAUXN(15 downto 0)  => aux_channel_n(15 downto 0),
        VAUXP(15 downto 0)  => aux_channel_p(15 downto 0),
        ALM                 => alm_i,
        BUSY                => busy_i,             --: out
        CHANNEL             => channel_i,          --: out (4 downto 0)
        DO                  => do_C,               --: out (15 downto 0)
        DRDY                => drdy_C,             --: out
        EOC                 => eoc_i,              --: out
        EOS                 => eos_i,              --: out
        JTAGLOCKED          => jtaglocked_i,       --: out
        OT                  => ot_i,               --: out
        VN                  => vn_in,
        VP                  => vp_in
         );



end architecture imp;
--------------------------------------------------------------------------------
