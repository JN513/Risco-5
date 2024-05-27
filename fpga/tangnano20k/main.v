module top (
    input wire clk,
    input wire reset,
    input wire rx,
    output wire tx,
    output wire [5:0] led,
    inout [4:0]gpios
);

wire reset_o;
wire [7:0] leds;

ResetBootSystem #(
    .CYCLES(20)
) ResetBootSystem(
    .clk(clk),
    .reset_o(reset_o)
);

assign led = leds [5:0];

Risco_5_SOC #(
    .CLOCK_FREQ(27000000),
    .BIT_RATE(115200),
    .MEMORY_SIZE(2048),
    .MEMORY_FILE("../../software/memory/teste_uart_fpga.hex"),
    .GPIO_WIDHT(5),
    .UART_BUFFER_SIZE(16)
) SOC(
    .clk(clk),
    .reset(reset_o),
    .leds(leds),
    .rx(rx),
    .tx(tx),
    .gpios(gpios)
);

endmodule
