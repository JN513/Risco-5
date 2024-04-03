module Core #(
    parameter BOOT_ADDRESS=32'h00000000
) (
    // Control signal
    input wire clk,
    input wire reset,

    // Memory BUS
    output wire memory_read,
    output wire memory_write,
    output wire [2:0] option,
    input  wire [31:0] read_data,
    output wire [31:0] address,
    output wire [31:0] write_data,

    // Interrupções
    input wire instruction_request_external,
    input wire instruction_request_timer,
    input wire instruction_request_software,
    input wire [15:0] instruction_request_fast

    // RISCV FORMAL
`ifdef RISCV_FORMAL
    ,output reg 		      rvfi_valid = 1'b0,
    output reg [63:0] 	      rvfi_order = 64'd0,
    output reg [31:0] 	      rvfi_insn = 32'd0,
    output reg 		      rvfi_trap = 1'b0,
    output reg 		      rvfi_halt = 1'b0,
    output reg 		      rvfi_intr = 1'b0,
    output reg [1:0] 	      rvfi_mode = 2'b11,
    output reg [1:0] 	      rvfi_ixl = 2'b01,
    output reg [4:0] 	      rvfi_rs1_addr,
    output reg [4:0] 	      rvfi_rs2_addr,
    output reg [31:0] 	      rvfi_rs1_rdata,
    output reg [31:0] 	      rvfi_rs2_rdata,
    output reg [4:0] 	      rvfi_rd_addr,
    output reg [31:0] 	      rvfi_rd_wdata,
    output reg [31:0] 	      rvfi_pc_rdata,
    output reg [31:0] 	      rvfi_pc_wdata,
    output reg [31:0] 	      rvfi_mem_addr,
    output reg [3:0] 	      rvfi_mem_rmask,
    output reg [3:0] 	      rvfi_mem_wmask,
    output reg [31:0] 	      rvfi_mem_rdata,
    output reg [31:0] 	      rvfi_mem_wdata,
`endif
);

wire lorD, IRWrite, zero, reg_write, pc_load, and_zero_out,
    pc_write_cond, pc_write, is_immediate, csr_write_enable;
wire [1:0] alu_src_a, alu_src_b, aluop, memory_to_reg;
wire [3:0] aluop_out;
wire [31:0] pc_output, pc_input, register_input,
    alu_input_a, alu_input_b, alu_out, immediate, 
    register_data_1_out, register_data_2_out,
    csr_data_out;
reg [31:0] instruction_register, memory_register, alu_out_register,
    register_data_1, register_data_2, pc_old;

assign write_data = register_data_2_out;
assign option = (lorD == 1'b0) ? 3'b010 : instruction_register[14:12];

initial begin
    instruction_register = 32'h00000000;
    memory_register = 32'h00000000;
    register_data_1 = 32'h00000000;
    register_data_2 = 32'h00000000;
    alu_out_register = 32'h00000000;
    pc_old = 32'h00000000;
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
    .S(address)
);

MUX MemoryDataMUX(
    .option(memory_to_reg),
    .A(alu_out_register),
    .B(memory_register),
    .C(csr_data_out),
    .S(register_input)
);

MUX AluInputAMUX(
    .option(alu_src_a),
    .A(pc_output),
    .B(register_data_1),
    .C(pc_old),
    .D(32'd0),
    .S(alu_input_a)
);

MUX AluInputBMUX(
    .option(alu_src_b),
    .A(register_data_2),
    .B(32'd4),
    .C(immediate),
    .S(alu_input_b)
);

MUX PCSourceMUX(
    .option({1'b0, pc_source}),
    .A(alu_out),
    .B(alu_out_register),
    .S(pc_input)
);

Registers RegisterBank(
    .clk(clk),
    .reset(reset),
    .regWrite(reg_write),
    .readRegister1(instruction_register[19:15]),
    .readRegister2(instruction_register[24:20]),
    .writeRegister(instruction_register[11:7]),
    .writeData(register_input),
    .readData1(register_data_1_out),
    .readData2(register_data_2_out)
);

and(and_zero_out, zero, pc_write_cond);
or(pc_load, pc_write, and_zero_out);

Control_Unit Control_Unit(
    .clk(clk),
    .reset(reset),
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
    .csr_write_enable(csr_write_enable)
);

ALU_Control ALU_Control(
    .is_immediate(is_immediate),
    .aluop_in(aluop),
    .func7(instruction_register[31:25]),
    .func3(instruction_register[14:12]),
    .aluop_out(aluop_out)
);

Alu Alu(
    .operation(aluop_out),
    .ALU_in_X(alu_input_a),
    .ALU_in_Y(alu_input_b),
    .ALU_out_S(alu_out),
    .ZR(zero)
);

Immediate_Generator Immediate_Generator(
    .instruction(instruction_register),
    .immediate(immediate)
);

CSR_Unit CSR_Unit(
    .clk(clk),
    .reset(reset),
    .func3(instruction_register[14:12]),
    .csr_immediate(instruction_register[19:15]),
    .csr_write_enable(csr_write_enable),
    .csr_address(immediate[11:0]),
    .csr_data_in(register_data_1),
    .csr_data_out(csr_data_out),
    .instruction_request_external(instruction_request_external),
    .instruction_request_timer(instruction_request_timer),
    .instruction_request_software(instruction_request_software),
    .instruction_request_fast(instruction_request_fast),
    .pc_value(pc_old)
);

always @(posedge clk ) begin
    if(reset == 1'b1) begin
        instruction_register <= 32'h00000000;
        memory_register <= 32'h00000000;
        register_data_1 <= 32'h00000000;
        register_data_2 <= 32'h00000000;
        alu_out_register <= 32'h00000000;
        pc_old <= 32'h00000000;
    end else begin
        if(IRWrite == 1'b1)begin
            instruction_register <= read_data;
            pc_old <= pc_output;
        end
        memory_register <= read_data;
        register_data_1 <= register_data_1_out;
        register_data_2 <= register_data_2_out;
        alu_out_register <= alu_out;
    end
end
    
`ifdef RISCV_FORMAL
    assign rvfi_rs1_addr = instruction_register[19:15]
    assign rvfi_rs2_addr = instruction_register[24:20]
    assign rvfi_rs1_rdata = register_data_1_out;
    assign rvfi_rs2_rdata = register_data_2_out;
    assign rvfi_rd_addr = instruction_register[11:7];
    assign rvfi_rd_wdata = register_input;
    assign rvfi_pc_rdata = pc_output;
    assign rvfi_pc_wdata = pc_input;
    assign rvfi_mem_addr = address;
    assign rvfi_mem_rmask = {1'b0, option};
    assign rvfi_mem_wmask = {1'b0, option};
    assign rvfi_mem_rdata = read_data;
    assign rvfi_mem_wdata = write_data;
`endif

endmodule
