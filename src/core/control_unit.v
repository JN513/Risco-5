module Control_Unit (
    input wire clk,
    input wire reset,
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
    output reg [1:0] alu_src_a,
    output reg [1:0] alu_src_b,
    output reg reg_write
);

parameter FETCH = 3'b000;
parameter DECODE = 3'b001;
parameter EXECUTION = 3'b010;
parameter MEMORY_ACCESS = 3'b011;
parameter WRITE_BACK = 3'b100;

reg [2:0] state, nextstate;

initial begin
    state = 3'b000;
    nextstate = 3'b000;
    pc_write_cond = 1'b0;
    pc_write = 1'b0;
    lorD = 1'b0;
    memory_read = 1'b0;
    memory_write = 1'b0;
    memory_to_reg = 1'b0;
    ir_write = 1'b0;
    pc_source = 1'b0;
    aluop = 2'b00;
    alu_src_b = 2'b00;
    alu_src_a = 1'b0;
    reg_write = 1'b0;
end

always @(posedge clk ) begin
    if(reset) begin
        state <= FETCH;
    end else begin
        state <= nextstate;
    end
end

always @(*) begin
    case (state)
        FETCH: nextstate = DECODE;
        DECODE: nextstate = EXECUTION;
        EXECUTION: begin
            if(instrution_opcode == 7'b1100011) nextstate = FETCH;
            else nextstate = MEMORY_ACCESS;
        end
        MEMORY_ACCESS: begin
            if(instrution_opcode == 7'b0000011) nextstate = WRITE_BACK;
            else nextstate = FETCH;
        end
        WRITE_BACK: nextstate = FETCH;
        default: nextstate = FETCH;
    endcase
end

always @(*) begin
    pc_write_cond = 1'b0;
    pc_write = 1'b0;
    lorD = 1'b0;
    memory_read = 1'b0;
    memory_write = 1'b0;
    memory_to_reg = 1'b0;
    ir_write = 1'b0;
    pc_source = 1'b0;
    aluop = 2'b00;
    alu_src_b = 2'b00;
    alu_src_a = 2'b00;
    reg_write = 1'b0;

    case (state)
        FETCH: begin
            memory_read = 1'b1;
            ir_write = 1'b1;
            alu_src_b = 2'b01;
            pc_write = 1'b1;
        end
        DECODE: begin
            if(instrution_opcode == 7'b1100111) // JARL instruction
                alu_src_a = 2'b01;
            alu_src_b = 2'b10;
        end
        EXECUTION: begin
            case (instrution_opcode)
                7'b0110011: begin // r type
                    alu_src_a = 2'b01;
                    aluop = 2'b10;
                end

                7'b0010011: begin // addi instruction 
                    alu_src_a = 2'b01;
                    alu_src_b = 2'b10;
                    aluop = 2'b10;
                end

                7'b0010111: begin // AUIPC instruction 
                    alu_src_b = 2'b10;
                end

                7'b0110111: begin // LUI instruction 
                    alu_src_a = 2'b10;
                    alu_src_b = 2'b10;
                end

                7'b1101111: begin // JAL instruction
                    alu_src_a = 2'b00;
                    alu_src_b = 2'b01; // 01
                    pc_write = 1'b1;
                    pc_source = 1'b1;
                end

                7'b1100111: begin // JARL instruction
                    alu_src_a = 2'b00;
                    alu_src_b = 2'b01; // 01
                    pc_write = 1'b1;
                    pc_source = 1'b1;
                end

                7'b0000011, 7'b0100011: begin // lw, sw
                    alu_src_a = 2'b01;
                    alu_src_b = 2'b10;
                end

                7'b1100011: begin // branch
                    alu_src_a = 2'b01;
                    aluop = 2'b01;
                    pc_write_cond = 1'b1;
                    pc_source = 1'b1;
                end 
            endcase
        end
        MEMORY_ACCESS: begin
            case (instrution_opcode)
                7'b0110011: // r type
                    reg_write = 1'b1;

                7'b0010011: // addi type
                    reg_write = 1'b1;

                7'b0010111: // AUIPC instruction 
                    reg_write = 1'b1;

                7'b0110111: // LUI instruction 
                    reg_write = 1'b1;

                7'b1101111: // JAL instruction
                    reg_write = 1'b1;
                    
                7'b0000011: begin // lw
                    memory_read = 1'b1;
                    lorD = 1'b1;
                end

                7'b0100011: begin // sw
                    memory_write = 1'b1;
                    lorD = 1'b1;
                end
            endcase
        end
        WRITE_BACK: begin
            reg_write = 1'b1;
            memory_to_reg = 1'b1;
        end
    endcase
end
    
endmodule
