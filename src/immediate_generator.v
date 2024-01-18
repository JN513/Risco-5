module Immediate_Generator (
    input wire [31:0] instruction,
    output wire [31:0] immediate
);

reg [31:0] immediate_reg;

assign immediate = immediate_reg;

always @(*) begin
    case (instruction[6:0])
        7'b1100011: // SB type
            immediate_reg = {20'h00000, instruction[31], instruction[7], instruction[30:25], instruction[11:8]};
        7'b1101111: // UJ type JAL
            immediate_reg = {11'h000, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
        7'b0010111: // AUIPC U type
            immediate_reg = {instruction[31:12], 12'h000};
        7'b0110111: // LUI U type
            immediate_reg = {instruction[31:12], 12'h000};
        7'b0010011: // addi instruction 
            immediate_reg = {20'h00000, instruction[31:20]};
        7'b0000011: // lw instruction 
            immediate_reg = {20'h00000, instruction[31:20]};
        7'b0010011: // I type instruction 
            immediate_reg = {20'h00000, instruction[31:20]};
        7'b1100111: // I type instruction JAL
            immediate_reg = {20'h00000, instruction[31:20]};
        7'b1110011: // I type instruction  CSR
            immediate_reg = {20'h00000, instruction[31:20]};
        7'b0100011: // sw instruction  (S type)
            immediate_reg = {20'h00000, instruction[31:25], instruction[11:7]};
        7'b1100011: // beq instruction 
            immediate_reg = {19'h00000, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
        default: immediate_reg = 32'h00000000;
    endcase
end
    
endmodule
