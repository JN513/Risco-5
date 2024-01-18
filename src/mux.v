module MUX (
    input wire option,
    input wire [31:0] A,
    input wire [31:0] B,
    output wire [31:0] S
);

assign S = (option == 1'b1) ? B : A;
    
endmodule
