module Risco_5_SOC #(
    parameter CLOCK_FREQ = 25000000,
    parameter BIT_RATE = 9600,
    parameter BOOT_ADDRESS = 32'h00000000,
    parameter MEMORY_SIZE = 4096,
    parameter MEMORY_FILE = ""
)(
    input wire clk,
    input wire reset,
    input wire rx,
    output wire tx,
    output wire [7:0] leds,
    output wire [2:0] d
);

wire memory_read, memory_write, slave_read, slave_write,
    slave1_read, slave1_write, slave2_read, slave2_write;
wire [31:0] address, write_data, read_data,
    slave_address, slave_write_data, slave_read_data,
    slave1_address, slave1_write_data, slave1_read_data,
    slave2_address, slave2_write_data, slave2_read_data;

Core #(
    .BOOT_ADDRESS(BOOT_ADDRESS)
) Core(
    .clk(clk),
    .reset(reset),
    .memory_read(memory_read),
    .memory_write(memory_write),
    .write_data(write_data),
    .read_data(read_data),
    .address(address)
);

Memory #(
    .MEMORY_FILE(MEMORY_FILE),
    .MEMORY_SIZE(MEMORY_SIZE)
) Memory(
    .clk(clk),
    .reset(reset),
    .memory_read(slave_read),
    .memory_write(slave_write),
    .write_data(slave_write_data),
    .read_data(slave_read_data),
    .address(slave_address)
);

BUS Bus(
    .read(memory_read),
    .write(memory_write),
    .write_data(write_data),
    .read_data(read_data),
    .address(address),

    .slave_0_read(slave_read),
    .slave_0_write(slave_write),
    .slave_0_read_data(slave_read_data),
    .slave_0_address(slave_address),
    .slave_0_write_data(slave_write_data),

    .slave_1_read(slave1_read),
    .slave_1_write(slave1_write),
    .slave_1_read_data(slave1_read_data),
    .slave_1_address(slave1_address),
    .slave_1_write_data(slave1_write_data)
);

LEDs Leds(
    .clk(clk),
    .reset(reset),
    .read(slave1_read),
    .write(slave1_write),
    .write_data(slave1_write_data),
    .read_data(slave1_read_data),
    .address(slave1_address),
    .leds(leds)
);

UART #(
    .CLOCK_FREQ(CLOCK_FREQ),
    .BIT_RATE(BIT_RATE)
) Uart(
    .clk(clk),
    .reset(reset),
    .tx(tx),
    .rx(rx),
    .read(slave2_read),
    .write(slave2_write),
    .write_data(slave2_write_data),
    .read_data(slave2_read_data),
    .address(slave2_address)
);

endmodule