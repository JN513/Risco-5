module reset_tb ();

reg clk;
wire reset, resetn;

always #1 clk = ~clk;

ResetBootSystem #(
    .CYCLES(20)
) Reset(
    .clk(clk),
    .reset_o(reset),
    .resetn_o(resetn)
);

initial begin
    $dumpfile("build/reset.vcd");
    $dumpvars;

    clk = 1'b0;

    #60

    $finish;
end

endmodule
