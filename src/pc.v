module PC(
    input wire clk,
    input wire [31:0] Input,
    output wire [31:0] Output,
    input wire inclement,
    input wire load,
    input wire reset
);

reg [31:0] PC_Register;

assign Output = PC_Register;

initial begin
    PC_Register = 32'd0;
end

always @(posedge clk) begin
    if(reset == 1'b1) begin
        PC_Register <= 32'd0;
    end
    else begin
        if(inclement == 1'b1) begin 
            PC_Register <= PC_Register + 1;
        end else if(load == 1'b1) begin
            PC_Register <= Input;
        end
    end 
end

endmodule
