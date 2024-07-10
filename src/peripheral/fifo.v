`include "config.vh"
`ifdef UART_ENABLE

module FIFO #(
    parameter DEPTH = 8,
    parameter WIDTH = 8
) (
    input wire clk,
    input wire reset,
    input wire write,
    input wire read,
    input wire [WIDTH-1:0] write_data,
    output wire full,
    output wire empty,
    output wire [WIDTH-1:0] read_data
);

reg [5:0] counter;
reg [WIDTH-1:0] memory[DEPTH-1:0];
reg [5:0] read_ptr;
reg [5:0] write_ptr;

assign read_data = memory[read_ptr];

initial begin
    counter = 6'd0;
    read_ptr = 6'd0;
    write_ptr = 6'd0;
end

always @(posedge clk) begin
    if(reset == 1'b1) begin
        counter <= 6'd0;
        read_ptr <= 6'd0;
        write_ptr <= 6'd0;
    end else begin
        if (write && full == 1'b0) begin
            counter <= counter + 1'b1;
            memory[write_ptr] <= write_data;
            write_ptr <= (write_ptr == DEPTH-1) ? 6'd0 : write_ptr + 1'b1;
        end else if (read && empty == 1'b0) begin
            counter <= counter - 1'b1;
            read_ptr <= (read_ptr == DEPTH-1) ? 'd0 : read_ptr + 1'b1;
        end
    end
end

assign full = (counter == DEPTH) ? 1'b1 : 1'b0;
assign empty = (counter == 0) ? 1'b1 : 1'b0;
    
endmodule

`endif