read_verilog "main.v"
read_verilog ../../debug/reset.v
read_verilog ../../src/core/alu_control.v
read_verilog ../../src/core/alu.v
read_verilog ../../src/core/control_unit.v
read_verilog ../../src/core/core.v
read_verilog ../../src/core/immediate_generator.v
read_verilog ../../src/core/mux.v
read_verilog ../../src/core/pc.v
read_verilog ../../src/core/registers.v
read_verilog ../../src/core/csr_unit.v
read_verilog ../../src/core/mdu.v
read_verilog ../../src/peripheral/pwm.v
read_verilog ../../src/peripheral/bus.v
read_verilog ../../src/peripheral/gpio.v
read_verilog ../../src/peripheral/gpios.v
read_verilog ../../src/peripheral/leds.v
read_verilog ../../src/peripheral/memory.v
read_verilog ../../src/peripheral/soc.v
read_verilog ../../src/peripheral/uart_rx.v
read_verilog ../../src/peripheral/uart_tx.v
read_verilog ../../src/peripheral/uart.v
read_verilog ../../src/peripheral/fifo.v

read_xdc "digilent_arty.xdc"

# synth
synth_design -top "top" -part "xc7a100tcsg324-1"

# place and route
opt_design
place_design
route_design

# write bitstream
write_bitstream -force "./build/out.bit"