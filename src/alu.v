module ALU (
    input wire [3:0] operation,
    input wire [31:0] ALU_in_X,
    input wire [31:0] ALU_in_Y,
    output wire [31:0] ALU_out_S,
    output wire ZR
);

reg [31:0] ALU_Result;

assign ALU_out_S = ALU_Result;
assign ZR = ~( |ALU_Result );

always @(*) begin
    case(operation)
        4'b0000: // AND
            ALU_Result = ALU_in_X & ALU_in_Y ; 
        4'b0001: // OR
            ALU_Result = ALU_in_X | ALU_in_Y ;
        4'b0010: // Adição
            ALU_Result = ALU_in_X + ALU_in_Y;
        4'b0110: // Subtração
            ALU_Result = ALU_in_X - ALU_in_Y;
        4'b0111: // SLT
            ALU_Result = (ALU_in_X < ALU_in_Y) ? 32'h1 : 32'h0;
        4'b1100: // NOR
            ALU_Result = ~(ALU_in_X | ALU_in_Y);
        4'b1000: // Shift Left (deslocamento à esquerda)
            ALU_Result = ALU_in_X << ALU_in_Y;
        4'b1001: // Shift Right (deslocamento à direita)
            ALU_Result = ALU_in_X >> ALU_in_Y;
        4'b1010: // XOR (OU exclusivo)
            ALU_Result = ALU_in_X ^ ALU_in_Y;
        4'b1110: // Igual
            ALU_Result = ALU_in_X == ALU_in_Y;
        4'b1011:
            ALU_Result = (ALU_in_X >= ALU_in_Y) ? 32'h1 : 32'h0;
        default: ALU_Result = ALU_in_X ; // Operação padrão
    endcase
end
    
endmodule
