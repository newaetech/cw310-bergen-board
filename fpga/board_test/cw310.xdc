# default unless otherwise specified:
#set_property IOSTANDARD LVCMOS33 [get_ports *]

# As per UG480, these pins don't actually need to be declared.
# Leaving this here so that they don't accidentally get assigned to something else.
#set_property -dict { PACKAGE_PIN C16   IOSTANDARD LVCMOS33 } [get_ports { vauxp0 }]
#set_property -dict { PACKAGE_PIN B16   IOSTANDARD LVCMOS33 } [get_ports { vauxn0 }]
#set_property -dict { PACKAGE_PIN B17   IOSTANDARD LVCMOS33 } [get_ports { vauxp1 }]
#set_property -dict { PACKAGE_PIN A17   IOSTANDARD LVCMOS33 } [get_ports { vauxn1 }]
#set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVCMOS33 } [get_ports { vauxp8 }]
#set_property -dict { PACKAGE_PIN A19   IOSTANDARD LVCMOS33 } [get_ports { vauxn8 }]

set_property -dict {PACKAGE_PIN Y23 IOSTANDARD LVCMOS33} [get_ports usb_clk]
set_property -dict {PACKAGE_PIN A23 IOSTANDARD LVCMOS33} [get_ports usb_trigger]

#set_property -dict { PACKAGE_PIN  Y25  IOSTANDARD   LVCMOS33 } [get_ports { USB_nALE }]; #IO_L10P_T1_12
set_property -dict {PACKAGE_PIN AA23 IOSTANDARD LVCMOS33} [get_ports USB_nCE]
set_property -dict {PACKAGE_PIN AC23 IOSTANDARD LVCMOS33} [get_ports USB_nRD]
set_property -dict {PACKAGE_PIN AA25 IOSTANDARD LVCMOS33} [get_ports USB_nWR]
set_property -dict {PACKAGE_PIN AC26 IOSTANDARD LVCMOS33} [get_ports {USB_A[0]}]
set_property -dict {PACKAGE_PIN AD26 IOSTANDARD LVCMOS33} [get_ports {USB_A[1]}]
set_property -dict {PACKAGE_PIN AD25 IOSTANDARD LVCMOS33} [get_ports {USB_A[2]}]
set_property -dict {PACKAGE_PIN AE26 IOSTANDARD LVCMOS33} [get_ports {USB_A[3]}]
set_property -dict {PACKAGE_PIN AB24 IOSTANDARD LVCMOS33} [get_ports {USB_A[4]}]
set_property -dict {PACKAGE_PIN AC24 IOSTANDARD LVCMOS33} [get_ports {USB_A[5]}]
set_property -dict {PACKAGE_PIN AD24 IOSTANDARD LVCMOS33} [get_ports {USB_A[6]}]
set_property -dict {PACKAGE_PIN AD23 IOSTANDARD LVCMOS33} [get_ports {USB_A[7]}]
set_property -dict {PACKAGE_PIN AB26 IOSTANDARD LVCMOS33} [get_ports {USB_A[8]}]
set_property -dict {PACKAGE_PIN AB25 IOSTANDARD LVCMOS33} [get_ports {USB_A[9]}]
set_property -dict {PACKAGE_PIN W23 IOSTANDARD LVCMOS33} [get_ports {USB_A[10]}]
set_property -dict {PACKAGE_PIN V23 IOSTANDARD LVCMOS33} [get_ports {USB_A[11]}]
set_property -dict {PACKAGE_PIN Y21 IOSTANDARD LVCMOS33} [get_ports {USB_A[12]}]
set_property -dict {PACKAGE_PIN U24 IOSTANDARD LVCMOS33} [get_ports {USB_A[13]}]
set_property -dict {PACKAGE_PIN U22 IOSTANDARD LVCMOS33} [get_ports {USB_A[14]}]
set_property -dict {PACKAGE_PIN V22 IOSTANDARD LVCMOS33} [get_ports {USB_A[15]}]
set_property -dict {PACKAGE_PIN U21 IOSTANDARD LVCMOS33} [get_ports {USB_A[16]}]
set_property -dict {PACKAGE_PIN V21 IOSTANDARD LVCMOS33} [get_ports {USB_A[17]}]
set_property -dict {PACKAGE_PIN W21 IOSTANDARD LVCMOS33} [get_ports {USB_A[18]}]
set_property -dict {PACKAGE_PIN W20 IOSTANDARD LVCMOS33} [get_ports {USB_A[19]}]
set_property -dict {PACKAGE_PIN U25 IOSTANDARD LVCMOS33} [get_ports {USB_D[0]}]
set_property -dict {PACKAGE_PIN U26 IOSTANDARD LVCMOS33} [get_ports {USB_D[1]}]
set_property -dict {PACKAGE_PIN AC21 IOSTANDARD LVCMOS33} [get_ports {USB_D[2]}]
set_property -dict {PACKAGE_PIN V24 IOSTANDARD LVCMOS33} [get_ports {USB_D[3]}]
set_property -dict {PACKAGE_PIN V26 IOSTANDARD LVCMOS33} [get_ports {USB_D[4]}]
set_property -dict {PACKAGE_PIN W26 IOSTANDARD LVCMOS33} [get_ports {USB_D[5]}]
set_property -dict {PACKAGE_PIN W25 IOSTANDARD LVCMOS33} [get_ports {USB_D[6]}]
set_property -dict {PACKAGE_PIN Y26 IOSTANDARD LVCMOS33} [get_ports {USB_D[7]}]


set_property -dict {PACKAGE_PIN M26 IOSTANDARD LVCMOS33} [get_ports {USRLED[0]}]
set_property -dict {PACKAGE_PIN M25 IOSTANDARD LVCMOS33} [get_ports {USRLED[1]}]
set_property -dict {PACKAGE_PIN M24 IOSTANDARD LVCMOS33} [get_ports {USRLED[2]}]
set_property -dict {PACKAGE_PIN M19 IOSTANDARD LVCMOS33} [get_ports {USRLED[3]}]
set_property -dict {PACKAGE_PIN L25 IOSTANDARD LVCMOS33} [get_ports {USRLED[4]}]
set_property -dict {PACKAGE_PIN K26 IOSTANDARD LVCMOS33} [get_ports {USRLED[5]}]
set_property -dict {PACKAGE_PIN L24 IOSTANDARD LVCMOS33} [get_ports {USRLED[6]}]
set_property -dict {PACKAGE_PIN K25 IOSTANDARD LVCMOS33} [get_ports {USRLED[7]}]


set_property -dict {PACKAGE_PIN U9 IOSTANDARD LVCMOS18} [get_ports {USRDIP[0]}]
set_property -dict {PACKAGE_PIN V7 IOSTANDARD LVCMOS18} [get_ports {USRDIP[1]}]
set_property -dict {PACKAGE_PIN V8 IOSTANDARD LVCMOS18} [get_ports {USRDIP[2]}]
set_property -dict {PACKAGE_PIN W9 IOSTANDARD LVCMOS18} [get_ports {USRDIP[3]}]
set_property -dict {PACKAGE_PIN V9 IOSTANDARD LVCMOS18} [get_ports {USRDIP[4]}]
set_property -dict {PACKAGE_PIN W8 IOSTANDARD LVCMOS18} [get_ports {USRDIP[5]}]
set_property -dict {PACKAGE_PIN W10 IOSTANDARD LVCMOS18} [get_ports {USRDIP[6]}]
set_property -dict {PACKAGE_PIN V11 IOSTANDARD LVCMOS18} [get_ports {USRDIP[7]}]


#set_property -dict { PACKAGE_PIN  Y11  IOSTANDARD   LVCMOS18 } [get_ports { USRSW0 }]; #IO_L5P_T0_33
#set_property -dict { PACKAGE_PIN  Y10  IOSTANDARD   LVCMOS18 } [get_ports { USRSW1 }]; #IO_L5N_T0_33
set_property -dict {PACKAGE_PIN Y7 IOSTANDARD LVCMOS18} [get_ports USRSW2]


set_property -dict {PACKAGE_PIN AB21 IOSTANDARD LVCMOS33} [get_ports CWIO_HS1]
set_property -dict {PACKAGE_PIN Y22 IOSTANDARD LVCMOS33} [get_ports CWIO_HS2]
#set_property -dict { PACKAGE_PIN AE25  IOSTANDARD   LVCMOS33 } [get_ports { CWIO_IO1 }]; #IO_L23N_T3_12
#set_property -dict { PACKAGE_PIN AF25  IOSTANDARD   LVCMOS33 } [get_ports { CWIO_IO2 }]; #IO_L20N_T3_12
#set_property -dict { PACKAGE_PIN AF23  IOSTANDARD   LVCMOS33 } [get_ports { CWIO_IO3 }]; #IO_L22N_T3_12
set_property -dict {PACKAGE_PIN AF24 IOSTANDARD LVCMOS33} [get_ports CWIO_IO4]
#set_property -dict { PACKAGE_PIN AE21  IOSTANDARD   LVCMOS33 } [get_ports { CWIO_MISO }]; #IO_L19N_T3_VREF_12
#set_property -dict { PACKAGE_PIN AF22  IOSTANDARD   LVCMOS33 } [get_ports { CWIO_MOSI }]; #IO_L24N_T3_12
#set_property -dict { PACKAGE_PIN  Y20  IOSTANDARD   LVCMOS33 } [get_ports { CWIO_RST }]; #IO_25_12
#set_property -dict { PACKAGE_PIN AD21  IOSTANDARD   LVCMOS33 } [get_ports { CWIO_TPDIC }]; #IO_L19P_T3_12
#set_property -dict { PACKAGE_PIN AE23  IOSTANDARD   LVCMOS33 } [get_ports { CWIO_TPDID }]; #IO_L22P_T3_12
#set_property -dict { PACKAGE_PIN AE22  IOSTANDARD   LVCMOS33 } [get_ports { CWIO_TSCK }]; #IO_L24P_T3_12


set_property -dict {PACKAGE_PIN R22 IOSTANDARD LVCMOS33} [get_ports PLL_CLK1]
#set_property -dict { PACKAGE_PIN  N21  IOSTANDARD   LVCMOS33 } [get_ports { PLL_CLK2 }]; #IO_L12P_T1_MRCC_13

set_property -dict {PACKAGE_PIN AB7 IOSTANDARD LVCMOS18} [get_ports LVDS_XO_200M_ENA]
set_property -dict {PACKAGE_PIN N24 IOSTANDARD LVCMOS33} [get_ports vddr_enable]
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33} [get_ports vddr_pgood]

set_property -dict {PACKAGE_PIN AD9 IOSTANDARD LVDS} [get_ports SYSCLK_N]
set_property -dict {PACKAGE_PIN AC9 IOSTANDARD LVDS} [get_ports SYSCLK_P]


#####
# SDRAM - 3.3V Only
#####

set_property -dict {PACKAGE_PIN F23 IOSTANDARD LVCMOS33} [get_ports {SRAM_A[0]}]
set_property -dict {PACKAGE_PIN F25 IOSTANDARD LVCMOS33} [get_ports {SRAM_A[1]}]
set_property -dict {PACKAGE_PIN G22 IOSTANDARD LVCMOS33} [get_ports {SRAM_A[10]}]
set_property -dict {PACKAGE_PIN F24 IOSTANDARD LVCMOS33} [get_ports {SRAM_A[11]}]
set_property -dict {PACKAGE_PIN H21 IOSTANDARD LVCMOS33} [get_ports {SRAM_A[12]}]
set_property -dict {PACKAGE_PIN E23 IOSTANDARD LVCMOS33} [get_ports {SRAM_A[13]}]
set_property -dict {PACKAGE_PIN H22 IOSTANDARD LVCMOS33} [get_ports {SRAM_A[14]}]
set_property -dict {PACKAGE_PIN E22 IOSTANDARD LVCMOS33} [get_ports {SRAM_A[15]}]
set_property -dict {PACKAGE_PIN H23 IOSTANDARD LVCMOS33} [get_ports {SRAM_A[16]}]
set_property -dict {PACKAGE_PIN H24 IOSTANDARD LVCMOS33} [get_ports {SRAM_A[17]}]
set_property -dict {PACKAGE_PIN J26 IOSTANDARD LVCMOS33} [get_ports {SRAM_A[18]}]
set_property -dict {PACKAGE_PIN H26 IOSTANDARD LVCMOS33} [get_ports {SRAM_A[19]}]
set_property -dict {PACKAGE_PIN G24 IOSTANDARD LVCMOS33} [get_ports {SRAM_A[2]}]
#set_property -dict { PACKAGE_PIN  L23  IOSTANDARD   LVCMOS33 } [get_ports { SRAM_A[20] }]; #IO_25_14
set_property -dict {PACKAGE_PIN F22 IOSTANDARD LVCMOS33} [get_ports {SRAM_A[3]}]
set_property -dict {PACKAGE_PIN G21 IOSTANDARD LVCMOS33} [get_ports {SRAM_A[4]}]
set_property -dict {PACKAGE_PIN B20 IOSTANDARD LVCMOS33} [get_ports {SRAM_A[5]}]
set_property -dict {PACKAGE_PIN A20 IOSTANDARD LVCMOS33} [get_ports {SRAM_A[6]}]
set_property -dict {PACKAGE_PIN K22 IOSTANDARD LVCMOS33} [get_ports {SRAM_A[7]}]
set_property -dict {PACKAGE_PIN B21 IOSTANDARD LVCMOS33} [get_ports {SRAM_A[8]}]
set_property -dict {PACKAGE_PIN E21 IOSTANDARD LVCMOS33} [get_ports {SRAM_A[9]}]
set_property -dict {PACKAGE_PIN J21 IOSTANDARD LVCMOS33} [get_ports SRAM_CE2]
set_property -dict {PACKAGE_PIN G26 IOSTANDARD LVCMOS33} [get_ports SRAM_CEn]
set_property -dict {PACKAGE_PIN J24 IOSTANDARD LVCMOS33} [get_ports {SRAM_DQ[0]}]
set_property -dict {PACKAGE_PIN E26 IOSTANDARD LVCMOS33} [get_ports {SRAM_DQ[1]}]
set_property -dict {PACKAGE_PIN K23 IOSTANDARD LVCMOS33} [get_ports {SRAM_DQ[2]}]
set_property -dict {PACKAGE_PIN D21 IOSTANDARD LVCMOS33} [get_ports {SRAM_DQ[3]}]
set_property -dict {PACKAGE_PIN C24 IOSTANDARD LVCMOS33} [get_ports {SRAM_DQ[4]}]
set_property -dict {PACKAGE_PIN D24 IOSTANDARD LVCMOS33} [get_ports {SRAM_DQ[5]}]
set_property -dict {PACKAGE_PIN D23 IOSTANDARD LVCMOS33} [get_ports {SRAM_DQ[6]}]
set_property -dict {PACKAGE_PIN C22 IOSTANDARD LVCMOS33} [get_ports {SRAM_DQ[7]}]
set_property -dict {PACKAGE_PIN C21 IOSTANDARD LVCMOS33} [get_ports SRAM_OEn]
set_property -dict {PACKAGE_PIN J23 IOSTANDARD LVCMOS33} [get_ports SRAM_WEn]


# clocks:
create_clock -period 10.000 -name usb_clk -waveform {0.000 5.000} [get_nets usb_clk]
create_clock -period 10.000 -name CWIO_HS2 -waveform {0.000 5.000} [get_nets CWIO_HS2]
create_clock -period 10.000 -name PLL_CLK1 -waveform {0.000 5.000} [get_nets PLL_CLK1]

set_clock_groups -asynchronous -group [get_clocks usb_clk] -group [get_clocks clk_pll_i]

# both input clocks have same properties so there is no point in doing timing analysis for both:
set_case_analysis 1 [get_pins U_clocks/CCLK_MUX/S]

# No spec for these, seems sensible:
set_input_delay -clock usb_clk -add_delay 2.000 [get_ports USB_A]
set_input_delay -clock usb_clk -add_delay 2.000 [get_ports USB_D]
set_input_delay -clock usb_clk -add_delay 2.000 [get_ports usb_trigger]
set_input_delay -clock usb_clk -add_delay 2.000 [get_ports USB_nCE]
set_input_delay -clock usb_clk -add_delay 2.000 [get_ports USB_nRD]
set_input_delay -clock usb_clk -add_delay 2.000 [get_ports USB_nWR]

set_input_delay -clock usb_clk -add_delay 0.000 [get_ports USRDIP]
set_input_delay -clock [get_clocks usb_clk] -add_delay 0.500 [get_ports USRSW2]
set_output_delay -clock usb_clk 0.000 [get_ports USRLED]
set_output_delay -clock usb_clk 0.000 [get_ports USB_D]
set_output_delay -clock usb_clk 0.000 [get_ports CWIO_IO4]
set_output_delay -clock usb_clk 0.000 [get_ports CWIO_HS1]
set_false_path -from [get_ports USRDIP]
set_false_path -from [get_ports USRSW2]
set_false_path -to [get_ports USRLED]
set_false_path -to [get_ports USB_D]
set_false_path -to [get_ports CWIO_IO4]
set_false_path -to [get_ports CWIO_HS1]

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

set_property BITSTREAM.CONFIG.USR_ACCESS TIMESTAMP [current_design]

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets usb_clk_buf]
