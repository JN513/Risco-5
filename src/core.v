module Core #(
    parameter CLOCK_FREQ=25000000,
    parameter BOOT_ADDRESS=32'h00000000,
    parameter INSTRUCTION_MEMORY_SIZE=1024,
    parameter DATA_MEMORY_SIZE=4096,
    parameter MEMORY_FILE=""
) (
    input wire clk,
    input wire reset,
    output wire [7:0]leds
);

wire alu_zero, memory_to_reg, memory_read, memory_write, pc_option,
    branch, alu_src, reg_write;
wire [1:0] aluop;
wire [3:0] alu_operation;
wire [31:0] read_data_1, read_data_2, instruction, immediate, 
    instruction_address, data_address, memory_data, reg_write_data,
    ALU_in_Y, PC_immediate_inclement; // data_address is alu output

wire pc_inclement, pc_load;

assign PC_immediate_inclement = instruction_address + (immediate >> 1);
assign pc_inclement = (pc_option == 1'b0) ? 1'b1 : 1'b0;
assign pc_load = ~pc_inclement;

and(pc_option, alu_zero, branch);

MUX Reg_write_mux(
    .A(data_address),
    .B(memory_data),
    .S(reg_write_data),
    .option(memory_to_reg)
);

MUX Alu_src_mux(
    .A(read_data_2),
    .B(immediate),
    .S(ALU_in_Y),
    .option(alu_src)
);

PC PC(
    .clk(clk),
    .reset(reset),
    .Input(PC_immediate_inclement),
    .Output(instruction_address),
    .inclement(pc_inclement),
    .load(pc_load)
);

ALU Alu(
    .operation(alu_operation),
    .ALU_in_X(read_data_1),
    .ALU_in_Y(ALU_in_Y),
    .ALU_out_S(data_address),
    .ZR(alu_zero)
);

ALU_Control Alu_Control(
    .aluop_in(aluop),
    .func7(instruction[31:25]),
    .func3(instruction[14:12]),
    .instruction_opcode(instruction[6:0]),
    .aluop_out(alu_operation)
);

Control_Unit Control_unit(
    .instrution_opcode(instruction[6:0]),
    .branch(branch),
    .memory_read(memory_read),
    .memory_to_reg(memory_to_reg),
    .aluop(aluop),
    .memory_write(memory_write),
    .alu_src(alu_src),
    .reg_write(reg_write)
);

Instruction_Memory #(
    .MEMORY_SIZE(INSTRUCTION_MEMORY_SIZE),
    .MEMORY_FILE(MEMORY_FILE)
) Instruction_memory(
    .reset(reset),
    .instruction_out(instruction),
    .read_address(instruction_address)
);

Data_Memory Data_memory(
    .clk(clk),
    .reset(reset),
    .memory_read(memory_read),
    .memory_write(memory_write),
    .address(data_address),
    .write_data(read_data_2),
    .read_data(memory_data)
);

Immediate_Generator Immediate_generator(
    .instruction(instruction),
    .immediate(immediate)
);

Registers registers(
    .readRegister1(instruction[19:15]),
    .readRegister2(instruction[24:20]),
    .writeRegister(instruction[11:7]),
    .regWrite(reg_write),
    .clk(clk),
    .reset(reset),
    .readData1(read_data_1),
    .readData2(read_data_2),
    .writeData(reg_write_data),
    .leds(leds)
);
    
endmodule
