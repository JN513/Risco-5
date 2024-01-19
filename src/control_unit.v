module Control_Unit (
    input wire [6:0]instrution_opcode,
    output reg pc_write_cond,
    output reg pc_write,
    output reg lorD,
    output reg memory_read,
    output reg memory_write,
    output reg memory_to_reg,
    output reg ir_write,
    output reg pc_source,
    output reg [1:0] aluop,
    output reg [1:0] alu_src_b,
    output reg alu_src_a,
    output reg reg_write
);

always @(*) begin
    case (instrution_opcode)
        7'b0110011: begin // R type instruction 
            pc_write_cond = 1'b0;
            pc_write = 1'b0;
            lorD = 1'b0;
            memory_read = 1'b0;
            memory_write = 1'b0;
            memory_to_reg =  1'b0;
            aluop =  2'b10;
            alu_src_b =  2'b00;
            alu_src_a =  1'b1;
            reg_write =  1'b0;
        end

        7'b0010011: begin // I type instruction 
            pc_write_cond = 1'b0;
            pc_write = 1'b0;
            lorD = 1'b0;
            memory_read = 1'b0;
            memory_write = 1'b0;
            memory_to_reg =  1'b0;
            aluop =  2'b10;
            alu_src_b =  2'b10;
            alu_src_a =  1'b1;
            reg_write =  1'b0;
        end

        7'b0000011: begin // I type lw instruction 
            alu_src = 1'b1;
            memory_to_reg = 1'b1;
            reg_write = 1'b1;
            memory_read = 1'b1;
            memory_write = 1'b0;
            branch = 1'b0;
            aluop = 2'b00;
        end

        7'b0100011: begin // S type instruction 
            alu_src = 1'b1;
            memory_to_reg = 1'b0;
            reg_write = 1'b0;
            memory_read = 1'b0;
            memory_write = 1'b1;
            branch = 1'b0;
            aluop = 2'b00;
        end

        7'b1100011: begin // SB instruction 
            alu_src = 1'b0;
            memory_to_reg = 1'b0;
            reg_write = 1'b0;
            memory_read = 1'b0;
            memory_write = 1'b0;
            branch = 1'b1;
            aluop = 2'b01;
        end

        7'b0010111: begin // AUIPC instruction 
            pc_write_cond = 1'b0;
            pc_write = 1'b0;
            lorD = 1'b0;
            memory_read = 1'b0;
            memory_write = 1'b0;
            memory_to_reg =  1'b0;
            aluop =  2'b10;
            alu_src_b =  2'b10;
            alu_src_a =  1'b1;
            reg_write =  1'b0;
        end

        7'b0010111: begin // LUI instruction 
            pc_write_cond = 1'b0;
            pc_write = 1'b0;
            lorD = 1'b0;
            memory_read = 1'b0;
            memory_write = 1'b0;
            memory_to_reg =  1'b0;
            aluop =  2'b10;
            alu_src_b =  2'b10;
            alu_src_a =  1'b1;
            reg_write =  1'b0;
        end

        7'b1100111: begin // JALR instruction 
            pc_write_cond = 1'b0;
            pc_write = 1'b0;
            lorD = 1'b0;
            memory_read = 1'b0;
            memory_write = 1'b0;
            memory_to_reg =  1'b0;
            aluop =  2'b10;
            alu_src_b =  2'b10;
            alu_src_a =  1'b1;
            reg_write =  1'b0;
        end

        7'b1101111: begin // UJ type instruction 
            pc_write_cond = 1'b0;
            pc_write = 1'b0;
            lorD = 1'b0;
            memory_read = 1'b0;
            memory_write = 1'b0;
            memory_to_reg =  1'b0;
            aluop =  2'b10;
            alu_src_b =  2'b10;
            alu_src_a =  1'b1;
            reg_write =  1'b0;
        end

        7'b1110011: begin // ecal I type instruction 
            pc_write_cond = 1'b0;
            pc_write = 1'b0;
            lorD = 1'b0;
            memory_read = 1'b0;
            memory_write = 1'b0;
            memory_to_reg =  1'b0;
            aluop =  2'b10;
            alu_src_b =  2'b10;
            alu_src_a =  1'b1;
            reg_write =  1'b0;
        end
    endcase

end
    
endmodule
