module Control_Unit (
    input wire [6:0]instrution_opcode,
    output reg branch,
    output reg memory_read,
    output reg memory_to_reg,
    output reg [1:0] aluop,
    output reg memory_write,
    output reg alu_src,
    output reg reg_write
);

always @(*) begin
    case (instrution_opcode)
        7'b0110011: begin // R type instruction 
            alu_src = 1'b0;
            memory_to_reg = 1'b0;
            reg_write = 1'b1;
            memory_read = 1'b0;
            memory_write = 1'b0;
            branch = 1'b0;
            aluop = 2'b10;
        end

        7'b0010011: begin // addi instruction 
            alu_src = 1'b1;
            memory_to_reg = 1'b0;
            reg_write = 1'b1;
            memory_read = 1'b0;
            memory_write = 1'b0;
            branch = 1'b0;
            aluop = 2'b00;
        end

        7'b0000011: begin // lw instruction 
            alu_src = 1'b1;
            memory_to_reg = 1'b1;
            reg_write = 1'b1;
            memory_read = 1'b1;
            memory_write = 1'b0;
            branch = 1'b0;
            aluop = 2'b00;
        end

        7'b0100011: begin // sw instruction 
            alu_src = 1'b1;
            memory_to_reg = 1'b0;
            reg_write = 1'b0;
            memory_read = 1'b0;
            memory_write = 1'b1;
            branch = 1'b0;
            aluop = 2'b00;
        end

        7'b1100011: begin // beq instruction 
            alu_src = 1'b0;
            memory_to_reg = 1'b0;
            reg_write = 1'b0;
            memory_read = 1'b0;
            memory_write = 1'b0;
            branch = 1'b1;
            aluop = 2'b01;
        end
    endcase

end
    
endmodule
