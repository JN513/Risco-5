module top (
    input wire clk,
    input wire reset,
    input wire rx,
    output wire tx,
    output wire [7:0]led
);

reg reset_bousing;
wire clk_o;
wire [7:0] leds;

ClkDivider #(
    .COUNTER_BITS(32)
) ClkDivider(
    .clk(clk),
    .reset(reset),
    .option(1'b1),
    .out_enable(1'b1),
    .divider(32'd25000000),
    .pulse(1'b0),
    .clk_o(clk_o)
);

assign led[7] = ~clk_o;
assign led[6] = ~reset_bousing; // 5:3
assign led[5:3] = leds [2:0];

Risco_5_SOC #(
    .CLOCK_FREQ(25000000),
    .BIT_RATE(9600),
    .MEMORY_SIZE(4096),
    .MEMORY_FILE("../../software/memory/teste_uart_tx.hex")
) SOC(
    .clk(clk_o),
    .reset(reset_bousing),
    .leds(leds),
    .rx(rx),
    .tx(tx),
    .d(led[2:0])
);

initial begin
    reset_bousing = 1'b0;
end

always @(posedge clk ) begin
    //reset_bousing <= reset;
end

endmodule
