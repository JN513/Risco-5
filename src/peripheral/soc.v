module SOC #(
    parameter CLOCK_FREQ = 25000000,
    parameter BOOT_ADDRESS = 32'h00000000,
    parameter MEMORY_SIZE = 4096,
    parameter MEMORY_FILE = "";
)(
    input wire clk,
    input wire reset
);

wire memory_read, memory_write;
wire [31:0] address, write_data, read_data;

Core #(
    .BOOT_ADDRESS(BOOT_ADDRESS)
) Core(
    .clk(clk),
    .reset(reset_bousing),
    .memory_read(memory_read),
    .memory_write(memory_write),
    .write_data(write_data),
    .read_data(read_data),
    .address(address)
);

Memory #(
    .MEMORY_SIZE(MEMORY_SIZE),
    .MEMORY_FILE(MEMORY_FILE)
) Memory(
    .clk(clk),
    .reset(reset),
    .memory_read(memory_read),
    .memory_write(memory_write),
    .write_data(write_data),
    .read_data(read_data),
    .address(address)
);

endmodule