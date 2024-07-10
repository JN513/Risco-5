`include "config.vh"
`ifdef CSR_ENABLE
module CSR_Unit (
    input wire clk,
    input wire reset,
    input wire csr_write_enable,
    input wire [2:0] func3,
    input wire [4:0] csr_immediate,
    input wire [11:0] csr_address,
    input wire [31:0] csr_data_in,
    output reg [31:0] csr_data_out,

    // Interrupções
    input wire interruption_request_external,
    input wire interruption_request_timer,
    input wire interruption_request_software,
    input wire [15:0] interruption_request_fast,

    input wire [31:0] pc_value

);

// Address of Performance Counters CSRs

localparam CYCLE                = 12'hC00;
localparam TIME                 = 12'hC01;
localparam INSTRET              = 12'hC02;
localparam CYCLEH               = 12'hC80;
localparam TIMEH                = 12'hC81;
localparam INSTRETH             = 12'hC82;

// Address of Machine Information CSRs

localparam MARCHID              = 12'hF12;
localparam MIMPID               = 12'hF13;

// Address of Machine Trap Setup CSRs

localparam MSTATUS              = 12'h300;
localparam MSTATUSH             = 12'h310;
localparam MISA                 = 12'h301;
localparam MIE                  = 12'h304;
localparam MTVEC                = 12'h305;

// Address of Machine Trap Handling CSRs

localparam MSCRATCH             = 12'h340;
localparam MEPC                 = 12'h341;
localparam MCAUSE               = 12'h342;
localparam MTVAL                = 12'h343;
localparam MIP                  = 12'h344;

// Address of Machine Performance Counters CSRs

localparam MCYCLE               = 12'hB00;
localparam MINSTRET             = 12'hB02;
localparam MCYCLEH              = 12'hB80;
localparam MINSTRETH            = 12'hB82;

// Registros de controle
reg [31:0] mepc, mscratch, mcause, mtval, mtvec;
reg [63:0] mcycle, minstret, utime;

wire [31:0] csr_input;

initial begin
    mepc       = 32'h00000000;
    mscratch   = 32'h00000000;
    mcause     = 32'h00000000;
    mtval      = 32'h00000000;
    mtvec      = 32'h00000000;
    mcause = 32'h00000000;
    mcycle     = 64'h0000000000000000;
    minstret   = 64'h0000000000000000;
    utime      = 64'h0000000000000000;
end

always @(*) begin
    case (csr_address)
        CYCLE: csr_data_out     <= mcycle[31:0];
        TIME: csr_data_out      <= utime[31:0];
        INSTRET: csr_data_out   <= minstret[31:0];
        CYCLEH: csr_data_out    <= mcycle[63:32];
        TIMEH: csr_data_out     <= utime[63:32];
        INSTRETH: csr_data_out  <= minstret[63:32];
        MARCHID: csr_data_out   <= 32'h00002EF8; // 12024 - primeiro semestre 2024
        MIMPID: csr_data_out    <= 32'h00000001; // versão 1
        MSTATUS: csr_data_out   <= 32'h00000000;
        MSTATUSH: csr_data_out  <= 32'h00000000;
        MISA: csr_data_out      <= 32'h40000100; // RV 32I
        MIE: csr_data_out       <= 32'h00000000;
        MTVEC: csr_data_out     <= mtvec;
        MSCRATCH: csr_data_out  <= mscratch;
        MEPC: csr_data_out      <= mepc;
        MCAUSE: csr_data_out    <= mcause;
        MTVAL: csr_data_out     <= mtval;
        MIP: csr_data_out       <= 32'h00000000;
        MCYCLE: csr_data_out    <= mcycle[31:0];
        MINSTRET: csr_data_out  <= minstret[31:0];
        MCYCLEH: csr_data_out   <= mcycle[63:32];
        MINSTRETH: csr_data_out <= minstret[63:32];
        default: csr_data_out   <= 32'h00000000;
    endcase
end

always @(posedge clk) begin
    if(reset) begin
        mepc     <= 32'h00000000;
        mscratch <= 32'h00000000;
        mcause   <= 32'h00000000;
        mtval    <= 32'h00000000;
        mtvec    <= 32'h00000000;
        mcycle   <= 64'h0000000000000000;
        utime    <= 64'h0000000000000000;
    end else begin
        mcycle <= mcycle + 1;

        if(csr_write_enable) begin
            case (csr_address)
                MEPC: mepc <= {csr_data_in[31:2], 2'b00};
                MSCRATCH: mscratch <= csr_data_in; // data in não e o valor certo, precisa corrigir depois
                MCAUSE: mcause <= csr_data_in;
                MTVAL: mtval <= csr_data_in;
                MTVEC: mtvec <= csr_data_in;
            endcase
        end
    end
end

always @(posedge clk) begin // minstret - conta as instruções executadas
    if(reset) begin
        minstret <= 64'h0000000000000000;
    end else begin
        if(csr_write_enable) begin
            if(csr_address == MINSTRET) begin
                minstret <= {minstret[63:32], csr_data_in};
            end else if(csr_address == MINSTRETH) begin
                minstret <= {csr_data_in, minstret[31:0]};
            end
        end else if (1'b1) begin // fica pra outro dia

        end
    end
end

assign csr_input = (func3[2] == 1'b1) ? {27'h0000000, csr_immediate} : csr_data_in;

endmodule
`endif
