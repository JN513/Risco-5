module top (
    input wire clk,
    input wire reset,
    input wire rx,
    output wire tx,
    output wire [7:0]led,
    inout [5:0]gpios
);

wire clk_o, reset_o;
wire [7:0] leds;

ClkDivider #(
    .COUNTER_BITS(32)
) ClkDivider(
    .clk(clk),
    .reset(reset),
    .option(1'b1),
    .out_enable(1'b1),
    .divider(32'd6250000),
    .pulse(1'b0),
    .clk_o(clk_o)
);

ResetBootSystem #(
    .CYCLES(20)
) ResetBootSystem(
    .clk(clk_o),
    .reset_o(reset_o)
);

assign led[7] = ~clk_o;
assign led[6] = ~reset_o; // 5:3
assign led[5:0] = leds [5:0];

Risco_5_SOC #(
    .CLOCK_FREQ(25000000),
    .BIT_RATE(9600),
    .MEMORY_SIZE(4096),
    .MEMORY_FILE("../../software/memory/loop3.hex"),
    .GPIO_WIDHT(6)
) SOC(
    .clk(clk_o),
    .reset(reset_o),
    .leds(leds),
    .rx(rx),
    .tx(tx),
    .gpios(gpios)
);


endmodule
