module BUS (
    // master connection
    input wire read,
    input wire write,
    input wire [31:0] address,
    input wire [31:0] write_data,
    output wire [31:0] read_data,
    output wire response,

    // slave 0 signal
    output wire slave_0_read,
    output wire slave_0_write,
    input wire [31:0] slave_0_read_data,
    output wire [31:0] slave_0_address,
    output wire [31:0] slave_0_write_data,
    input wire slave_0_response,

    // slave 1 signal
    output wire slave_1_read,
    output wire slave_1_write,
    input wire [31:0] slave_1_read_data,
    output wire [31:0] slave_1_address,
    output wire [31:0] slave_1_write_data,
    input wire slave_1_response,

    // slave 2 signal
    output wire slave_2_read,
    output wire slave_2_write,
    input wire [31:0] slave_2_read_data,
    output wire [31:0] slave_2_address,
    output wire [31:0] slave_2_write_data,
    input wire slave_2_response,

    // slave 3 signal
    output wire slave_3_read,
    output wire slave_3_write,
    input wire [31:0] slave_3_read_data,
    output wire [31:0] slave_3_address,
    output wire [31:0] slave_3_write_data,
    input wire slave_3_response
);

localparam DEVICE0 = 3'd0; // 00
localparam DEVICE1 = 3'd1; // 01
localparam DEVICE2 = 3'd2; // 10
localparam DEVICE3 = 3'd3; // 11

assign slave_0_read = (address[31:30] == 2'b00) ? read : 1'b0;
assign slave_0_write = (address[31:30] == 2'b00) ? write : 1'b0;
assign slave_0_write_data = write_data;
assign slave_0_address = address;

assign slave_1_read = (address[31:30] == 2'b01) ? read : 1'b0;
assign slave_1_write = (address[31:30] == 2'b01) ? write : 1'b0;
assign slave_1_write_data = write_data;
assign slave_1_address = address;

assign slave_2_read = (address[31:30] == 2'b10) ? read : 1'b0;
assign slave_2_write = (address[31:30] == 2'b10) ? write : 1'b0;
assign slave_2_write_data = write_data;
assign slave_2_address = address;

assign slave_3_read = (address[31:30] == 2'b11) ? read : 1'b0;
assign slave_3_write = (address[31:30] == 2'b11) ? write : 1'b0;
assign slave_3_write_data = write_data;
assign slave_3_address = address;

assign read_data = (address[31:30] == 2'b00) ? slave_0_read_data :
    (address[31:30] == 2'b01) ? slave_1_read_data : (address[31:30] == 2'b10) ?
    slave_2_read_data : slave_3_read_data;

assign response = (address[31:30] == 2'b00) ? slave_0_response :
    (address[31:30] == 2'b01) ? slave_1_response : (address[31:30] == 2'b10) ?
    slave_2_response : slave_3_response;

endmodule
