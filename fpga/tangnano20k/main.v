module top (
    input wire clk,
    input wire reset,
    input wire rx,
    output wire tx,
    output wire [5:0] led;
);

wire [7:0]leds;
assign led = [5:0]leds;

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
