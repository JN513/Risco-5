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
    output reg is_immediate,
    output reg [1:0] aluop,
    output reg [1:0] alu_src_a,
    output reg [1:0] alu_src_b,
    output reg reg_write
);

// machine states
parameter FETCH = 4'b0000;
parameter DECODE = 4'b0001;
parameter MEMADR = 4'b0010;
parameter MEMREAD = 4'b0011;
parameter MEMWB = 4'b0100;
parameter MEMWRITE = 4'b0101;
parameter EXECUTER = 4'b0110;
parameter ALUWB = 4'b0111;
parameter EXECUTEI = 4'b1000;
parameter JAL = 4'b1001;
parameter BEQ = 4'b1010;
parameter JALR = 4'b1011;
parameter AUIPC = 4'b1100;
parameter LUI = 4'b1101;

// Instruction Opcodes
parameter LW = 7'b0000011;
parameter SW = 7'b0100011;
parameter RTYPE = 7'b0110011;
parameter ITYPE = 7'b0010011;
parameter JALI = 7'b1101111;
parameter BEQI = 7'b1100011;
parameter JALRI = 7'b1100111;
parameter AUIPCI = 7'b0010111;
parameter LUII = 7'b0110111;

reg [3:0] state, nextstate;

initial begin
    state = 4'b0000;
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
    is_immediate = 1'b0;
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
        DECODE: begin
            case (instrution_opcode)
                LW: nextstate = MEMADR;
                SW: nextstate = MEMADR;
                RTYPE: nextstate = EXECUTER;
                ITYPE: nextstate = EXECUTEI;
                JALI: nextstate = JAL;
                BEQI: nextstate = BEQ;
                JALRI: nextstate = JALR;
                AUIPCI: nextstate = AUIPC;
                LUII: nextstate = LUI;
            endcase
        end
        MEMADR: begin
            if(instrution_opcode == LW)
                nextstate = MEMREAD;
            else
                nextstate = MEMWRITE;
        end
        MEMREAD: nextstate = MEMWB;
        MEMWB: nextstate = FETCH;
        MEMWRITE: nextstate = FETCH;
        EXECUTER: nextstate = ALUWB;
        ALUWB: nextstate = FETCH;
        EXECUTEI: nextstate = ALUWB;
        JAL: nextstate = ALUWB;
        BEQ: nextstate = FETCH;
        JALR: nextstate = ALUWB;
        AUIPC: nextstate = ALUWB;
        LUI: nextstate = ALUWB;
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
    is_immediate = 1'b0;

    case (state)
        FETCH: begin
            memory_read = 1'b1;
            ir_write = 1'b1;
            alu_src_b = 2'b01;
            pc_write = 1'b1;
        end
        DECODE: begin
            if(instrution_opcode == 7'b1100111) // JALR instruction
                alu_src_a = 2'b01;
            alu_src_b = 2'b10;
        end

        MEMADR: begin
            alu_src_a = 2'b01;
            alu_src_b = 2'b10;
        end
        
        MEMREAD: begin
            memory_read = 1'b1;
            lorD = 1'b1;
        end

        MEMWB: begin
            reg_write = 1'b1;
            memory_to_reg = 1'b1;
        end

        MEMWRITE: begin
            memory_write = 1'b1;
            lorD = 1'b1;
        end

        EXECUTER: begin
            alu_src_a = 2'b01;
            aluop = 2'b10;
        end

        ALUWB: begin
            reg_write = 1'b1;
        end

        EXECUTEI: begin
            alu_src_a = 2'b01;
            alu_src_b = 2'b10;
            aluop = 2'b10;
            is_immediate = 1'b1;
        end

        JAL: begin
            alu_src_a = 2'b00;
            alu_src_b = 2'b01; // 01
            pc_write = 1'b1;
            pc_source = 1'b1;
        end

        BEQ: begin
            alu_src_a = 2'b01;
            aluop = 2'b01;
            pc_write_cond = 1'b1;
            pc_source = 1'b1;
        end

        JALR: begin
            alu_src_a = 2'b00;
            alu_src_b = 2'b01; // 01
            pc_write = 1'b1;
            pc_source = 1'b1;
            is_immediate = 1'b1;
        end

        AUIPC: begin
            alu_src_b = 2'b10;
        end

        LUI: begin
            alu_src_a = 2'b10;
            alu_src_b = 2'b10;
        end
    endcase
end
    
endmodule
