module core_tb();

reg clk, reset;
wire memory_read, memory_write;
wire [31:0] address, write_data, read_data;

always #1 clk = ~clk;

Core Core(
    .clk(clk),
    .reset(reset),
    .memory_read(memory_read),
    .memory_write(memory_write),
    .write_data(write_data),
    .read_data(read_data),
    .address(address)
);

Memory #(
    .MEMORY_FILE("software/memory/blt.hex")
) Memory(
    .clk(clk),
    .reset(reset),
    .memory_read(memory_read),
    .memory_write(memory_write),
    .write_data(write_data),
    .read_data(read_data),
    .address(address)
);

initial begin
    $dumpfile("build/core.vcd");
    $dumpvars;

    clk = 0;

    reset = 1;

    #6

    reset = 0;

    #120

    $finish;
end

endmodule
