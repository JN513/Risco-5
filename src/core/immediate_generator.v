module Immediate_Generator (
    input wire [31:0] instruction,
    output reg [31:0] immediate
);


always @(*) begin
    case (instruction[6:0])
        7'b1100011: // SB type
            immediate = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0} - 4;
        7'b1101111: // UJ type JAL
            immediate = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0} -4;
        7'b0010111: // AUIPC U type
            immediate = {instruction[31:12], 12'h000};
        7'b0110111: // LUI U type
            immediate = {instruction[31:12], 12'h000};
        7'b0000011: // lw instruction 
            immediate = {20'h00000, instruction[31:20]};
        7'b0010011: // I type instruction 
            immediate = {{20{instruction[31]}}, instruction[31:20]};
        7'b1100111: // I type instruction JAL
            immediate = {{20{instruction[31]}}, instruction[31:20]};
        7'b1110011: // I type instruction  CSR
            immediate = {{20{instruction[31]}}, instruction[31:20]};
        7'b0100011: // sw instruction  (S type)
            immediate = {20'h00000, instruction[31:25], instruction[11:7]};
        default: immediate = 32'h00000000;
    endcase
end
    
endmodule
