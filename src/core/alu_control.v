module ALU_Control (
    input wire [1:0] aluop_in,
    input wire [6:0] func7,
    input wire [2:0] func3,
    input wire [6:0] instruction_opcode,
    output wire [3:0] aluop_out
);

reg [3:0] aluop_out_reg;

assign aluop_out = aluop_out_reg;

always @(*) begin
    if(instruction_opcode == 7'b0010011) begin
        case (func3)
            3'b000: // addi
                aluop_out_reg = 4'b0010;
            3'b001: // slli
                aluop_out_reg = 4'b1000;
            3'b010: // slti
                aluop_out_reg = 4'b0111;
            3'b011: // sltiu
                aluop_out_reg = 4'b0111;
            3'b100: // xori
                aluop_out_reg = 4'b1010;
            3'b101: begin
                if(func7 == 7'b0000000) begin // srli
                    aluop_out_reg = 4'b1001;
                end else begin // srai
                    aluop_out_reg = 4'b1001;
                end
            end
            3'b110: // ori
                aluop_out_reg = 4'b0001;
            3'b111: // andi
                aluop_out_reg = 4'b0000;
            default: 
                aluop_out_reg = 4'b0010;
        endcase
    end else if(instruction_opcode == 7'b1100011) begin
        case ({aluop_in, func3})
            5'b01_000: // beq   
                aluop_out_reg = 4'b0110; // sub
            5'b01_100: // blt 
                aluop_out_reg = 4'b1011; // precisa arrumar
            5'b01_110: // bltu  
                aluop_out_reg = 4'b1011; // precisa arrumar
            5'b01_101: // bge
                aluop_out_reg = 4'b0111;
            5'b01_111: // bgeu
                aluop_out_reg = 4'b0111;// precisa verificar se necessita de um slt unsigned
            5'b01_001: // bne
                aluop_out_reg = 4'b1110;
            default: 
                aluop_out_reg = 4'b0110; // 
        endcase
    end else begin
        case ({aluop_in, func7, func3})
            12'b00_0000000_000:  
                aluop_out_reg = 4'b0010; // sum
            12'b01_0000000_000:  
                aluop_out_reg = 4'b0110; // sub
            12'b10_0000000_000:  
                aluop_out_reg = 4'b0010; // sum
            12'b10_0100000_000:  
                aluop_out_reg = 4'b0110; // sub
            12'b10_0000000_111:  
                aluop_out_reg = 4'b0000; // and
            12'b10_0000000_110:  
                aluop_out_reg = 4'b0001; // or
            12'b10_0000000_001:
                aluop_out_reg = 4'b1000; // sll
            12'b10_0000000_010:
                aluop_out_reg = 4'b0111; // slt
            12'b10_0000000_011:
                aluop_out_reg = 4'b0111; // sltu
            12'b10_0000000_101:
                aluop_out_reg = 4'b1001; // srl
            12'b10_0100000_101:
                aluop_out_reg = 4'b1001; // sra
            12'b10_0000000_100:
                aluop_out_reg = 4'b1010; // xor
            default: 
                aluop_out_reg = 4'b0010;
        endcase
    end
end
    
endmodule
