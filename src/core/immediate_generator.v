module Immediate_Generator (
    input wire [31:0] instruction,
    output reg [31:0] immediate
);


localparam LW_OPCODE        = 7'b0000011;
localparam SW_OPCODE        = 7'b0100011;
localparam JAL_OPCODE       = 7'b1101111;
localparam LUI_OPCODE       = 7'b0110111;
localparam CSR_OPCODE       = 7'b1110011;
localparam JALR_OPCODE      = 7'b1100111;
localparam AUIPC_OPCODE     = 7'b0010111;
localparam BRANCH_OPCODE    = 7'b1100011;
localparam IMMEDIATE_OPCODE = 7'b0010011;


always @(*) begin
    case (instruction[6:0])
        BRANCH_OPCODE: // SB type
            case (instruction[14:12])
                3'b110: immediate = {19'h00000, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
                3'b111: immediate = {19'h00000, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
                default: immediate = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
            endcase
        JAL_OPCODE: // UJ type JAL
            immediate = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
        AUIPC_OPCODE: // AUIPC U type
            immediate = {instruction[31:12], 12'h000};
        LUI_OPCODE: // LUI U type
            immediate = {instruction[31:12], 12'h000};
        LW_OPCODE: // lw instruction 
            immediate = {{20{instruction[31]}}, instruction[31:20]};
        IMMEDIATE_OPCODE: // I type instruction
            case (instruction[14:12])
                3'b001: immediate = {{27{instruction[24]}}, instruction[24:20]};
                3'b011: immediate = {20'h00000, instruction[31:20]};
                3'b101: begin
                    if(instruction[30] == 1'b1) 
                        immediate = {{27'h0000000}, instruction[24:20]};
                    else
                        immediate = {{27{instruction[24]}}, instruction[24:20]};
                end
                default: immediate = {{20{instruction[31]}}, instruction[31:20]};
            endcase
        JALR_OPCODE: // I type instruction JALR
            immediate = {{20{instruction[31]}}, instruction[31:20]};
        CSR_OPCODE: // I type instruction  CSR
            immediate = {20'h00000, instruction[31:20]};
        SW_OPCODE: // sw instruction  (S type)
            immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
        default: immediate = 32'h00000000;
    endcase
end
    
endmodule
