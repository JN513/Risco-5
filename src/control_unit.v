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
    output reg [1:0] alu_src_b,
    output reg alu_src_a,
    output reg reg_write
);

parameter FETCH = 3'b000;
parameter DECODE = 3'b001;
parameter EXECUTION = 3'b010;
parameter MEMORY_WRITE = 3'b011;
parameter MEMORY_READ = 3'b100;

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
            else nextstate = MEMORY_WRITE;
        end
        MEMORY_WRITE: begin
            if(instrution_opcode == 7'b0000011) nextstate = MEMORY_READ;
            else nextstate = FETCH;
        end
        MEMORY_READ: nextstate = FETCH;
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
    alu_src_a = 1'b0;
    reg_write = 1'b0;

    case (state)
        FETCH: begin
            memory_read = 1'b1;
            alu_src_a = 1'b0;
            lorD = 1'b0;
            ir_write = 1'b1;
            alu_src_b = 2'b01;
            aluop = 2'b00;
            pc_write = 1'b1;
            pc_source = 1'b0;
        end
        DECODE: begin
            alu_src_a = 1'b0;
            alu_src_b = 2'b10;
            aluop = 2'b00;
        end
        EXECUTION: begin
            case (instrution_opcode)
                7'b0110011: begin // r type
                    alu_src_a = 1'b1;
                    alu_src_b = 2'b00;
                    aluop = 2'b10;
                end

                7'b0010011: begin // addi instruction 
                    alu_src_a = 1'b1;
                    alu_src_b = 2'b10;
                    aluop = 2'b10;
                end

                7'b0000011, 7'b0100011: begin // lw, sw
                    alu_src_a = 1'b1;
                    alu_src_b = 2'b10;
                    aluop = 2'b00;
                end

                7'b1100011: begin // branch
                    alu_src_a = 1'b1;
                    alu_src_b = 2'b00;
                    aluop = 2'b01;
                    pc_write_cond = 1'b1;
                    pc_source = 1'b1;
                end 
            endcase
        end
        MEMORY_WRITE: begin
            case (instrution_opcode)
                7'b0110011: begin // r type
                    reg_write = 1'b1;
                    memory_to_reg = 1'b0;
                end

                7'b0010011: begin // addi type
                    reg_write = 1'b1;
                    memory_to_reg = 1'b0;
                end

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
        MEMORY_READ: begin
            reg_write = 1'b1;
            memory_to_reg = 1'b1;
        end
    endcase
end
    
endmodule
