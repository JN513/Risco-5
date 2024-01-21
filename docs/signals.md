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
