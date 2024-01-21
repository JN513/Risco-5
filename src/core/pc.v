module PC #(
    parameter BOOT_ADDRESS=32'h00000000
)(
    input wire clk,
    input wire load,
    input wire reset,
    input wire [31:0] Input,
    output wire [31:0] Output
);

reg [31:0] PC_Register;

assign Output = PC_Register;

initial begin
    PC_Register = BOOT_ADDRESS;
end

always @(posedge clk) begin
    if(reset == 1'b1) begin
        PC_Register = BOOT_ADDRESS;
    end else begin
        if(load == 1'b1) begin
            PC_Register <= Input;
        end
    end 
end

endmodule
