# Sinais

## Core

```verilog
Core #(
    .BOOT_ADDRESS() // Endereço de boot - 32 bits
) Core(
    /* controle */
    .clk(), // Sinal de clock - 1 bit
    .reset(), // Sinal de reset - 1 bit
    /* Dados */
    .memory_read(), // Habitilita leitura na memoria - 1 bit
    .memory_write(), // Habitilita escrita na memoria - 1 bit
    .write_data(), // Valores saindo do core - 32 bits
    .read_data(), // Valores vindo da memoria - 32 bits
    .address() // Endereço de memoria - 32 bits
);
```

## Memoria

```verilog
Memory #(
    .MEMORY_SIZE(), // Tamanho da memoria - int
    .MEMORY_FILE() // Arquivo de inicialização da memoria - str
) Memory(
    /* controle */
    .clk(), // Sinal de clock - 1 bit
    .reset(), // Sinal de reset - 1 bit
    /* Dados */
    .memory_read(), // Habitilita leitura na memoria - 1 bit
    .memory_write(), // Habitilita escrita na memoria - 1 bit
    .write_data(), // Valores vindo do core - 32 bits
    .read_data(), // Valores saindo da memoria - 32 bits
    .address() // Endereço de memoria - 32 bits
);
```

## ALU

```verilog
ALU Alu(
    .operation(), // Codigo da operação a ser realizada pela ALU - 4 bits
    .ALU_in_X(), // Entrada A da ALU - 32 bits
    .ALU_in_Y(), // Entrada B da ALU - 32 bits
    .ALU_out_S(), // Saida da ALU - 32 bits
    .ZR() // Fica ativo caso a saida sejá igual a 0 - 1 bit
);
```

## Banco de registradores

```verilog
Registers RegisterBank(
    .clk(), // Sinal de clock - 1 bit
    .reset(), // Sinal de reset - 1 bit
    .regWrite(), // Habilita escrita nos registradores - 1 bit
    .readRegister1(), // Dados saindo do registrador "A" - 32 bits
    .readRegister2(), // Dados saindo do registrador "B" - 32 bits
    .writeRegister(), // Dados a serem escritos no registrador = 32 bits
    .writeData(), // Endereço do registrador a ser escrito - 5 bits
    .readData1(), // Endereço do registrador "A" a ser lido - 5 bits
    .readData2() // Endereço do registrador "B" a ser escrito - 5 bits
);
```

## MUX

```verilog
MUX MUX(
    .option(), // Opção a ser escolhida - 2 bits
    .A(), // Entrada A - 32 bits - opção 00
    .B(), // Entrada B - 32 bits - opção 01
    .C(), // Entrada C - 32 bits - opção 10
    .D(), // Entrada D - 32 bits - opção 11
    .S() // Saída no multiplexador
);
```

## Gerador de imediato

```verilog
Immediate_Generator Immediate_Generator(
    .instruction(), // instrução - 32 bits
    .immediate() // imediato gerado - 32 bits
);
```

## ALU Control

```verilog
ALU_Control ALU_Control(
    .aluop_in(), // Opção da instrução - 2 bits
    .func7(), // Função 7 - 7 bits
    .func3(), // Função 3 - 3 bits
    .instruction_opcode(), // Opção da instrução - 7 bits
    .aluop_out() // Opção para a ALU - 4 bits
);
```

## PC

```verilog
PC Pc(
    .clk(), // Sinal de clock - 1 bit
    .reset(), // Sinal de reset - 1 bit
    .load(), // Habilita carregar novo valor ao PC - 1 bit
    .Input(), // Entrada do PC - 32 bits
    .Output() // Saida do PC - 32 bits
);
```

## Unidade de controle

```verilog
Control_Unit Control_Unit(
    .clk(), // Sinal de clock - 1 bit
    .reset(), // Sinal de reset - 1 bit
    .instrution_opcode(), // Opção da instrução - 7 bits
    .pc_write_cond(),
    .pc_write(), // Habilita escrita no PC - 1 bit
    .lorD(),
    .memory_read(), // Habitilita leitura na memoria - 1 bit
    .memory_write(), // Habitilita escrita na memoria - 1 bit
    .memory_to_reg(),
    .ir_write(), // Habilita escrita no registrador de instrução - 1 bit
    .pc_source(),
    .aluop(),
    .alu_src_b(),
    .alu_src_a(),
    .reg_write() // Habilita escrita nos registradores - 1 bit
);
```
