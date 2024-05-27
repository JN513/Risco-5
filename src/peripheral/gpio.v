module GPIO (
    inout wire gpio,
    input wire data_in,
    input wire direction,
    output wire data_out
);

assign data_out = (gpio & direction) | (data_in & ~direction); // direction == 1 -> input, direction == 0 -> output
assign gpio = (direction == 1'b1) ? 1'bz : data_in;
    
endmodule
