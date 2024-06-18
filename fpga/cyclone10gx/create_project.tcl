project_new cyclone10_gx -overwrite

set_global_assignment -name FAMILY "Cyclone 10 GX"
set_global_assignment -name TOP_LEVEL_ENTITY top
set_global_assignment -name ORIGINAL_QUARTUS_VERSION 23.1.0
set_global_assignment -name LAST_QUARTUS_VERSION "23.1.0 Pro Edition"
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY build
set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
set_global_assignment -name MAX_CORE_JUNCTION_TEMP 100
set_global_assignment -name DEVICE 10CX220YF780E5G
set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 1
set_global_assignment -name VERILOG_FILE main.v

set_location_assignment PIN_J23 -to clk
set_location_assignment PIN_AF6 -to led

set_instance_assignment -name IO_STANDARD "1.8 V" -to led -entity top
set_instance_assignment -name IO_STANDARD "1.8 V" -to clk -entity top

set_global_assignment -name SDC_FILE pinout.sdc

#project close