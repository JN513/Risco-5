module top (
    input wire clk,
    input wire reset,
    input wire rx,
    output wire tx,
    output wire [3:0]led,
    //inout [5:0]gpios
    inout [13:0]ck_io
);

wire reset_o, reset_in;
wire [7:0] leds;
reg clk_o, reset_bousing;

assign led = ~leds[3:0];
assign reset_in = reset_o | reset_bousing;

initial begin
    clk_o = 1'b0;
    reset_bousing = 1'b0;
end


ResetBootSystem #(
    .CYCLES(20)
) ResetBootSystem(
    .clk(clk_o),
    .reset_o(reset_o)
);

Risco_5_SOC #(
    .CLOCK_FREQ(50000000),
    .BIT_RATE(115200),
    .MEMORY_SIZE(32772),
    .MEMORY_FILE("program.hex"),
    .GPIO_WIDHT(8),
    .UART_BUFFER_SIZE(16)
) SOC(
    .clk(clk_o),
    .reset(reset_in),
    .leds(leds),
    .rx(rx),
    .tx(tx),
    .gpios(ck_io)
);

always @(posedge clk) begin
    clk_o = ~clk_o;
    reset_bousing <= reset;
end


endmodule
