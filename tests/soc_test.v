module soc_tb();

reg clk, reset;
wire rx, tx;
wire [7:0] led;

always #1 clk = ~clk;

Risco_5_SOC #(
    .CLOCK_FREQ(25000000),
    .BIT_RATE(9600),
    .MEMORY_SIZE(4096),
    .MEMORY_FILE("software/memory/generic.hex")
) SOC(
    .clk(clk),
    .reset(reset),
    .leds(led),
    .rx(rx),
    .tx(tx)
);

initial begin
    $dumpfile("build/soc.vcd");
    $dumpvars;

    clk = 1'b0;
    reset = 1'b1;
    #6
    reset = 1'b0;
    #560

    $finish;
end

endmodule
