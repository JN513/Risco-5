module pc_tb();

reg clk, pc_inclement, pc_load, reset;

always #1 clk = ~clk;
wire [31:0] pc_output;
reg [31:0] pc_input;

PC PC(
    .clk(clk),
    .reset(reset),
    .Input(pc_input),
    .Output(pc_output),
    .load(pc_load),
    .inclement(pc_inclement)
);

initial begin 
    $dumpfile("build/pc.vcd");
    $dumpvars
    
    clk = 0;
    reset = 0;
    pc_inclement = 0;
    pc_load = 0;

    #2

    $display("Estado inicial %d", pc_output);

    if(pc_output == 0) begin
        $display("Resultado correto");
    end else begin
        $display("Resultado incorreto");
    end

    #2

    pc_inclement = 1;

    #2

    pc_inclement = 0;
    $display("Estado %d", pc_output);

    if(pc_output == 1) begin
        $display("Resultado correto");
    end else begin
        $display("Resultado incorreto");
    end

    #2

    $display("Estado %d", pc_output);
    pc_inclement = 1;

    if(pc_output == 1) begin
        $display("Resultado correto");
    end else begin
        $display("Resultado incorreto");
    end

    #2

    $display("Estado %d", pc_output);
    pc_inclement = 0;

    if(pc_output == 2) begin
        $display("Resultado correto");
    end else begin
        $display("Resultado incorreto");
    end

    #4

    pc_load = 1;
    pc_input = 47;

    #2

    pc_load = 0;

    $display("Estado %d", pc_output);
    pc_inclement = 1;

    if(pc_output == 47) begin
        $display("Resultado correto");
    end else begin
        $display("Resultado incorreto");
    end

    #2

    $display("Estado %d", pc_output);
    pc_inclement = 0;
    reset = 1;

    if(pc_output == 48) begin
        $display("Resultado correto");
    end else begin
        $display("Resultado incorreto");
    end

    #2
    $display("Estado %d", pc_output);
    reset = 0;

    if(pc_output == 0) begin
        $display("Resultado correto");
    end else begin
        $display("Resultado incorreto");
    end

    $finish;
end

endmodule
