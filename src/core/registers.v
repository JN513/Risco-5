module Registers (
    input wire clk,
    input wire reset,
    input wire regWrite,
    input wire [4:0] readRegister1,
    input wire [4:0] readRegister2,
    input wire [4:0] writeRegister,
    input wire [31:0] writeData,
    output wire [31:0] readData1,
    output wire [31:0] readData2
);

reg [31:0] registers[0:31];

initial begin
    registers[0] = 32'h00000000;
end

assign readData1 = registers[readRegister1];
assign readData2 = registers[readRegister2];

always @(posedge clk) begin
    if(reset == 1'b1) begin
        registers[0] <= 32'd0;
    end else if (regWrite == 1'b1) begin
        registers[writeRegister] <= writeData;
    end else begin
        registers[0] <= 32'h00000000;
    end
end

endmodule
