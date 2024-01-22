module ClkDivider #(
    parameter COUNTER_BITS = 32
)(
    input wire clk,
    input wire reset,
    input wire option, // 0 - pulse, 1 - auto
    input wire out_enable,
    input wire [COUNTER_BITS - 1:0] divider,
    input wire pulse,
    output wire clk_o
);

reg clk_o_pulse, clk_o_auto;
reg [COUNTER_BITS - 1:0] clk_counter;

assign clk_o = (out_enable == 1'b1) ? (option == 1'b0) ? 
    clk_o_pulse : clk_o_auto : 1'b0;

initial begin
    clk_counter = 0;
    clk_o_pulse = 0;
    clk_o_auto = 0;
end

always @(posedge clk ) begin
    if(reset == 1'b1) begin
        clk_counter <= 0;
        clk_o_auto <= 0;
    end else begin
        if(clk_counter == 0) begin
            clk_o_auto <= 1'b1;
            clk_counter <= clk_counter + 1;
        end else if(clk_counter == divider /2) begin 
            clk_o_auto <= 1'b0;
            clk_counter <= clk_counter + 1;
        end else begin
            clk_counter <= clk_counter + 1;
        end

        if(clk_counter == divider - 1) begin
            clk_counter <= 0;
        end
    end
end

always @(posedge pulse ) begin
    clk_o_pulse = ~clk_o_pulse;
end

endmodule
