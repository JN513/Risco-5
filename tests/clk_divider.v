module clk_divider_tb ();

parameter COUNTER_BITS = 32;

wire clk_o;
reg option, out_enable, pulse, clk, reset;
reg [COUNTER_BITS - 1 : 0] divider;

initial begin
    $dumpfile("build/clk_divider.vcd");
    $dumpvars;

    clk = 0;
    reset = 0;
    option = 1'b1;
    out_enable = 1'b1;
    pulse = 1'b0;
    divider = 32'd10;
    /*
    #2
    reset = 1'b1;
    #2
    reset = 1'b0;
    */
    #30
    
    out_enable = 1'b0;

    #30

    out_enable = 1'b1;

    #40

    $finish;
end

always #1 clk = ~clk;

ClkDivider #(
    .COUNTER_BITS(COUNTER_BITS)
) ClkDivider(
    .clk(clk),
    .reset(reset),
    .option(option),
    .out_enable(out_enable),
    .divider(divider),
    .pulse(pulse),
    .clk_o(clk_o)
);
    
endmodule
