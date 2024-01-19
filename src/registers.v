module Registers (
    input wire clk,
    input wire reset,
    input wire regWrite,
    input wire [4:0] readRegister1,
    input wire [4:0] readRegister2,
    input wire [4:0] writeRegister,
    input wire [31:0] writeData,
    output reg [31:0] readData1,
    output reg [31:0] readData2
);

reg [31:0] register0;
reg [31:0] register1;
reg [31:0] register2;
reg [31:0] register3;
reg [31:0] register4;
reg [31:0] register5;
reg [31:0] register6;
reg [31:0] register7;
reg [31:0] register8;
reg [31:0] register9;
reg [31:0] register10;
reg [31:0] register11;
reg [31:0] register12;
reg [31:0] register13;
reg [31:0] register14;
reg [31:0] register15;
reg [31:0] register16;
reg [31:0] register17;
reg [31:0] register18;
reg [31:0] register19;
reg [31:0] register20;
reg [31:0] register21;
reg [31:0] register22;
reg [31:0] register23;
reg [31:0] register24;
reg [31:0] register25;
reg [31:0] register26;
reg [31:0] register27;
reg [31:0] register28;
reg [31:0] register29;
reg [31:0] register30;
reg [31:0] register31;

initial begin
    register0  = 32'd0;
    register1  = 32'd0;
    register2  = 32'd0;
    register3  = 32'd0;
    register4  = 32'd0;
    register5  = 32'd0;
    register6  = 32'd0;
    register7  = 32'd0;
    register8  = 32'd0;
    register9  = 32'd0;
    register10 = 32'd0;
    register11 = 32'd0;
    register12 = 32'd0;
    register13 = 32'd0;
    register14 = 32'd0;
    register15 = 32'd0;
    register16 = 32'd0;
    register17 = 32'd0;
    register18 = 32'd0;
    register19 = 32'd0;
    register20 = 32'd0;
    register21 = 32'd0;
    register22 = 32'd0;
    register23 = 32'd0;
    register24 = 32'd0;
    register25 = 32'd0;
    register26 = 32'd0;
    register27 = 32'd0;
    register28 = 32'd0;
    register29 = 32'd0;
    register30 = 32'd0;
    register31 = 32'd0;
end

always @(*) begin
    case (readRegister1)
        5'b00000: readData1 = register0;
        5'b00001: readData1 = register1;
        5'b00010: readData1 = register2;
        5'b00011: readData1 = register3;
        5'b00100: readData1 = register4;
        5'b00101: readData1 = register5;
        5'b00110: readData1 = register6;
        5'b00111: readData1 = register7;
        5'b01000: readData1 = register8;
        5'b01001: readData1 = register9;
        5'b01010: readData1 = register10;
        5'b01011: readData1 = register11;
        5'b01100: readData1 = register12;
        5'b01101: readData1 = register13;
        5'b01110: readData1 = register14;
        5'b01111: readData1 = register15;
        5'b10000: readData1 = register16;
        5'b10001: readData1 = register17;
        5'b10010: readData1 = register18;
        5'b10011: readData1 = register19;
        5'b10100: readData1 = register20;
        5'b10101: readData1 = register21;
        5'b10110: readData1 = register22;
        5'b10111: readData1 = register23;
        5'b11000: readData1 = register24;
        5'b11001: readData1 = register25;
        5'b11010: readData1 = register26;
        5'b11011: readData1 = register27;
        5'b11100: readData1 = register28;
        5'b11101: readData1 = register29;
        5'b11110: readData1 = register30;
        5'b11111: readData1 = register31;
        default: readData1 = 32'd0;
    endcase

    case (readRegister2)
        5'b00000: readData2 = register0;
        5'b00001: readData2 = register1;
        5'b00010: readData2 = register2;
        5'b00011: readData2 = register3;
        5'b00100: readData2 = register4;
        5'b00101: readData2 = register5;
        5'b00110: readData2 = register6;
        5'b00111: readData2 = register7;
        5'b01000: readData2 = register8;
        5'b01001: readData2 = register9;
        5'b01010: readData2 = register10;
        5'b01011: readData2 = register11;
        5'b01100: readData2 = register12;
        5'b01101: readData2 = register13;
        5'b01110: readData2 = register14;
        5'b01111: readData2 = register15;
        5'b10000: readData2 = register16;
        5'b10001: readData2 = register17;
        5'b10010: readData2 = register18;
        5'b10011: readData2 = register19;
        5'b10100: readData2 = register20;
        5'b10101: readData2 = register21;
        5'b10110: readData2 = register22;
        5'b10111: readData2 = register23;
        5'b11000: readData2 = register24;
        5'b11001: readData2 = register25;
        5'b11010: readData2 = register26;
        5'b11011: readData2 = register27;
        5'b11100: readData2 = register28;
        5'b11101: readData2 = register29;
        5'b11110: readData2 = register30;
        5'b11111: readData2 = register31;
        default: readData2 = 32'd0;
    endcase
end



always @(posedge clk) begin
    if(reset == 1'b1) begin
        register0  <= 32'd0;
        register1  <= 32'd0;
        register2  <= 32'd0;
        register3  <= 32'd0;
        register4  <= 32'd0;
        register5  <= 32'd0;
        register6  <= 32'd0;
        register7  <= 32'd0;
        register8  <= 32'd0;
        register9  <= 32'd0;
        register10 <= 32'd0;
        register11 <= 32'd0;
        register12 <= 32'd0;
        register13 <= 32'd0;
        register14 <= 32'd0;
        register15 <= 32'd0;
        register16 <= 32'd0;
        register17 <= 32'd0;
        register18 <= 32'd0;
        register19 <= 32'd0;
        register20 <= 32'd0;
        register21 <= 32'd0;
        register22 <= 32'd0;
        register23 <= 32'd0;
        register24 <= 32'd0;
        register25 <= 32'd0;
        register26 <= 32'd0;
        register27 <= 32'd0;
        register28 <= 32'd0;
        register29 <= 32'd0;
        register30 <= 32'd0;
        register31 <= 32'd0;
    end else if (regWrite == 1'b1) begin
        case (writeRegister)
            5'b00000: register0  <= writeData;
            5'b00001: register1  <= writeData;
            5'b00010: register2  <= writeData;
            5'b00011: register3  <= writeData;
            5'b00100: register4  <= writeData;
            5'b00101: register5  <= writeData;
            5'b00110: register6  <= writeData;
            5'b00111: register7  <= writeData;
            5'b01000: register8  <= writeData;
            5'b01001: register9  <= writeData;
            5'b01010: register10 <= writeData;
            5'b01011: register11 <= writeData;
            5'b01100: register12 <= writeData;
            5'b01101: register13 <= writeData;
            5'b01110: register14 <= writeData;
            5'b01111: register15 <= writeData;
            5'b10000: register16 <= writeData;
            5'b10001: register17 <= writeData;
            5'b10010: register18 <= writeData;
            5'b10011: register19 <= writeData;
            5'b10100: register20 <= writeData;
            5'b10101: register21 <= writeData;
            5'b10110: register22 <= writeData;
            5'b10111: register23 <= writeData;
            5'b11000: register24 <= writeData;
            5'b11001: register25 <= writeData;
            5'b11010: register26 <= writeData;
            5'b11011: register27 <= writeData;
            5'b11100: register28 <= writeData;
            5'b11101: register29 <= writeData;
            5'b11110: register30 <= writeData;
            5'b11111: register31 <= writeData;
            default: register0 <= 32'b0;
        endcase
    end
end

endmodule
