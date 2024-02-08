open_project digilent_arty.xpr 
set_msg_config -id {Common 17-55} -new_severity {Warning}

synth_design -directive default -part xc7a100tcsg324-1

report_timing_summary -file report/digilent_arty_timing_synth.rpt
report_utilization -hierarchical -file report/digilent_arty_utilization_hierarchical_synth.rpt
report_utilization -file report/digilent_arty_utilization_synth.rpt
write_checkpoint -force report/digilent_arty_synth.dcp

opt_design -directive default

place_design -directive default

report_utilization -hierarchical -file report/digilent_arty_utilization_hierarchical_place.rpt
report_utilization -file report/digilent_arty_utilization_place.rpt
report_io -file report/digilent_arty_io.rpt
report_control_sets -verbose -file report/digilent_arty_control_sets.rpt
report_clock_utilization -file report/digilent_arty_clock_utilization.rpt
write_checkpoint -force digilent_arty_place.dcp

route_design -directive default
phys_opt_design -directive default
write_checkpoint -force digilent_arty_route.dcp

report_timing_summary -no_header -no_detailed_paths
report_route_status -file report/digilent_arty_route_status.rpt
report_drc -file report/digilent_arty_drc.rpt
report_timing_summary -datasheet -max_paths 10 -file report/digilent_arty_timing.rpt
report_power -file report/digilent_arty_power.rpt
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]


write_bitstream -force digilent_arty.bit 
write_cfgmem -force -format bin -interface spix4 -size 16 -loadbit "up 0x0 digilent_arty.bit" -file digilent_arty.bin

quit