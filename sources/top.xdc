set_property PACKAGE_PIN U3  [get_ports {gt_rxn_in[0]}]; # Bank 230  - MGTYRXN0_230
set_property PACKAGE_PIN U4  [get_ports {gt_rxp_in[0]}]; # Bank 230  - MGTYRXP0_230
set_property PACKAGE_PIN T1  [get_ports {gt_rxn_in[1]}]; # Bank 230  - MGTYRXN1_230
set_property PACKAGE_PIN T2  [get_ports {gt_rxp_in[1]}]; # Bank 230  - MGTYRXP1_230
set_property PACKAGE_PIN R3  [get_ports {gt_rxn_in[2]}]; # Bank 230  - MGTYRXN2_230
set_property PACKAGE_PIN R4  [get_ports {gt_rxp_in[2]}]; # Bank 230  - MGTYRXP2_230
set_property PACKAGE_PIN P1  [get_ports {gt_rxn_in[3]}]; # Bank 230  - MGTYRXN3_230
set_property PACKAGE_PIN P2  [get_ports {gt_rxp_in[3]}]; # Bank 230  - MGTYRXP3_230
set_property PACKAGE_PIN U8  [get_ports {gt_txn_out[0]}]; # Bank 230  - MGTYTXN0_230
set_property PACKAGE_PIN U9  [get_ports {gt_txp_out[0]}]; # Bank 230  - MGTYTXP0_230
set_property PACKAGE_PIN T6  [get_ports {gt_txn_out[1]}]; # Bank 230  - MGTYTXN1_230
set_property PACKAGE_PIN T7  [get_ports {gt_txp_out[1]}]; # Bank 230  - MGTYTXP1_230
set_property PACKAGE_PIN R8  [get_ports {gt_txn_out[2]}]; # Bank 230  - MGTYTXN2_230
set_property PACKAGE_PIN R9  [get_ports {gt_txp_out[2]}]; # Bank 230  - MGTYTXP2_230
set_property PACKAGE_PIN P6  [get_ports {gt_txn_out[3]}]; # Bank 230  - MGTYTXN3_230
set_property PACKAGE_PIN P7  [get_ports {gt_txp_out[3]}]; # Bank 230  - MGTYTXP3_230

set_property PACKAGE_PIN BC21 [get_ports QSFP28_0_ACTIVITY_LED]
set_property IOSTANDARD LVCMOS12 [get_ports QSFP28_0_ACTIVITY_LED]
set_property PACKAGE_PIN BB21 [get_ports QSFP28_0_STATUS_LEDG]
set_property IOSTANDARD LVCMOS12 [get_ports QSFP28_0_STATUS_LEDG]
set_property PACKAGE_PIN BA20 [get_ports QSFP28_0_STATUS_LEDY]
set_property IOSTANDARD LVCMOS12 [get_ports QSFP28_0_STATUS_LEDY]

set_property PACKAGE_PIN T10 [get_ports gt_refclk_n]; # MGT_SI570_CLOCK0_P (156.25MHz)
set_property PACKAGE_PIN T11 [get_ports gt_refclk_p]; # MGT_SI570_CLOCK0_N (156.25MHz)

set_property PACKAGE_PIN AW20 [get_ports SYSCLK3_P]
set_property IOSTANDARD LVDS [get_ports SYSCLK3_P]
set_property PACKAGE_PIN AW19 [get_ports SYSCLK3_N]
set_property IOSTANDARD LVDS [get_ports SYSCLK3_N]
## set_property DQS_BIAS TRUE [get_ports SYSCLK3_P]
# create_clock -period 10.000 -name sysclk3 [get_ports "SYSCLK3_P"]

set_false_path -from [get_clocks -of_objects [get_pins {*/xxv_ethernet_0_i/inst/i_xxv_ethernet_0_gt/inst/gen_gtwizard_gtye4_top.xxv_ethernet_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[35].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]] -to [get_clocks -of_objects [get_pins clk_wiz_0_i/inst/mmcme4_adv_inst/CLKOUT0]]
set_false_path -from [get_clocks -of_objects [get_pins {*/xxv_ethernet_0_i/inst/i_xxv_ethernet_0_gt_1/inst/gen_gtwizard_gtye4_top.xxv_ethernet_0_gt_1_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[35].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]] -to [get_clocks -of_objects [get_pins clk_wiz_0_i/inst/mmcme4_adv_inst/CLKOUT0]]
set_false_path -from [get_clocks -of_objects [get_pins {*/xxv_ethernet_0_i/inst/i_xxv_ethernet_0_gt_2/inst/gen_gtwizard_gtye4_top.xxv_ethernet_0_gt_2_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[35].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]] -to [get_clocks -of_objects [get_pins clk_wiz_0_i/inst/mmcme4_adv_inst/CLKOUT0]]
set_false_path -from [get_clocks -of_objects [get_pins {*/xxv_ethernet_0_i/inst/i_xxv_ethernet_0_gt_3/inst/gen_gtwizard_gtye4_top.xxv_ethernet_0_gt_3_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[35].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]] -to [get_clocks -of_objects [get_pins clk_wiz_0_i/inst/mmcme4_adv_inst/CLKOUT0]]

set_false_path -from [get_clocks -of_objects [get_pins {*/xxv_ethernet_0_i/inst/i_xxv_ethernet_0_gt/inst/gen_gtwizard_gtye4_top.xxv_ethernet_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[35].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] -to [get_clocks -of_objects [get_pins {*/xxv_ethernet_0_i/inst/i_xxv_ethernet_0_gt/inst/gen_gtwizard_gtye4_top.xxv_ethernet_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[35].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]]
set_false_path -from [get_clocks -of_objects [get_pins {*/xxv_ethernet_0_i/inst/i_xxv_ethernet_0_gt_1/inst/gen_gtwizard_gtye4_top.xxv_ethernet_0_gt_1_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[35].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] -to [get_clocks -of_objects [get_pins {*/xxv_ethernet_0_i/inst/i_xxv_ethernet_0_gt_1/inst/gen_gtwizard_gtye4_top.xxv_ethernet_0_gt_1_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[35].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]]
set_false_path -from [get_clocks -of_objects [get_pins {*/xxv_ethernet_0_i/inst/i_xxv_ethernet_0_gt_2/inst/gen_gtwizard_gtye4_top.xxv_ethernet_0_gt_2_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[35].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] -to [get_clocks -of_objects [get_pins {*/xxv_ethernet_0_i/inst/i_xxv_ethernet_0_gt_2/inst/gen_gtwizard_gtye4_top.xxv_ethernet_0_gt_2_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[35].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]]
set_false_path -from [get_clocks -of_objects [get_pins {*/xxv_ethernet_0_i/inst/i_xxv_ethernet_0_gt_3/inst/gen_gtwizard_gtye4_top.xxv_ethernet_0_gt_3_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[35].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] -to [get_clocks -of_objects [get_pins {*/xxv_ethernet_0_i/inst/i_xxv_ethernet_0_gt_3/inst/gen_gtwizard_gtye4_top.xxv_ethernet_0_gt_3_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[35].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]]

set_false_path -from [get_clocks -of_objects [get_pins clk_wiz_0_i/inst/mmcme4_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins {*/xxv_ethernet_0_i/inst/i_xxv_ethernet_0_gt/inst/gen_gtwizard_gtye4_top.xxv_ethernet_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[35].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]]
set_false_path -from [get_clocks -of_objects [get_pins clk_wiz_0_i/inst/mmcme4_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins {*/xxv_ethernet_0_i/inst/i_xxv_ethernet_0_gt_1/inst/gen_gtwizard_gtye4_top.xxv_ethernet_0_gt_1_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[35].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]]
set_false_path -from [get_clocks -of_objects [get_pins clk_wiz_0_i/inst/mmcme4_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins {*/xxv_ethernet_0_i/inst/i_xxv_ethernet_0_gt_2/inst/gen_gtwizard_gtye4_top.xxv_ethernet_0_gt_2_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[35].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]]
set_false_path -from [get_clocks -of_objects [get_pins clk_wiz_0_i/inst/mmcme4_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins {*/xxv_ethernet_0_i/inst/i_xxv_ethernet_0_gt_3/inst/gen_gtwizard_gtye4_top.xxv_ethernet_0_gt_3_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[35].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]]
set_false_path -from [get_clocks -of_objects [get_pins clk_wiz_0_i/inst/mmcme4_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins {*/xxv_ethernet_0_i/inst/i_xxv_ethernet_0_gt/inst/gen_gtwizard_gtye4_top.xxv_ethernet_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[35].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]]
set_false_path -from [get_clocks -of_objects [get_pins clk_wiz_0_i/inst/mmcme4_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins {*/xxv_ethernet_0_i/inst/i_xxv_ethernet_0_gt_1/inst/gen_gtwizard_gtye4_top.xxv_ethernet_0_gt_1_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[35].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]]
set_false_path -from [get_clocks -of_objects [get_pins clk_wiz_0_i/inst/mmcme4_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins {*/xxv_ethernet_0_i/inst/i_xxv_ethernet_0_gt_2/inst/gen_gtwizard_gtye4_top.xxv_ethernet_0_gt_2_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[35].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]]
set_false_path -from [get_clocks -of_objects [get_pins clk_wiz_0_i/inst/mmcme4_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins {*/xxv_ethernet_0_i/inst/i_xxv_ethernet_0_gt_3/inst/gen_gtwizard_gtye4_top.xxv_ethernet_0_gt_3_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[35].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]]
