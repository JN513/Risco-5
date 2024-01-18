module top (
    input wire clk,
    input wire reset,
    input wire rx,
    output wire tx,
    output wire [7:0]led
);

Core #(
    .MEMORY_FILE("../software/memory/fpga_test.hex")
) Core(
    .clk(clk),
    .reset(reset),
    .leds(led)
);

always @(posedge clk ) begin

end

endmodule
