module BUS #(
    parameter DEVICE0_START_ADDRESS = 32'h00000000,
    parameter DEVICE0_FINAL_ADDRESS = 32'h00000FFF,
    parameter DEVICE1_START_ADDRESS = 32'h00001000,
    parameter DEVICE1_FINAL_ADDRESS = 32'h00001002,
    parameter DEVICE2_START_ADDRESS = 32'h00001003,
    parameter DEVICE2_FINAL_ADDRESS = 32'h000013BA,
    parameter DEVICE3_START_ADDRESS = 32'h000013BB,
    parameter DEVICE3_FINAL_ADDRESS = 32'h000013BE
)(
    // master connection
    input wire read,
    input wire write,
    input wire [31:0] address,
    input wire [31:0] write_data,
    output wire [31:0] read_data,

    // slave 0 signal
    output wire slave_0_read,
    output wire slave_0_write,
    input wire [31:0] slave_0_read_data,
    output wire [31:0] slave_0_address,
    output wire [31:0] slave_0_write_data,

    // slave 1 signal
    output wire slave_1_read,
    output wire slave_1_write,
    input wire [31:0] slave_1_read_data,
    output wire [31:0] slave_1_address,
    output wire [31:0] slave_1_write_data,

    // slave 2 signal
    output wire slave_2_read,
    output wire slave_2_write,
    input wire [31:0] slave_2_read_data,
    output wire [31:0] slave_2_address,
    output wire [31:0] slave_2_write_data,

    // slave 3 signal
    output wire slave_3_read,
    output wire slave_3_write,
    input wire [31:0] slave_3_read_data,
    output wire [31:0] slave_3_address,
    output wire [31:0] slave_3_write_data
);

localparam DEVICE0 = 2'd0;
localparam DEVICE1 = 2'd1;
localparam DEVICE2 = 2'd2;
localparam DEVICE3 = 2'd2;
localparam RESET = 2'd4;

assign slave_0_read = (address >= DEVICE0_START_ADDRESS && 
    address <= DEVICE0_FINAL_ADDRESS) ? read : 1'b0;
assign slave_1_read = (address >= DEVICE1_START_ADDRESS && 
    address <= DEVICE1_FINAL_ADDRESS) ? read : 1'b0;
assign slave_2_read = (address >= DEVICE2_START_ADDRESS && 
    address <= DEVICE2_FINAL_ADDRESS) ? read : 1'b0;
assign slave_3_read = (address >= DEVICE3_START_ADDRESS && 
    address <= DEVICE3_FINAL_ADDRESS) ? read : 1'b0;

assign slave_0_write = (address >= DEVICE0_START_ADDRESS && 
    address <= DEVICE0_FINAL_ADDRESS) ? write : 1'b0;
assign slave_1_write = (address >= DEVICE1_START_ADDRESS && 
    address <= DEVICE1_FINAL_ADDRESS) ? write : 1'b0;
assign slave_2_write = (address >= DEVICE2_START_ADDRESS && 
    address <= DEVICE2_FINAL_ADDRESS) ? write : 1'b0;
assign slave_3_write = (address >= DEVICE3_START_ADDRESS && 
    address <= DEVICE3_FINAL_ADDRESS) ? write : 1'b0;

assign slave_0_write_data = (address >= DEVICE0_START_ADDRESS && 
    address <= DEVICE0_FINAL_ADDRESS) ? write_data : 32'h00000000;
assign slave_1_write_data = (address >= DEVICE1_START_ADDRESS && 
    address <= DEVICE1_FINAL_ADDRESS) ? write_data : 32'h00000000;
assign slave_2_write_data = (address >= DEVICE2_START_ADDRESS && 
    address <= DEVICE2_FINAL_ADDRESS) ? write_data : 32'h00000000;
assign slave_3_write_data = (address >= DEVICE3_START_ADDRESS && 
    address <= DEVICE3_FINAL_ADDRESS) ? write_data : 32'h00000000;

assign slave_0_address = (address >= DEVICE0_START_ADDRESS && 
    address <= DEVICE0_FINAL_ADDRESS) ? address : 32'h00000000;
assign slave_1_address = (address >= DEVICE1_START_ADDRESS && 
    address <= DEVICE1_FINAL_ADDRESS) ? address : 32'h00000000;
assign slave_2_address = (address >= DEVICE2_START_ADDRESS && 
    address <= DEVICE2_FINAL_ADDRESS) ? address : 32'h00000000;
assign slave_3_address = (address >= DEVICE3_START_ADDRESS && 
    address <= DEVICE3_FINAL_ADDRESS) ? address : 32'h00000000;
    
assign read_data = (address >= DEVICE0_START_ADDRESS && 
    address <= DEVICE0_FINAL_ADDRESS) ? slave_0_read_data : (address >= DEVICE1_START_ADDRESS && 
    address <= DEVICE1_FINAL_ADDRESS) ? slave_1_read_data : (address >= DEVICE2_START_ADDRESS && 
    address <= DEVICE2_FINAL_ADDRESS) ? slave_2_read_data : slave_3_read_data;

endmodule
