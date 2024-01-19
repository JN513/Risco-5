module MUX (
    input wire [1:0] option,
    input wire [31:0] A,
    input wire [31:0] B,
    input wire [31:0] C,
    input wire [31:0] D,
    output wire [31:0] S
);

always @(*) begin
    case (option)
        2'b00: S = A; 
        2'b01: S = B; 
        2'b10: S = C; 
        2'b11: S = D; 
        default: S = A;
    endcase
end
    
endmodule
