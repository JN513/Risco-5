module top (
    input wire clk,
    input wire reset,
    input wire rx,
    output wire tx,
    output wire [7:0]led
);


reg reset_bousing;
wire memory_read, memory_write;
wire [31:0] address, write_data, read_data;

Core Core(
    .clk(clk),
    .reset(reset_bousing),
    .memory_read(memory_read),
    .memory_write(memory_write),
    .write_data(write_data),
    .read_data(read_data),
    .address(address)
);

Memory #(
    .MEMORY_FILE("../../software/memory/addi.hex")
) Memory(
    .clk(clk),
    .reset(reset),
    .memory_read(memory_read),
    .memory_write(memory_write),
    .write_data(write_data),
    .read_data(read_data),
    .address(address)
);

always @(posedge clk ) begin
    reset_bousing <= reset;
end

endmodule
