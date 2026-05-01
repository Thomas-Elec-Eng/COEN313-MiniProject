## Clock signal
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports {clk}]; #IO_L12P_T1_MRCC_35 
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk}];
#set_property -dict { PACKAGE_PIN V10 IOSTANDARD LVCMOS33 } [get_ports {clk}];
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk]

## Buttons
set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [get_ports { start }]; #IO_L9P_T1_DQS_14
set_property -dict { PACKAGE_PIN P17 IOSTANDARD LVCMOS33 } [get_ports { gamereset }]; #IO_L12P_T1_MRCC_14

##Switches
set_property -dict { PACKAGE_PIN J15 IOSTANDARD LVCMOS33 } [get_ports { Switch_play4 }]; #IO_L24N_T3_RS0_15
set_property -dict { PACKAGE_PIN R17 IOSTANDARD LVCMOS33 } [get_ports { Switch_play3 }]; #IO_L12N_T1_MRCC_14
set_property -dict { PACKAGE_PIN T8 IOSTANDARD LVCMOS18 } [get_ports { Switch_play2 }]; #IO_L24N_T3_34
set_property -dict { PACKAGE_PIN H6 IOSTANDARD LVCMOS33 } [get_ports { Switch_play1 }]; #IO_L24P_T3_35

## LEDs
set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS33 } [get_ports { LED_play4 }]; #IO_L18P_T2_A24_15
set_property -dict { PACKAGE_PIN R18 IOSTANDARD LVCMOS33 } [get_ports { LED_play3 }]; #IO_L7P_T1_D09_14
set_property -dict { PACKAGE_PIN V16 IOSTANDARD LVCMOS33 } [get_ports { LED_play2 }]; #IO_L16N_T2_A15_D31_14
set_property -dict { PACKAGE_PIN V15 IOSTANDARD LVCMOS33 } [get_ports { LED_play1 }]; #IO_L16P_T2_CSI_B_14
set_property -dict { PACKAGE_PIN R11 IOSTANDARD LVCMOS33 } [get_ports { Green }]; 
set_property -dict { PACKAGE_PIN N15 IOSTANDARD LVCMOS33 } [get_ports { Red }]; 


##7 segment display
set_property -dict { PACKAGE_PIN T10 IOSTANDARD LVCMOS33 } [get_ports { ABCDEFGDP[7] }]; #IO_L24N_T3_A00_D16_14
set_property -dict { PACKAGE_PIN R10 IOSTANDARD LVCMOS33 } [get_ports { ABCDEFGDP[6] }]; #IO_25_14
set_property -dict { PACKAGE_PIN K16 IOSTANDARD LVCMOS33 } [get_ports { ABCDEFGDP[5] }]; #IO_25_15
set_property -dict { PACKAGE_PIN K13 IOSTANDARD LVCMOS33 } [get_ports { ABCDEFGDP[4] }]; #IO_L17P_T2_A26_15
set_property -dict { PACKAGE_PIN P15 IOSTANDARD LVCMOS33 } [get_ports { ABCDEFGDP[3] }]; #IO_L13P_T2_MRCC_14
set_property -dict { PACKAGE_PIN T11 IOSTANDARD LVCMOS33 } [get_ports { ABCDEFGDP[2] }]; #IO_L19P_T3_A10_D26_14
set_property -dict { PACKAGE_PIN L18 IOSTANDARD LVCMOS33 } [get_ports { ABCDEFGDP[1] }]; #IO_L4P_T0_D04_14
set_property -dict { PACKAGE_PIN H15 IOSTANDARD LVCMOS33 } [get_ports { ABCDEFGDP[0] }]; #IO_L19N_T3_A21_VREF_15
set_property -dict { PACKAGE_PIN J17 IOSTANDARD LVCMOS33 } [get_ports { Display_on[7] }]; #IO_L23P_T3_FOE_B_15
set_property -dict { PACKAGE_PIN J18 IOSTANDARD LVCMOS33 } [get_ports { Display_on[6] }]; #IO_L23N_T3_FWE_B_15
set_property -dict { PACKAGE_PIN T9 IOSTANDARD LVCMOS33 } [get_ports { Display_on[5] }]; #IO_L24P_T3_A01_D17_14
set_property -dict { PACKAGE_PIN J14 IOSTANDARD LVCMOS33 } [get_ports { Display_on[4] }]; #IO_L19P_T3_A22_15
set_property -dict { PACKAGE_PIN P14 IOSTANDARD LVCMOS33 } [get_ports { Display_on[3] }]; #IO_L8N_T1_D12_14
set_property -dict { PACKAGE_PIN T14 IOSTANDARD LVCMOS33 } [get_ports { Display_on[2] }]; #IO_L14P_T2_SRCC_14
set_property -dict { PACKAGE_PIN K2 IOSTANDARD LVCMOS33 } [get_ports { Display_on[1] }]; #IO_L23P_T3_35
set_property -dict { PACKAGE_PIN U13 IOSTANDARD LVCMOS33 } [get_ports { Display_on[0] }]; #IO_L23N_T3_A02_D18_14