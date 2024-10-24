`include "config.vh"
module Core #(
    parameter BOOT_ADDRESS=32'h00000000
) (
    // Control signal
    input wire clk,
    input wire halt,
    input wire reset,

    // Memory BUS
    input wire memory_response,
    output wire memory_read,
    output wire memory_write,
    output wire [2:0] option,
    input  wire [31:0] read_data,
    output wire [31:0] address,
    output wire [31:0] write_data,

    // Interrupções
    input wire interruption_request_external,
    input wire interruption_request_timer,
    input wire interruption_request_software,
    input wire [15:0] interruption_request_fast
);

wire IRWrite, zero, reg_write, pc_load, and_zero_out,
    pc_write_cond, pc_write, is_immediate, csr_write_enable,
    alu_input_selector, save_address, control_memory_op,
    save_value, save_value_2, write_data_in, save_write_value,
    mdu_done, mdu_start;
wire [1:0] aluop, lorD;
wire [2:0] alu_src_a, alu_src_b, memory_to_reg, control_unit_memory_op;
wire [3:0] aluop_out, control_unit_aluop;
wire [31:0] pc_output, pc_input, register_input,
    alu_input_a, alu_input_b, alu_out, immediate, 
    register_data_1_out, register_data_2_out,
    csr_data_out, register_data_RD_out;
reg [31:0] instruction_register, memory_register, alu_out_register,
    register_data_1, register_data_2, pc_old;

`ifdef UNALIGNED_ENABLE

reg [31:0] temp_address, memory_saved_value,
    alu_saved_value, temp_write_value;

`endif

`ifdef MDU_ENABLE
wire [31:0] mdu_out;
reg [31:0] mdu_out_reg;
`endif

`ifdef UNALIGNED_ENABLE
assign write_data = (write_data_in == 1'b1)  ? temp_write_value : register_data_2;
`else
assign write_data = register_data_2;
`endif 

assign option = (lorD == 2'b00 | control_memory_op == 1'b1) 
    ? control_unit_memory_op : instruction_register[14:12];

initial begin
    instruction_register = 32'h00000000;
    memory_register      = 32'h00000000;
    register_data_1      = 32'h00000000;
    register_data_2      = 32'h00000000;
    alu_out_register     = 32'h00000000;
    pc_old               = 32'h00000000;
    `ifdef UNALIGNED_EN
    temp_address         = 32'h00000000;
    memory_saved_value   = 32'h00000000;
    temp_write_value     = 32'h00000000;
    `endif
end

PC Pc(
    .clk(clk),
    .reset(reset),
    .load(pc_load),
    .Input(pc_input),
    .Output(pc_output)
);

MUX MemoryAddressMUX(
    .option({1'b0, lorD}),
    .A(pc_output),
    .B(alu_out_register),
`ifdef UNALIGNED_EN
    .C(temp_address),
`endif
    .S(address)
);

MUX MemoryDataMUX(
    .option(memory_to_reg),
    .A(alu_out_register),
    .B(memory_register),
`ifdef CSR_ENABLE
    .C(csr_data_out),
`endif
    .D({16'h0000, alu_out_register[15:0]}),
    .E({24'h000000, alu_out_register[7:0]}),
    .F({{16{alu_out_register[15]}}, alu_out_register[15:0]}),
    .G({{24{alu_out_register[7]}}, alu_out_register[7:0]}),

    `ifdef MDU_ENABLE
        .H(mdu_out_reg),
    `else
        .H(0),
    `endif

    .S(register_input)
);

MUX AluInputAMUX(
    .option(alu_src_a),
    .A(pc_output),
    .B(register_data_1),
    .C(pc_old),
    .D(32'd0),
    .E(memory_register),
    .F(alu_out_register),

`ifdef UNALIGNED_ENABLE
    .G(temp_address),
    .H(memory_saved_value),
`endif
    .S(alu_input_a)
);

MUX AluInputBMUX(
    .option(alu_src_b),
    .A(register_data_2),
    .B(32'd4),
    .C(immediate),

`ifdef UNALIGNED_ENABLE
    .D(register_data_RD_out),
    .E({27'h00000, temp_address[1:0], 3'h0}),
    .F({26'h00000, 3'b100 - temp_address[1:0], 3'h0}),
    .G(alu_saved_value),
    .H({27'h00000, temp_address[1:0] + 1'b1, 3'h0}),
`endif

    .S(alu_input_b)
);

`ifdef MDU_ENABLE
MDU Mdu(
    .clk(clk),
    .reset(reset),
    .start(mdu_start),
    .done(mdu_done),
    .operation(instruction_register[14:12]),
    .MDU_in_X(register_data_1),
    .MDU_in_Y(register_data_2),
    .MDU_out_S(mdu_out)
);
`endif

// PC MUX
assign pc_input = (pc_output == 1'b1) ? alu_out_register : alu_out;
and(and_zero_out, zero, pc_write_cond);
or(pc_load, pc_write, and_zero_out);

Registers RegisterBank(
    .clk(clk),
    .reset(reset),
    .regWrite(reg_write),
    .readRegister1(instruction_register[19:15]),
    .readRegister2(instruction_register[24:20]),
    .writeRegister(instruction_register[11:7]),
    .writeData(register_input),
    .readData1(register_data_1_out),
    .readData2(register_data_2_out),
    .readDataRD(register_data_RD_out)
);

Control_Unit Control_Unit(
    .clk(clk),
    .reset(reset),
    .last_bits(alu_out[1:0]),

`ifdef UNALIGNED_ENABLE
    .last_bits_saved_address(temp_address[1:0]),
`endif

    .func3(instruction_register[14:12]),
    .instruction_opcode(instruction_register[6:0]),
    .pc_write_cond(pc_write_cond),
    .pc_write(pc_write),
    .lorD(lorD),
    .memory_read(memory_read),
    .memory_write(memory_write),
    .memory_to_reg(memory_to_reg),
    .ir_write(IRWrite),
    .pc_source(pc_source),
    .aluop(aluop),
    .alu_src_b(alu_src_b),
    .alu_src_a(alu_src_a),
    .reg_write(reg_write),
    .is_immediate(is_immediate),
    .csr_write_enable(csr_write_enable),
    .alu_input_selector(alu_input_selector),
    .control_unit_aluop(control_unit_aluop),
    .save_address(save_address),
    .control_unit_memory_op(control_unit_memory_op),
    .control_memory_op(control_memory_op),
    .save_value(save_value),
    .save_value_2(save_value_2),
    .write_data_in(write_data_in),
    .memory_response(memory_response),
    .save_write_value(save_write_value),
    .func7_lsb_bit(instruction_register[25]),
    .mdu_done(mdu_done),
    .mdu_start(mdu_start)
);

ALU_Control ALU_Control(
    .is_immediate(is_immediate),
    .aluop_in(aluop),
    .func7(instruction_register[31:25]),
    .func3(instruction_register[14:12]),
    .aluop_out(aluop_out)
);

`ifdef UNALIGNED_ENABLE
wire [3:0] aluop_res;

assign aluop_res = (alu_input_selector == 1'b1) ? control_unit_aluop : aluop_out;
`endif

Alu Alu(

    `ifdef UNALIGNED_ENABLE
    .operation(aluop_res),
    `else
    .operation(aluop_out),
    `endif
    .ALU_in_X(alu_input_a),
    .ALU_in_Y(alu_input_b),
    .ALU_out_S(alu_out),
    .ZR(zero)
);

Immediate_Generator Immediate_Generator(
    .instruction(instruction_register),
    .immediate(immediate)
);

`ifdef CSR_ENABLE
CSR_Unit CSR_Unit(
    .clk(clk),
    .reset(reset),
    .func3(instruction_register[14:12]),
    .csr_immediate(instruction_register[19:15]),
    .csr_write_enable(csr_write_enable),
    .csr_address(immediate[11:0]),
    .csr_data_in(register_data_1),
    .csr_data_out(csr_data_out),
    .interruption_request_external(interruption_request_external),
    .interruption_request_timer(interruption_request_timer),
    .interruption_request_software(interruption_request_software),
    .interruption_request_fast(interruption_request_fast),
    .pc_value(pc_old)
);
`endif

always @(posedge clk ) begin
    if(reset == 1'b1) begin
        instruction_register <= 32'h00000000;
        memory_register <= 32'h00000000;
        register_data_1 <= 32'h00000000;
        register_data_2 <= 32'h00000000;
        alu_out_register <= 32'h00000000;
        pc_old <= 32'h00000000;
        `ifdef UNALIGNED_EN
        temp_address <= 32'h00000000;
        memory_saved_value <= 32'h00000000;
        alu_saved_value <= 32'h00000000;
        temp_write_value <= 32'h00000000;
        `endif
    end else begin
        if(IRWrite == 1'b1)begin
            instruction_register <= read_data;
            pc_old <= pc_output;
        end
        `ifdef UNALIGNED_EN
        if(save_address == 1'b1) begin
            temp_address <= alu_out;
        end
        if(save_value == 1'b1) begin
            memory_saved_value <= memory_register;
        end
        if(save_value_2 == 1'b1) begin
            alu_saved_value <= alu_out_register;
        end
        if(save_write_value) begin
            temp_write_value <= alu_out;
        end
        `endif

        `ifdef MDU_ENABLE
        mdu_out_reg <= mdu_out;
        `endif
        
        memory_register <= read_data;
        register_data_1 <= register_data_1_out;
        register_data_2 <= register_data_2_out;
        alu_out_register <= alu_out;
    end
end
    
endmodule
