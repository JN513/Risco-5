module top (
    input wire clk, // 50mhz clock
    output wire LED
);

wire reset_o;
wire [7:0] led;

assign LED = led[0];

ResetBootSystem #(
    .CYCLES(20)
) ResetBootSystem(
    .clk(clk),
    .reset_o(reset_o)
);

Risco_5_SOC #(
    .CLOCK_FREQ(50000000),
    .BIT_RATE(115200),
    .MEMORY_SIZE(2048),
    .MEMORY_FILE("../../software/memory/teste_uart_fpga.hex"),
    .GPIO_WIDHT(6),
    .UART_BUFFER_SIZE(16)
) SOC(
    .clk(clk),
    .reset(reset_o),
    .leds(led),
    .rx(),
    .tx(),
    .gpios()
);

    
endmodule