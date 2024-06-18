`ifdef MDU_ENABLE
module MDU (
    input wire clk,
    input wire reset,
    input wire [2:0] operation,
    input wire [31:0] MDU_in_X,
    input wire [31:0] MDU_in_Y,
    output reg [31:0] MDU_out_S
);


localparam MUL             = 3'b000;
localparam MULH            = 3'b001;
localparam MULHSU          = 3'b010;
localparam MULHU           = 3'b011;
localparam DIV             = 3'b100;
localparam DIVU            = 3'b101;
localparam REM             = 3'b110;
localparam REMU            = 3'b111;

always @(*) begin
    case(operation)
        MUL: // Multiplicação
            MDU_out_S <= MDU_in_X * MDU_in_Y;
        MULH: // Multiplicação
            MDU_out_S <= (MDU_in_X * MDU_in_Y) >> 32;
        MULHSU: // Multiplicação
            MDU_out_S <= ($signed(MDU_in_X) * $unsigned(MDU_in_Y)) >> 32;
        MULHU: // Multiplicação
            MDU_out_S <= ($unsigned(MDU_in_X) * $unsigned(MDU_in_Y)) >> 32;
        DIV: // Divisão
            MDU_out_S <= MDU_in_X / MDU_in_Y;
        DIVU: // Divisão
            MDU_out_S <= $unsigned(MDU_in_X) / $unsigned(MDU_in_Y);
        REM: // Resto
            MDU_out_S <= MDU_in_X % MDU_in_Y;
        REMU: // Resto
            MDU_out_S <= $unsigned(MDU_in_X) % $unsigned(MDU_in_Y);
        default: MDU_out_S <= MDU_in_X ; // Operação padrão
    endcase
end
    
endmodule
`endif