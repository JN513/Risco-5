`include "config.vh"
`ifdef GPIO_ENABLE

module GPIOS #(
    parameter WIDHT = 20
) (
    input wire clk,
    input wire reset,
    input wire read,
    input wire write,
    input wire [31:0] address,
    input wire [31:0] write_data,
    output wire [31:0] read_data,
    output wire response,
    inout [WIDHT - 1:0] gpios
);

assign response = read | write;
reg [WIDHT - 1:0] gpio_direction, gpio_value;
wire [WIDHT -1:0] gpio_out;
wire [1:0] pwm_out;
reg [1:0] is_pwm;

reg [15:0] duty_cycle[1:0];
reg [15:0] period[1:0];

initial begin
    is_pwm = 2'b00;
end

localparam SET_DIRECTION = 8'h00;
localparam WRITE_DATA = 8'h04;
localparam CONFIG_PWM = 8'h08;
localparam CONFIG_PERIOD = 8'h0C;
localparam CONFIG_DUTY_CYCLE = 8'h10;

assign read_data = (read == 1'b1) ? gpio_out : 32'h00000000;

GPIO Gpios[WIDHT - 1:0](
    .gpio(gpios),
    .direction({gpio_direction[WIDHT - 1: 2], gpio_direction[1:0] & ~is_pwm}),
    .data_in({gpio_value[WIDHT - 1: 2], 
    (gpio_value[1:0] & ~is_pwm) | (pwm_out[1:0] & is_pwm)}),
    .data_out(gpio_out)
);

PWM Pwm0(
    .clk(clk),
    .reset(reset),
    .duty_cycle(duty_cycle[0]),
    .period(period[0]),
    .pwm_out(pwm_out[0])
);

PWM Pwm1(
    .clk(clk),
    .reset(reset),
    .duty_cycle(duty_cycle[1]),
    .period(period[1]),
    .pwm_out(pwm_out[1])
);

always @(posedge clk) begin
    if(reset) begin
        gpio_direction <= 32'h00000000;
        gpio_value <= 32'h00000000;
    end else if(write) begin
        case (address[7:0])
            SET_DIRECTION: gpio_direction <= write_data[WIDHT - 1: 0];
            WRITE_DATA: gpio_value <= write_data[WIDHT - 1: 0];
            CONFIG_PWM: is_pwm <= write_data[1:0];
            CONFIG_PERIOD: period[write_data[16]] <= write_data[15:0];
            CONFIG_DUTY_CYCLE: duty_cycle[write_data[16]] <= write_data[15:0];
        endcase
    end
end
    
endmodule

`endif