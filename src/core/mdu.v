// Brief: Multiplier and Divider Unit
// Baseado no projeto: https://github.com/zeeshanrafique23/mdu

`include "config.vh"
`ifdef MDU_ENABLE
module MDU (
    input wire clk,
    input wire reset,
    input wire start,
    output wire done,
    input wire [2:0] operation,
    input wire [31:0] MDU_in_X,
    input wire [31:0] MDU_in_Y,
    output wire [31:0] MDU_out_S
);


localparam MUL             = 3'b000;
localparam MULH            = 3'b001;
localparam MULHSU          = 3'b010;
localparam MULHU           = 3'b011;
localparam DIV             = 3'b100;
localparam DIVU            = 3'b101;
localparam REM             = 3'b110;
localparam REMU            = 3'b111;

localparam IDLE    = 2'b00;
localparam OPERATE = 2'b01;
localparam FINISH  = 2'b10;

reg mul_done, div_done;
reg [1:0] state_mul, state_div;

reg [31:0] Data_X, Data_Y, MUL_RD;
reg [63:0] acumulador;

reg negativo;
reg [31:0] dividendo, quociente, quociente_msk, DIV_RD;
reg [63:0] divisor;

initial begin
    state_mul = 2'b00;
    state_div = 2'b00;
    acumulador = 0;
    Data_X = 0;
    Data_Y = 0;
    MUL_RD = 0;
end

always @(posedge clk) begin
    mul_done <= 1'b0;
    if(reset == 1'b1) begin
        Data_X <= 0;
        Data_Y <= 0;
        MUL_RD <= 0;
        state_mul <= IDLE;
    end else begin
        case (state_mul)
            IDLE: begin
                if(start & !operation[2]) begin
                    state_mul <= OPERATE;
                    if(operation[1]) begin
                        Data_X <= (operation[0]) ? $unsigned(MDU_in_X) : $signed(MDU_in_X);
                        Data_Y <= $unsigned(MDU_in_Y);
                    end else begin
                        Data_X <= $signed(MDU_in_X);
                        Data_Y <= $signed(MDU_in_Y);
                    end
                end else begin
                    state_mul <= IDLE;
                end
            end 
            OPERATE: begin
                acumulador <= $signed(MDU_in_X)*$signed(MDU_in_Y);
                state_mul <= FINISH;
            end

            FINISH: begin
                state_mul <= IDLE;
                MUL_RD <= (|operation) ? acumulador[63:32] : acumulador[31:0];
                mul_done <= 1'b1;
            end
            default: state_mul <= IDLE;
        endcase
    end
end

always @(posedge clk) begin
    div_done <= 1'b0;
    if(reset == 1'b1) begin
        state_div <= IDLE;
        quociente <= 32'h00000000;
    end else begin
        case (state_div)
            IDLE: begin
                if(start & operation[2]) begin // se não for multiplicação
                    dividendo <= (!operation[0] & MDU_in_X[31]) ? -MDU_in_X : MDU_in_X;
                    divisor <= {(!operation[0] & MDU_in_Y[31]) ? -MDU_in_Y : MDU_in_Y, 31'h00000000};
                    negativo <= (!operation[0] & !operation[1] & (MDU_in_X[31] != MDU_in_Y[31]) & 
                                (|MDU_in_Y)) | (operation[0] & operation[1] & MDU_in_X[31]);
                    quociente_msk <= 32'h80000000;
                    quociente <= 32'h00000000;
                    state_div <= OPERATE;
                end else begin
                    state_div <= IDLE;
                end
            end
            OPERATE: begin
                if(quociente_msk == 32'h00000001) begin
                    state_div <= FINISH;
                end else begin
                    state_div <= OPERATE;
                end

                if(divisor <= dividendo) begin
                    dividendo <= dividendo - divisor;
                    quociente <= quociente | quociente_msk;
                end

                divisor <= divisor >> 1;
                quociente_msk <= quociente_msk >> 1;
            end

            FINISH: begin
                div_done <= 1'b1;
                if(operation[2] & !operation[1]) begin
                    DIV_RD <= (negativo) ? -quociente : quociente;
                end else begin
                    DIV_RD <= (negativo) ? -dividendo : dividendo;
                end
                state_div <= IDLE;
            end
            default: state_div <= IDLE;
        endcase
    end
end

assign done = mul_done | div_done;
assign MDU_out_S = (operation[2] == 1'b0) ? MUL_RD : DIV_RD;

endmodule
`endif