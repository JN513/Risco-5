module UART #(
    parameter CLK_FREQ     = 25000000,
    parameter BIT_RATE     = 9600,
    parameter PAYLOAD_BITS = 8,
    parameter BUFFER_SIZE  = 8,
    parameter WORD_SIZE_BY = 1
) (
    input wire clk,
    input wire reset,

    input wire rx,
    output wire tx,

    input wire read,
    input wire write,
    output reg response,

    input wire [31:0] address,
    input wire [31:0] write_data,
    output reg [31:0] read_data
);

wire uart_rx_valid, uart_rx_break, uart_tx_busy, tx_fifo_empty,
    rx_fifo_empty, tx_fifo_full, rx_fifo_full;
reg uart_tx_en, tx_fifo_read, tx_fifo_write, rx_fifo_read, 
    rx_fifo_write;
wire [PAYLOAD_BITS-1:0]  uart_rx_data, tx_fifo_read_data, 
    rx_fifo_read_data;
reg [PAYLOAD_BITS-1:0] uart_tx_data, tx_fifo_write_data, 
    rx_fifo_write_data;

reg [31:0] write_data_buffer;

reg [2:0] counter;
reg [3:0] state;

initial begin
    response           = 1'b0;
    uart_tx_en         = 1'b0;
    tx_fifo_read       = 1'b0;
    tx_fifo_write      = 1'b0;
    rx_fifo_read       = 1'b0;
    rx_fifo_write      = 1'b0;
    counter            = 2'b00;
    state              = 3'b00;
    uart_tx_data       = 8'h00;
    tx_fifo_write_data = 8'h00;
    rx_fifo_write_data = 8'h00;
    read_data          = 32'h00000000;
end

localparam IDLE               = 4'b0000;
localparam READ               = 4'b0001;
localparam WRITE              = 4'b0010;
localparam FINISH             = 4'b0011;
localparam COPY_WRITE_BUFFER  = 4'b0100;
localparam WB                 = 4'b0101;
localparam READ_RX_FIFO_EMPTY = 4'b0110;
localparam READ_TX_FIFO_EMPTY = 4'b0111;
localparam READ_RX_FIFO_FULL  = 4'b1000;
localparam READ_TX_FIFO_FULL  = 4'b1001;


always @(posedge clk ) begin
    response <= 1'b0;
    rx_fifo_read <= 1'b0;
    tx_fifo_write <= 1'b0;

    if(reset == 1'b1) begin
        state              <= IDLE;
        tx_fifo_write      <= 1'b0;
        rx_fifo_read       <= 1'b0;
        state              <= 3'h0;
        tx_fifo_write_data <= 8'h00;
        read_data          <= 32'h00000000;
        write_data_buffer  <= 32'h00000000;
    end else begin
        case (state)
            IDLE: begin
                counter <= 2'b00;
                if(write) begin
                    state <= COPY_WRITE_BUFFER;
                end else if(read) begin
                    case (address[4:2])
                        3'b000: state <= READ;
                        3'b001: state <= READ_RX_FIFO_EMPTY;
                        3'b010: state <= READ_TX_FIFO_EMPTY;
                        3'b011: state <= READ_RX_FIFO_FULL;
                        3'b100: state <= READ_TX_FIFO_FULL;
                        default: state <= READ;
                    endcase
                end else begin
                    state <= IDLE;
                end
            end 
            READ: begin
                if(counter != (WORD_SIZE_BY)) begin
                    if(rx_fifo_empty == 1'b0) begin
                       counter <= counter + 1'b1;
                       rx_fifo_read <= 1'b1;
                       read_data <= {read_data[24:0], rx_fifo_read_data};
                    end
                end else begin
                    state <= WB;
                end
            end
            COPY_WRITE_BUFFER: begin
                write_data_buffer <= write_data;
                state <= WRITE;
            end

            WRITE: begin
                if(counter != (WORD_SIZE_BY)) begin
                    if(tx_fifo_full == 1'b0) begin
                       counter <= counter + 1'b1;
                       tx_fifo_write <= 1'b1;
                       tx_fifo_write_data <= write_data_buffer[7:0];
                       write_data_buffer <= {8'h00, write_data_buffer[31:8]};
                    end
                end else begin
                    state <= WB;
                end
            end
            READ_RX_FIFO_EMPTY: begin
                read_data <= {31'h00000000, rx_fifo_empty};
                state <= WB;
            end

            READ_TX_FIFO_EMPTY: begin
                read_data <= {31'h00000000, tx_fifo_empty};
                state <= WB;
            end

            READ_RX_FIFO_FULL: begin
                read_data <= {31'h00000000, rx_fifo_full};
                state <= WB;
            end

            READ_TX_FIFO_FULL: begin
                read_data <= {31'h00000000, tx_fifo_full};
                state <= WB;
            end

            WB: begin
                response <= 1'b1;
                state <= FINISH;
            end

            FINISH: begin
                state    <= IDLE;
            end

            default: state <= IDLE; 
        endcase
    end
end

always @(posedge clk) begin
    uart_tx_en <= 1'b0;
    tx_fifo_read <= 1'b0;
    rx_fifo_write <= 1'b0;

    if(reset == 1'b1) begin
        uart_tx_en         <= 1'b0;
        tx_fifo_read       <= 1'b0;
        uart_tx_data       <= 8'h00;
        rx_fifo_write_data <= 8'h00;
        rx_fifo_write      <= 1'b0;
    end else begin
        if(uart_tx_busy == 1'b0 && tx_fifo_empty == 1'b0) begin
            uart_tx_en   <= 1'b1;
            uart_tx_data <= tx_fifo_read_data;
            tx_fifo_read <= 1'b1;
        end

        if(rx_fifo_full == 1'b0 && uart_rx_valid == 1'b1) begin
            rx_fifo_write_data <= uart_rx_data;
            rx_fifo_write      <= 1'b1;
        end
    end 
end

FIFO #(
    .DEPTH(BUFFER_SIZE),
    .WIDTH(PAYLOAD_BITS)
) TX_FIFO (
    .clk(clk),
    .reset(reset),
    .write(tx_fifo_write),
    .read(tx_fifo_read),
    .write_data(tx_fifo_write_data),
    .full(tx_fifo_full),
    .empty(tx_fifo_empty),
    .read_data(tx_fifo_read_data)
);

FIFO #(
    .DEPTH(BUFFER_SIZE),
    .WIDTH(PAYLOAD_BITS)
) RX_FIFO (
    .clk(clk),
    .reset(reset),
    .write(rx_fifo_write),
    .read(rx_fifo_read),
    .write_data(rx_fifo_write_data),
    .full(rx_fifo_full),
    .empty(rx_fifo_empty),
    .read_data(rx_fifo_read_data)
);

// UART RX
uart_tool_rx #(
    .BIT_RATE(BIT_RATE),
    .PAYLOAD_BITS(PAYLOAD_BITS),
    .CLK_HZ(CLK_FREQ)
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
    .CLK_HZ(CLK_FREQ)
) i_uart_tx(
    .clk          (clk          ),
    .resetn       (~reset             ),
    .uart_txd     (tx    ), // serial_tx
    .uart_tx_en   (uart_tx_en   ),
    .uart_tx_busy (uart_tx_busy ),
    .uart_tx_data (uart_tx_data ) 
);
    
endmodule
