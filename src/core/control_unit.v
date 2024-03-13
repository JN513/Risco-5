module Control_Unit (
    input wire clk,
    input wire reset,
    input wire [6:0]instruction_opcode,
    output reg lorD,
    output reg pc_write,
    output reg ir_write,
    output reg pc_source,
    output reg reg_write,
    output reg memory_read,
    output reg is_immediate,
    output reg memory_write,
    output reg pc_write_cond,
    output reg csr_write_enable,
    output reg [1:0] aluop,
    output reg [1:0] alu_src_a,
    output reg [1:0] alu_src_b,
    output reg [1:0] memory_to_reg
);

// machine states
localparam FETCH      = 4'b0000;
localparam DECODE     = 4'b0001;
localparam MEMADR     = 4'b0010;
localparam MEMREAD    = 4'b0011;
localparam MEMWB      = 4'b0100;
localparam MEMWRITE   = 4'b0101;
localparam EXECUTER   = 4'b0110;
localparam ALUWB      = 4'b0111;
localparam EXECUTEI   = 4'b1000;
localparam JAL        = 4'b1001;
localparam BEQ        = 4'b1010;
localparam JALR       = 4'b1011;
localparam AUIPC      = 4'b1100;
localparam LUI        = 4'b1101;
localparam JALR_PC    = 4'b1110;
localparam EXECUTECSR = 4'b1111;

// Instruction Opcodes
localparam LW     = 7'b0000011;
localparam SW     = 7'b0100011;
localparam RTYPE  = 7'b0110011;
localparam ITYPE  = 7'b0010011;
localparam JALI   = 7'b1101111;
localparam BEQI   = 7'b1100011;
localparam JALRI  = 7'b1100111;
localparam AUIPCI = 7'b0010111;
localparam LUII   = 7'b0110111;
localparam CSR    = 7'b1110011;

reg [3:0] state, nextstate;

initial begin
    state = 4'b0000;
    nextstate = 4'b0000;
    pc_write_cond = 1'b0;
    pc_write = 1'b0;
    lorD = 1'b0;
    memory_read = 1'b0;
    memory_write = 1'b0;
    memory_to_reg = 2'b00;
    ir_write = 1'b0;
    pc_source = 1'b0;
    aluop = 2'b00;
    alu_src_b = 2'b00;
    alu_src_a = 1'b0;
    reg_write = 1'b0;
    is_immediate = 1'b0;
    csr_write_enable = 1'b0;
end

always @(posedge clk ) begin
    if(reset) begin
        state <= FETCH;
    end else begin
        state <= nextstate;
    end
end

always @(*) begin
    nextstate = FETCH;
    case (state)
        FETCH:
            nextstate = DECODE;
        DECODE: begin
            case (instruction_opcode)
                LW: nextstate = MEMADR;
                SW: nextstate = MEMADR;
                RTYPE: nextstate = EXECUTER;
                ITYPE: nextstate = EXECUTEI;
                JALI: nextstate = JAL;
                BEQI: nextstate = BEQ;
                AUIPCI: nextstate = AUIPC;
                LUII: nextstate = LUI;
                JALRI: nextstate = JALR_PC;
                CSR: nextstate = EXECUTECSR;
            endcase
        end
        MEMADR: begin
            if(instruction_opcode == LW)
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
        JALR_PC: nextstate = JALR;
        JALR: nextstate = ALUWB;
        AUIPC: nextstate = ALUWB;
        LUI: nextstate = ALUWB;
        EXECUTECSR: nextstate = FETCH;
        default: nextstate = FETCH;
    endcase
end

always @(*) begin
    pc_write_cond = 1'b0;
    pc_write = 1'b0;
    lorD = 1'b0;
    memory_read = 1'b0;
    memory_write = 1'b0;
    memory_to_reg = 2'b00;
    ir_write = 1'b0;
    pc_source = 1'b0;
    aluop = 2'b00;
    alu_src_b = 2'b00;
    alu_src_a = 2'b00;
    reg_write = 1'b0;
    is_immediate = 1'b0;
    csr_write_enable = 1'b0;

    case (state)
        FETCH: begin
            memory_read = 1'b1;
            ir_write = 1'b1;
            alu_src_b = 2'b01;
            pc_write = 1'b1;
        end

        DECODE: begin
            alu_src_a = 2'b10;
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
            memory_to_reg = 2'b01;
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
            alu_src_a = 2'b10;
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

        JALR_PC: begin // Ciclo intermediario para calcular o endereço a ser gravado no PC
            alu_src_a = 2'b01;
            alu_src_b = 2'b10;
        end

        JALR: begin
            alu_src_a = 2'b10;
            alu_src_b = 2'b01; // 01
            pc_write = 1'b1;
            pc_source = 1'b1;
            is_immediate = 1'b1;
        end

        AUIPC: begin
            alu_src_a = 2'b10;
            alu_src_b = 2'b10;
        end

        LUI: begin
            alu_src_a = 2'b11;
            alu_src_b = 2'b10;
        end

        EXECUTECSR: begin
            reg_write = 1'b1;
            memory_to_reg = 2'b10;
            csr_write_enable = 1'b1;
        end
    endcase
end
    
endmodule
