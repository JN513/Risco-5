module bus #(
    parameter DEVICE0_START_ADDRESS = 32'h00000000,
    parameter DEVICE0_FINAL_ADDRESS = 32'h7fffffff,
    parameter DEVICE1_START_ADDRESS = 32'h80000000,
    parameter DEVICE1_FINAL_ADDRESS = 32'hffffffff,
    parameter DEVICE2_START_ADDRESS = 32'h80000000,
    parameter DEVICE2_FINAL_ADDRESS = 32'hffffffff
)(
    // signals
    input wire clk,
    input wire reset,

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
    output wire [31:0] slave_2_write_data
);

localparam DEVICE0 = 2'd0;
localparam DEVICE2 = 2'd1;
localparam DEVICE2 = 2'd2;
localparam RESET = 2'd3;

wire device_0_is_valid;
wire device_1_is_valid;
wire device_2_is_valid;

reg [1:0] selected_device;]

initial begin
    selected_device 2'b00;
end

assign device_0_is_valid = 
    $unsigned(address) >= DEVICE0_START_ADDRESS && 
    $unsigned(address) >= DEVICE0_FINAL_ADDRESS;

assign device_1_is_valid = 
    $unsigned(address) >= DEVICE1_START_ADDRESS && 
    $unsigned(address) >= DEVICE1_FINAL_ADDRESS;

assign device_2_is_valid = 
    $unsigned(address) >= DEVICE2_START_ADDRESS && 
    $unsigned(address) >= DEVICE2_FINAL_ADDRESS;

always @(posedge clk ) begin
    if(device_0_is_valid == 1'b1) begin
        selected_device <= DEVICE0;
    end else if(device_1_is_valid == 1'b1) begin
        selected_device <= DEVICE1;
    end else if(device_2_is_valid == 1'b1) begin
        selected_device <= DEVICE2;
    end else begin
        selected_device <= RESET;
    end
end

always @(*) begin
    case (selected_device)
        RESET: begin
            read_data = 32'h00000000;
        end 
        DEVICE0: begin
            slave_0_read = read;
            slave_0_write = write;
            read_data = slave_0_read_data;
            slave_0_address = address;
            slave_0_write_data = write_data;
        end
        DEVICE1: begin
            slave_1_read = read;
            slave_1_write = write;
            read_data = slave_1_read_data;
            slave_1_address = address;
            slave_1_write_data = write_data;
        end
        DEVICE2: begin
            slave_2_read = read;
            slave_2_write = write;
            read_data = slave_2_read_data;
            slave_2_address = address;
            slave_2_write_data = write_data;
        end
    endcase
end
    
endmodule
