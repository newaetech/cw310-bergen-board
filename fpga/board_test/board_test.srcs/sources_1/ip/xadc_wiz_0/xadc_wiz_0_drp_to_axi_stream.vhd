
-- file: xadc_wiz_0_drp_to_axi_stream.vhd
-- (c) Copyright 2009 - 2013 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.

library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;

Library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity  drp_to_axi4stream is
  port (
  m_axis_reset    : in  std_logic;                      -- Active High Reset 
  s_axis_aclk     : in  std_logic;                      -- Async Clock input from Slave   
  m_axis_aclk     : in  std_logic;                      -- Clock input of Master   
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
end drp_to_axi4stream;

architecture beh of drp_to_axi4stream is

  type fsmstate_stream is (RD_EN_CTRL_REG_41, RD_CTRL_REG_41, WAIT_SEQ_S_CH, WAIT_IND_ADC, WAIT_MODE_CHANGE, WAIT_SIM_SAMP, RD_A_REG, RD_B_REG_CMD, RD_B_REG, RD_EN_CTRL_REG_TEMP, RD_CTRL_REG_TEMP);
                             
  signal state : fsmstate_stream;
  type ram_type is array (1 downto 0) of std_logic_vector (15 downto 0);
  signal RAM : ram_type;
  signal dout_fifo_data : std_logic_vector(31 downto 0);
  signal dout_fifo_tid : std_logic_vector(31 downto 0);
  signal din_fifo_data : std_logic_vector(31 downto 0);
  signal din_fifo_tid : std_logic_vector(31 downto 0);
  signal zeros_8 : std_logic_vector(7 downto 0);
  signal zeros_16 : std_logic_vector(15 downto 0);
  signal fifo_empty : std_logic := '0';
  signal almost_full  : std_logic := '0';
  signal timer_cntr : std_logic_vector(15 downto 0);
  signal channel_id : std_logic_vector(7 downto 0);
  signal wren_fifo  : std_logic := '0';
  signal rden_fifo  : std_logic := '0';
  signal valid_data_wren  : std_logic := '0';
  signal drp_rdwr_status  : std_logic := '0';

begin

  zeros_8 <= (others => '0'); 
  zeros_16 <= (others => '0'); 

  -- Generation of DRP signals using EOC, EOS and channel details

  m_axis_tdata <= dout_fifo_data(15 downto 0);
  m_axis_tvalid <= not fifo_empty;
  m_axis_tid <= dout_fifo_tid(4 downto 0);

  din_fifo_data <=  zeros_16 & do_i;
  wren_fifo <= drdy_i and valid_data_wren;
  rden_fifo <= m_axis_tready and (not fifo_empty);
  daddr_o <= channel_id;
  din_fifo_tid <=  zeros_16 & zeros_8 & channel_id;
  di_o <= (others => '0');

  drp_fsm: process (m_axis_aclk, m_axis_reset)
  begin
    if (m_axis_reset = '1') then
      state <= WAIT_MODE_CHANGE;
      channel_id <= (others => '0');
      dwe_o <= '0';
      den_o <= '0';
      busy_o <= '0';
      valid_data_wren <= '0';
      mode_change_sig_reset <= '0';
      drp_rdwr_status <= '0';
      temp_out <= (others => '0');
    elsif m_axis_aclk'event and m_axis_aclk = '1' then

      if eoc_in = '1' and almost_full = '0' then 
        drp_rdwr_status <= '1';
      elsif drdy_i  = '1' then
        drp_rdwr_status <= '0';
      end if;

      case state is
         when WAIT_MODE_CHANGE  =>
                                    valid_data_wren <= '0';
                                    busy_o <= '0';
                                    mode_change_sig_reset <= '1';
                                    state <= RD_EN_CTRL_REG_41;
                                    den_o <= '0';
         when RD_EN_CTRL_REG_41 =>
                                    state <= RD_CTRL_REG_41;
                                    channel_id <= X"41";
                                    dwe_o <= '0';
                                    den_o <= '1';
                                    mode_change_sig_reset <= '0';
         when RD_CTRL_REG_41    =>
                                    den_o <= '0';
                                    if drdy_i  = '1' then
                                       if do_i(15 downto 14) = "01" then
                                         state <= WAIT_SIM_SAMP;
                                       elsif do_i(15 downto 14) = "10" then 
                                         state <= WAIT_IND_ADC;
                                       else
                                         state <= WAIT_SEQ_S_CH;
                                       end if;
                                       valid_data_wren <= '1';

                                    end if;
         when WAIT_SEQ_S_CH   =>
                                  den_o <= eoc_in and (not almost_full);
                                  channel_id <= "000" & channel_in; 
                                  busy_o <= '0';
                                  dwe_o <= '0';
                                  if mode_change = '1' then
                                     if drdy_i  = '1' then
                                        state <= WAIT_MODE_CHANGE;
                                     end if;
                                  elsif eoc_in = '0' and drp_rdwr_status = '0' and temp_bus_update = '1' and timer_cntr >= X"0000" and timer_cntr <= X"0008" then
                                        state <= RD_EN_CTRL_REG_TEMP;
                                  end if;
         when WAIT_IND_ADC   =>
                                  den_o <= eoc_in and (not almost_full);
                                  channel_id <= "000" & channel_in; 
                                  busy_o <= '0';
                                  dwe_o <= '0';
                                  if mode_change = '1' then
                                     if drdy_i  = '1' then
                                        state <= WAIT_MODE_CHANGE;
                                     end if;
                                  elsif eoc_in = '0' and drp_rdwr_status = '0' and temp_bus_update = '1' and timer_cntr >= X"0000" and timer_cntr <= X"0008" then
                                    state <= RD_EN_CTRL_REG_TEMP;
                                  end if;
         when WAIT_SIM_SAMP =>
                                den_o <= eoc_in and (not almost_full);
                                channel_id <= "000" & channel_in; 
                                dwe_o <= '0';
                                if eoc_in = '1'  and channel_in >= "10000"  and channel_in <= "11111" then
                                  busy_o <= '1';
                                  state <= RD_A_REG;
                                elsif mode_change = '1' then
                                  if drdy_i  = '1' then
                                     state <= WAIT_MODE_CHANGE;
                                  end if;
                                elsif eoc_in = '0' and drp_rdwr_status = '0' and temp_bus_update = '1' and timer_cntr >= X"0000" and timer_cntr <= X"0008" then
                                    state <= RD_EN_CTRL_REG_TEMP;
                                end if;
         when RD_A_REG      =>
                                if drdy_i  = '1' then
                                  state <= RD_B_REG_CMD;
                                end if;
                                den_o <= '0';
         when RD_B_REG_CMD  =>
                                state <= RD_B_REG;
                                channel_id <= "000" & (channel_in + "01000"); 
                                dwe_o <= '0';
                                den_o <= '1';
         when RD_B_REG      =>
                                if drdy_i  = '1' then
                                   if mode_change = '1' then
                                      state <= WAIT_MODE_CHANGE;
                                   else
                                      state <= WAIT_SIM_SAMP;
                                   end if;
                                end if;
                                den_o <= '0';
                                busy_o <= '0';
         when RD_EN_CTRL_REG_TEMP  =>
                                       valid_data_wren <= '0';
                                       state <= RD_CTRL_REG_TEMP;
                                       channel_id <= X"00";
                                       dwe_o <= '0';
                                       den_o <= '1';
         when RD_CTRL_REG_TEMP     =>
                                       den_o <= '0';
                                       if drdy_i  = '1' then
                                          state <= WAIT_MODE_CHANGE;
                                          temp_out <= do_i(15 downto 4);
                                       end if;
          when others       => Null;
      end case;
    end if;
  end process;


  timer_cntr_proc: process (m_axis_aclk, m_axis_reset)
  begin
    if (m_axis_reset = '1') then
       timer_cntr <= (others => '0');
    elsif m_axis_aclk'event and m_axis_aclk = '1' then
       if timer_cntr = X"0000" then
          timer_cntr <= wait_cycle;
       else
          timer_cntr <= timer_cntr - 1;
       end if;
    end if;
  end process;

  -- FIFO18E1: 18Kb FIFO (First-In-First-Out) Block RAM Memory
  -- 7 Series
  -- Xilinx HDL Libraries Guide, version 14.1
  FIFO18E1_inst_data : FIFO18E1
  generic map (
    ALMOST_EMPTY_OFFSET => X"0006", -- Sets the almost empty threshold
    ALMOST_FULL_OFFSET => X"03F9", -- Sets almost full threshold
    DATA_WIDTH => 18, -- Sets data width to 4-36
    DO_REG => 1, -- Enable output register (1-0) Must be 1 if EN_SYN = FALSE
    EN_SYN => FALSE, -- Specifies FIFO as dual-clock (FALSE) or Synchronous (TRUE)
    FIFO_MODE => "FIFO18", -- Sets mode to FIFO18 or FIFO18_36
    FIRST_WORD_FALL_THROUGH => TRUE, -- Sets the FIFO FWFT to FALSE, TRUE
    INIT => X"000000000", -- Initial values on output port
    SIM_DEVICE => "7SERIES", -- Must be set to "7SERIES" for simulation behavior
    SRVAL => X"000000000" -- Set/Reset value for output port
  )
  port map (
    -- Read Data: 32-bit (each) output: Read output data
    DO => dout_fifo_data, -- 32-bit output: Data output
    DOP => open, -- 4-bit output: Parity data output
    -- Status: 1-bit (each) output: Flags and other FIFO status outputs
    ALMOSTEMPTY => open, -- 1-bit output: Almost empty flag
    ALMOSTFULL => almost_full, -- 1-bit output: Almost full flag
    EMPTY => fifo_empty, -- 1-bit output: Empty flag
    FULL => open, -- 1-bit output: Full flag
    RDCOUNT => open, -- 12-bit output: Read count
    RDERR => open, -- 1-bit output: Read error
    WRCOUNT => open, -- 12-bit output: Write count
    WRERR => open, -- 1-bit output: Write error occured.
    -- Read Control Signals: 1-bit (each) input: Read clock, enable and reset input signals
    RDCLK => s_axis_aclk, -- 1-bit input: Read clock
    RDEN => rden_fifo, -- 1-bit input: Read enable
    REGCE => '1', -- 1-bit input: Clock enable
    RST => m_axis_reset, -- 1-bit input: Asyncronous Reset
    RSTREG => '0', --m_axis_reset, -- 1-bit input: Output register set/reset
    -- Write Control Signals: 1-bit (each) input: Write clock and enable input signals
    WRCLK => m_axis_aclk, -- 1-bit input: Write clock
    WREN => wren_fifo, -- 1-bit input: Write enable
    -- Write Data: 32-bit (each) input: Write input data
    DI => din_fifo_data, -- 32-bit input: Data input
    DIP => "0000" -- 4-bit input: Parity input
  );
  -- End of FIFO18E1_inst_data instantiation

  FIFO18E1_inst_tid : FIFO18E1
  generic map (
    ALMOST_EMPTY_OFFSET => X"0006", -- Sets the almost empty threshold
    ALMOST_FULL_OFFSET => X"03F9", -- Sets almost full threshold
    DATA_WIDTH => 18, -- Sets data width to 4-36
    DO_REG => 1, -- Enable output register (1-0) Must be 1 if EN_SYN = FALSE
    EN_SYN => FALSE, -- Specifies FIFO as dual-clock (FALSE) or Synchronous (TRUE)
    FIFO_MODE => "FIFO18", -- Sets mode to FIFO18 or FIFO18_36
    FIRST_WORD_FALL_THROUGH => TRUE, -- Sets the FIFO FWFT to FALSE, TRUE
    INIT => X"000000000", -- Initial values on output port
    SIM_DEVICE => "7SERIES", -- Must be set to "7SERIES" for simulation behavior
    SRVAL => X"000000000" -- Set/Reset value for output port
  )
  port map (
    -- Read Data: 32-bit (each) output: Read output data
    DO => dout_fifo_tid, -- 32-bit output: Data output
    DOP => open, -- 4-bit output: Parity data output
    -- Status: 1-bit (each) output: Flags and other FIFO status outputs
    ALMOSTEMPTY => open, -- 1-bit output: Almost empty flag
    ALMOSTFULL => open, -- 1-bit output: Almost full flag
    EMPTY => open, -- 1-bit output: Empty flag
    FULL => open, -- 1-bit output: Full flag
    RDCOUNT => open, -- 12-bit output: Read count
    RDERR => open, -- 1-bit output: Read error
    WRCOUNT => open, -- 12-bit output: Write count
    WRERR => open, -- 1-bit output: Write error occured.
    -- Read Control Signals: 1-bit (each) input: Read clock, enable and reset input signals
    RDCLK => s_axis_aclk, -- 1-bit input: Read clock
    RDEN => rden_fifo, -- 1-bit input: Read enable
    REGCE => '1', -- 1-bit input: Clock enable
    RST => m_axis_reset, -- 1-bit input: Asyncronous Reset
    RSTREG => '0', --m_axis_reset, -- 1-bit input: Output register set/reset
    -- Write Control Signals: 1-bit (each) input: Write clock and enable input signals
    WRCLK => m_axis_aclk, -- 1-bit input: Write clock
    WREN => wren_fifo, -- 1-bit input: Write enable
    -- Write Data: 32-bit (each) input: Write input data
    DI => din_fifo_tid, -- 32-bit input: Data input
    DIP => "0000" -- 4-bit input: Parity input
  );
  -- End of FIFO18E1_inst_tid instantiation

end beh;



