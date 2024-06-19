module soc_tb();

reg clk, reset;
wire rx, tx;
wire [7:0] gpios;
wire [7:0] led;

reg [3:0] data = 4'b1010;

assign gpios[7:4] = data;

always #1 clk = ~clk;

Risco_5_SOC #(
    .CLOCK_FREQ(25000000),
    .BIT_RATE(115200),
    .MEMORY_SIZE(32772),
    .MEMORY_FILE("software/memory/generic.hex"),
    .GPIO_WIDHT(8),
    .UART_BUFFER_SIZE(16)
) SOC(
    .clk(clk),
    .reset(reset),
    .leds(led),
    .rx(rx),
    .tx(tx),
    .gpios(gpios)
);

initial begin
    $dumpfile("build/soc.vcd");
    $dumpvars;

    clk = 1'b0;
    reset = 1'b1;
    #6
    reset = 1'b0;
    //#560

    #3600

    $finish;
end

endmodule
