module Instruction_Memory #(
    parameter MEMORY_SIZE = 1024,
    parameter MEMORY_FILE = ""
)
(
    input wire reset,
    input wire [31:0] read_address,
    output wire [31:0] instruction_out
);

reg [31:0] memory[(MEMORY_SIZE/4)-1:0];
wire [31:0] normalized_address;

assign instruction_out = memory[read_address];

integer i;

initial begin
    if(MEMORY_FILE != "") begin
        $readmemh(MEMORY_FILE, memory, 0, 14);
    end
end
    
endmodule
