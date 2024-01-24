module top (
    input wire clk,
    input wire reset,
    input wire rx,
    output wire tx,
    output wire [7:0]led
);

reg reset_bousing;

Risco_5_SOC #(
    .MEMORY_SIZE(4096),
    .MEMORY_FILE("../../software/memory/teste_led.hex"),
) SOC(
    .clk(clk),
    .reset(reset),
    .leds(led)
);

reg [8:0]counter;

initial begin
    reset_bousing = 1'b1;
    counter = 8'h00;
end

always @(posedge clk ) begin
    if(counter < 8'd255) begin
        counter <= counter + 1'b1;
    end else begin
        reset_bousing <= 1'b0;
    end
end

endmodule
