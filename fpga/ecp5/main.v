module top (
    input wire clk,
    input wire reset,
    input wire rx,
    output wire tx,
    output wire [7:0]led,
    inout [5:0]gpios
);

wire reset_o;

ResetBootSystem #(
    .CYCLES(20)
) ResetBootSystem(
    .clk(clk),
    .reset_o(reset_o)
);

Risco_5_SOC #(
    .CLOCK_FREQ(25000000),
    .BIT_RATE(115200),
    .MEMORY_SIZE(128),
    .MEMORY_FILE("../../software/memory/fpga_test_2.hex"),
    .GPIO_WIDHT(6),
    .UART_BUFFER_SIZE(16)
) SOC(
    .clk(clk),
    .reset(reset_o),
    .leds(led),
    .rx(rx),
    .tx(tx),
    .gpios(gpios)
);


endmodule
