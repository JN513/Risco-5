module top (
    input wire clk,
    input wire reset,
    input wire rx,
    output wire tx,
    output wire [7:0]led
);

reg reset_bousing;

Risco_5_SOC #(
    .CLOCK_FREQ(25000000),
    .BIT_RATE(9600),
    .MEMORY_SIZE(4096),
    .MEMORY_FILE("../../software/memory/loop_2.hex")
) SOC(
    .clk(clk),
    .reset(1'b0),
    .leds(led),
    .rx(rx),
    .tx(tx)
);

initial begin
    reset_bousing = 1'b0;
end

always @(posedge clk ) begin
    reset_bousing <= reset;
end

endmodule
