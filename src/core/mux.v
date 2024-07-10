module MUX (
    input wire [2:0] option,
    input wire [31:0] A,
    input wire [31:0] B,
    input wire [31:0] C,
    input wire [31:0] D,
    input wire [31:0] E,
    input wire [31:0] F,
    input wire [31:0] G,
    input wire [31:0] H,
    output reg [31:0] S
);

always @(*) begin
    case (option)
        3'b000: S = A;
        3'b001: S = B;
        3'b010: S = C;
        3'b011: S = D;
        3'b100: S = E;
        3'b101: S = F;
        3'b110: S = G;
        3'b111: S = H;
        default: S = A;  // Caso padrão
    endcase
end

endmodule
