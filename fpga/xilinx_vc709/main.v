`timescale 1ns / 1ps

module top(
    input wire clk_ref_p,
    input wire clk_ref_n,
    input wire button_center,
    input wire RxD,
    output wire TxD,
    inout [7:0] gpio_switch,
    output wire [7:0]led
);
    
wire reset_o, reset_in;
reg clk_o, reset_bousing;

assign reset_in = reset_o | reset_bousing;

initial begin
    clk_o = 1'b0;
    reset_bousing = 1'b0;
end


wire clk_ref; // Sinal de clock single-ended

// Instância do buffer diferencial
IBUFDS #(
    .DIFF_TERM("FALSE"),     // Habilita ou desabilita o terminador diferencial
    .IBUF_LOW_PWR("TRUE"),   // Ativa o modo de baixa potência
    .IOSTANDARD("DIFF_SSTL15")
) ibufds_inst (
    .O(clk_ref),    // Clock single-ended de saída
    .I(clk_ref_p),  // Entrada diferencial positiva
    .IB(clk_ref_n)  // Entrada diferencial negativa
);

ResetBootSystem #(
    .CYCLES(20)
) ResetBootSystem(
    .clk(clk_o),
    .reset_o(reset_o)
);

Risco_5_SOC #(
    .CLOCK_FREQ(100000000),
    .BIT_RATE(115200),
    .MEMORY_SIZE(8192),
    .MEMORY_FILE("../../software/memory/fpga_test_2.hex"),
    .GPIO_WIDHT(8),
    .UART_BUFFER_SIZE(16)
) SOC(
    .clk(clk_o),
    .reset(reset_in),
    .leds(led),
    .rx(RxD),
    .tx(TxD),
    .gpios()
);

always @(posedge clk_ref) begin
    clk_o = ~clk_o;
    reset_bousing <= button_center;
end

endmodule
