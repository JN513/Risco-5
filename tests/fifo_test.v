module fifo_tb ();

reg clk, reset;

initial begin
    clk = 1'b0;
    reset = 1'b0;
end

always #1 clk = ~clk;

endmodule
