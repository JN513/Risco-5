set_device -name GW2AR-18C GW2AR-LV18QN88C8/I7
add_file Risco-5/fpga/tangnano20k/pinout.cst
add_file Risco-5/fpga/tangnano20k/top.sdc
add_file Risco-5/fpga/tangnano20k/main.v
add_file Risco-5/fpga/tangnano20k/reset.v
add_file Risco-5/debug/clk_divider.v
add_file Risco-5/src/core/alu_control.v
add_file Risco-5/src/core/alu.v
add_file Risco-5/src/core/control_unit.v
add_file Risco-5/src/core/core.v
add_file Risco-5/src/core/immediate_generator.v
add_file Risco-5/src/core/mux.v
add_file Risco-5/src/core/pc.v
add_file Risco-5/src/core/registers.v
add_file Risco-5/src/peripheral/bus.v
add_file Risco-5/src/peripheral/gpio.v
add_file Risco-5/src/peripheral/gpios.v
add_file Risco-5/src/peripheral/leds.v
add_file Risco-5/src/peripheral/memory.v
add_file Risco-5/src/peripheral/soc.v
add_file Risco-5/src/peripheral/uart_rx.v
add_file Risco-5/src/peripheral/uart_tx.v
add_file Risco-5/src/peripheral/uart.v
set_option -use_mspi_as_gpio 1
set_option -use_sspi_as_gpio 1
set_option -use_ready_as_gpio 1
set_option -use_done_as_gpio 1
set_option -rw_check_on_ram 1
run all