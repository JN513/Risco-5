module ALU (
    input wire [3:0] operation,
    input wire [31:0] ALU_in_X,
    input wire [31:0] ALU_in_Y,
    output reg [31:0] ALU_out_S,
    output wire ZR
);

assign ZR = ~( |ALU_out_S );

always @(*) begin
    case(operation)
        4'b0000: // AND
            ALU_out_S = ALU_in_X & ALU_in_Y ; 
        4'b0001: // OR
            ALU_out_S = ALU_in_X | ALU_in_Y ;
        4'b0010: // Adição
            ALU_out_S = ALU_in_X + ALU_in_Y;
        4'b0110: // Subtração
            ALU_out_S = ALU_in_X - ALU_in_Y;
        4'b0111: // SLT
            ALU_out_S = (ALU_in_X < ALU_in_Y) ? 32'h1 : 32'h0;
        4'b1100: // NOR
            ALU_out_S = ~(ALU_in_X | ALU_in_Y);
        4'b1000: // Shift Left (deslocamento à esquerda)
            ALU_out_S = ALU_in_X << ALU_in_Y;
        4'b1001: // Shift Right (deslocamento à direita)
            ALU_out_S = ALU_in_X >> ALU_in_Y;
        4'b1010: // XOR (OU exclusivo)
            ALU_out_S = ALU_in_X ^ ALU_in_Y;
        4'b1110: // Igualdade
            ALU_out_S = ALU_in_X == ALU_in_Y;
        4'b1011: // Maior igual
            ALU_out_S = (ALU_in_X >= ALU_in_Y) ? 32'h1 : 32'h0;
        default: ALU_out_S = ALU_in_X ; // Operação padrão
    endcase
end
    
endmodule
