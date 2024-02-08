################################################################################
# IO constraints
################################################################################
# clk100:0
set_property PACKAGE_PIN E3 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

# cpu_reset:0
set_property PACKAGE_PIN C12 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

# serial:0.tx
set_property PACKAGE_PIN LD20 [get_ports tx]
set_property IOSTANDARD LVCMOS33 [get_ports tx]

# serial:0.rx
set_property PACKAGE_PIN LD19 [get_ports rx]
set_property IOSTANDARD LVCMOS33 [get_ports rx]

# user_led:0
set_property PACKAGE_PIN H17 [get_ports led[0]]
set_property IOSTANDARD LVCMOS33 [get_ports led[0]]

# user_led:1
set_property PACKAGE_PIN K15 [get_ports led[1]]
set_property IOSTANDARD LVCMOS33 [get_ports led[1]]

# user_led:2
set_property PACKAGE_PIN J13 [get_ports led[2]]
set_property IOSTANDARD LVCMOS33 [get_ports led[2]]

# user_led:3
set_property PACKAGE_PIN N14 [get_ports led[3]]
set_property IOSTANDARD LVCMOS33 [get_ports led[3]]

# user_led:4
set_property PACKAGE_PIN R18 [get_ports led[4]]
set_property IOSTANDARD LVCMOS33 [get_ports led[4]]

# user_led:5
set_property PACKAGE_PIN V17 [get_ports led[5]]
set_property IOSTANDARD LVCMOS33 [get_ports led[5]]

# user_led:6
set_property PACKAGE_PIN U17 [get_ports led[6]]
set_property IOSTANDARD LVCMOS33 [get_ports led[6]]

# user_led:7
set_property PACKAGE_PIN U16 [get_ports led[7]]
set_property IOSTANDARD LVCMOS33 [get_ports led[7]]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

create_cPACKAGE_PINk -name clk -period 10.0 [get_ports clk]