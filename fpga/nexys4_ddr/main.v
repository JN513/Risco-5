module top (
    input wire clk,
    input wire CPU_RESETN,
    input wire rx,
    output wire tx,
    output wire [7:0]LED,
    inout [7:0]gpio
);

wire reset_o, reset_in;
wire [7:0] led;
reg clk_o, reset_bousing;

assign LED = ~led;
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
    .MEMORY_SIZE(2048),
    .MEMORY_FILE("../../software/memory/teste_uart_fpga.hex"),
    .GPIO_WIDHT(8),
    .UART_BUFFER_SIZE(16)
) SOC(
    .clk(clk_o),
    .reset(reset_in),
    .leds(led),
    .rx(rx),
    .tx(tx),
    .gpios(gpio)
);

always @(posedge clk) begin
    clk_o = ~clk_o;
    reset_bousing <= CPU_RESETN;
end

endmodule
