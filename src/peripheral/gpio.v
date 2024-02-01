module GPIO (
    inout wire gpio,
    input wire data_in,
    input wire direction,
    output wire data_out
);

assign data_out = (gpio & direction) | (data_in & ~data_in);

always @(*) begin
    if(direction == 1'b0)
        gpio = data_in;
end
    
endmodule
