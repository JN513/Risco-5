module Alu (
    input wire [3:0] operation,
    input wire [31:0] ALU_in_X,
    input wire [31:0] ALU_in_Y,
    output reg [31:0] ALU_out_S,
    output wire ZR
);

localparam AND           = 4'b0000;
localparam OR            = 4'b0001;
localparam SUM           = 4'b0010;
localparam SUB           = 4'b0110;
localparam SLT           = 4'b0111;
localparam NOR           = 4'b1100;
localparam XOR           = 4'b1010;
localparam EQUAL         = 4'b1110;
localparam SHIFT_LEFT    = 4'b1000;
localparam SHIFT_RIGHT   = 4'b1001;
localparam GREATER_EQUAL = 4'b1011;

assign ZR = ~( |ALU_out_S );

always @(*) begin
    case(operation)
        AND: // AND
            ALU_out_S = ALU_in_X & ALU_in_Y ; 
        OR: // OR
            ALU_out_S = ALU_in_X | ALU_in_Y ;
        SUM: // Adição
            ALU_out_S = ALU_in_X + ALU_in_Y;
        SUB: // Subtração
            ALU_out_S = ALU_in_X - ALU_in_Y;
        SLT: // SLT
            ALU_out_S = (ALU_in_X < ALU_in_Y) ? 32'h1 : 32'h0;
        NOR: // NOR
            ALU_out_S = ~(ALU_in_X | ALU_in_Y);
        XOR: // XOR (OU exclusivo)
            ALU_out_S = ALU_in_X ^ ALU_in_Y;
        EQUAL: // Igualdade
            ALU_out_S = ALU_in_X == ALU_in_Y;
        SHIFT_LEFT: // Shift Left (deslocamento à esquerda)
            ALU_out_S = ALU_in_X << ALU_in_Y;
        SHIFT_RIGHT: // Shift Right (deslocamento à direita)
            ALU_out_S = ALU_in_X >> ALU_in_Y;
        GREATER_EQUAL: // Maior igual
            ALU_out_S = (ALU_in_X >= ALU_in_Y) ? 32'h1 : 32'h0;
        default: ALU_out_S = ALU_in_X ; // Operação padrão
    endcase
end
    
endmodule
