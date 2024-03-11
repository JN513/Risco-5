module Memory #(
    parameter MEMORY_FILE = "",
    parameter MEMORY_SIZE = 4096
)(
    input wire clk,
    input wire reset,
    input wire memory_read,
    input wire memory_write,
    input wire [1:0] option,
    input wire [31:0] address,
    input wire [31:0] write_data,
    output reg [31:0] read_data
);

reg [31:0] memory [(MEMORY_SIZE/4)-1: 0];
wire [31:0] buffer;
integer i;

assign buffer = (memory_read == 1'b1) ? memory[{2'b00, address[31:2]}] : 32'h00000000;

initial begin
    `ifdef __ICARUS__
        for (i = 0; i < (MEMORY_SIZE/4)-1; i = i + 1) begin
            memory[i] = 32'h00000000; 
        end
    `endif

    if(MEMORY_FILE != "") begin
        $readmemh(MEMORY_FILE, memory, 0, (MEMORY_SIZE/4) - 1);
    end
end

always @(posedge clk) begin
    if(memory_write == 1'b1) begin
        if(option[0] == 1'b1) begin
            memory[{2'b00, address[31:2]}] <= {buffer[31:16], write_data[15:0]};
        end else if(option[1] == 1'b1) begin
            memory[{2'b00, address[31:2]}] <= write_data;
        end else begin
            memory[{2'b00, address[31:2]}] <= {buffer[31:8], write_data[7:0]};;
        end
    end
end

always @(*) begin
    case (option)
        2'b00: read_data = {24'h000000 ,buffer[7:0]};
        2'b01: read_data = {16'h0000 ,buffer[15:0]};
        2'b10: read_data = buffer;
        default: read_data = buffer;
    endcase
end
    
endmodule
