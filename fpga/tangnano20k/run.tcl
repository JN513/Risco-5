set_device -name GW2AR-18C GW2AR-LV18QN88C8/I7
add_file pinout.cst
add_file top.sdc
add_file main.v
add_file ../../debug/reset.v
add_file ../../src/core/alu_control.v
add_file ../../src/core/alu.v
add_file ../../src/core/control_unit.v
add_file ../../src/core/core.v
add_file ../../src/core/immediate_generator.v
add_file ../../src/core/mux.v
add_file ../../src/core/pc.v
add_file ../../src/core/registers.v
add_file ../../src/core/csr_unit.v
add_file ../../src/core/mdu.v
add_file ../../src/peripheral/bus.v
add_file ../../src/peripheral/gpio.v
add_file ../../src/peripheral/gpios.v
add_file ../../src/peripheral/leds.v
add_file ../../src/peripheral/memory.v
add_file ../../src/peripheral/soc.v
add_file ../../src/peripheral/uart_rx.v
add_file ../../src/peripheral/uart_tx.v
add_file ../../src/peripheral/uart.v
add_file ../../src/peripheral/fifo.v
add_file ../../src/peripheral/pwm.v

set_option -use_mspi_as_gpio 1
set_option -use_sspi_as_gpio 1
set_option -use_ready_as_gpio 1
set_option -use_done_as_gpio 1
set_option -rw_check_on_ram 1
run all