`include "config.vh"

`ifdef GPIO_ENABLE

module PWM (
    input wire clk,
    input wire reset,
    input wire [15:0] duty_cycle, // duty cycle = period * duty_cycle / 65536
    input wire [15:0] period, // clk_freq / pwm_freq = period
    output reg pwm_out
);

reg [31:0] counter;

always @(posedge clk) begin
    if (reset) begin
        counter <= 0;

    end else begin
        if(counter < period - 1'b1) begin
            counter <= counter + 1'b1;
        end else begin
            counter <= 0;
        end
    end

    if (counter < duty_cycle) begin
        pwm_out <= 1;
    end else begin
        pwm_out <= 0;
    end
end
    
endmodule

`endif