module UART #(
    parameter CLOCK_FREQ = 25000000,
    parameter BIT_RATE =   9600,
    parameter PAYLOAD_BITS = 8,
    parameter DEVICE_START_ADDRESS = 32'h00001003,
    parameter DEVICE_FINAL_ADDRESS = 32'h00001005
) (
    input wire clk,
    input wire reset,
    input wire rx,
    output wire tx,
    input wire read,
    input wire write,
    input wire [31:0] address,
    input wire [31:0] write_data,
    output wire [31:0] read_data
);

wire [PAYLOAD_BITS-1:0]  uart_rx_data;
wire uart_rx_valid, uart_rx_break, uart_tx_busy;
reg uart_tx_en;
reg [PAYLOAD_BITS-1:0] uart_tx_data;

assign read_data = (read == 1'b1) ? {24'h000000 , uart_rx_data} : 32'h00000000;

initial begin
    uart_tx_en = 1'b0;
    uart_tx_data = 8'h00;
end

always @(posedge clk ) begin
    uart_tx_en <= write;
    uart_tx_data <= write_data[7:0];
end

// UART RX
uart_tool_rx #(
    .BIT_RATE(BIT_RATE),
    .PAYLOAD_BITS(PAYLOAD_BITS),
    .CLK_HZ  (CLOCK_FREQ  )
) i_uart_rx(
    .clk          (clk          ), // Top level system clock input.
    .resetn       (~reset           ), // Asynchronous active low reset.
    .uart_rxd     (rx    ), // UART Recieve pin.
    .uart_rx_en   (1'b1         ), // Recieve enable
    .uart_rx_break(uart_rx_break), // Did we get a BREAK message?
    .uart_rx_valid(uart_rx_valid), // Valid data recieved and available.
    .uart_rx_data (uart_rx_data )  // The recieved data.
);

//
// UART Transmitter module.
//
uart_tool_tx #(
    .BIT_RATE(BIT_RATE),
    .PAYLOAD_BITS(PAYLOAD_BITS),
    .CLK_HZ  (CLOCK_FREQ  )
) i_uart_tx(
    .clk          (clk          ),
    .resetn       (~reset             ),
    .uart_txd     (tx    ), // serial_tx
    .uart_tx_en   (uart_tx_en   ),
    .uart_tx_busy (uart_tx_busy ),
    .uart_tx_data (uart_tx_data ) 
);

endmodule