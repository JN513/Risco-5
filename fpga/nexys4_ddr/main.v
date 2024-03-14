module top (
    input wire clk,
    input wire CPU_RESETN,
    input wire rx,
    output wire tx,
    output wire [7:0]LED,
    inout [7:0]gpio
);

wire reset_o;

ResetBootSystem #(
    .CYCLES(20)
) ResetBootSystem(
    .clk(clk),
    .reset_o(reset_o)
);

Risco_5_SOC #(
    .CLOCK_FREQ(100000000),
    .BIT_RATE(115200),
    .MEMORY_SIZE(2048),
    .MEMORY_FILE("../../software/memory/fpga_test_3.hex"),
    .GPIO_WIDHT(8)
) SOC(
    .clk(clk),
    .reset(reset_o),
    .leds(LED),
    .rx(rx),
    .tx(tx),
    .gpios(gpio)
);


endmodule
