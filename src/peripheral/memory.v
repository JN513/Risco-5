module Memory #(
    parameter MEMORY_FILE = "",
    parameter MEMORY_SIZE = 4096
)(
    input wire clk,
    input wire reset,
    input wire memory_read,
    input wire memory_write,
    input wire [31:0] address,
    input wire [31:0] write_data,
    output wire [31:0] read_data
);

reg [31:0] memory [(MEMORY_SIZE/4)-1: 0];
integer i;

wire [31:0] normalized_address;

assign read_data = (memory_read == 1'b1) ? memory[address] : 32'h00000000;

initial begin
    for (i = 0; i < (MEMORY_SIZE/4)-1; i = i + 1) begin
       memory[i] = 32'h00000000; 
    end

    if(MEMORY_FILE != "") begin
        $readmemh(MEMORY_FILE, memory, 0, (MEMORY_SIZE/4) - 1);
    end
end

always @(posedge clk) begin
    /*if(reset == 1'b1) begin 
        for (i = 0; i < (MEMORY_SIZE/4)-1; i = i +1) begin
        memory[i] <= 32'h00000000;
    end
    end else*/ if(memory_write == 1'b1) begin
        memory[address] <= write_data;
    end
end
    
endmodule
