#!/usr/bin/bash

mkdir -p build

# Verifica se um argumento foi passado, caso contrário executa read
if [ -z "$1" ]; then
    echo "Digite o nome do teste:"
    read nome_do_teste
else
    nome_do_teste=$1
fi

riscv32-unknown-elf-as -march=rv32izicsr code/$nome_do_teste.S -o build/$nome_do_teste.o
riscv32-unknown-elf-ld build/$nome_do_teste.o -o build/$nome_do_teste.elf
riscv32-unknown-elf-objcopy -O binary build/$nome_do_teste.elf build/$nome_do_teste.bin
hexdump -v -e '1/4 "%08x" "\n"' build/$nome_do_teste.bin > memory/$nome_do_teste.hex

echo "Teste $nome_do_teste, compilado"