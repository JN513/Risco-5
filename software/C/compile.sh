#!/usr/bin/zsh

echo "Digite o nome do teste:"
read nome_do_teste

riscv32-unknown-elf-gcc -march=rv32id -std=gnu99 -mabi=ilp32 -Wall $nome_do_teste.c \
    -nostartfiles -nostdinc -nostdlib -mstrict-align -Ttext=0x1000 -Tdata=0x1000 -S
riscv32-unknown-elf-as -march=rv32i $nome_do_teste.s -o build/$nome_do_teste.o
riscv32-unknown-elf-ld build/$nome_do_teste.o -o build/$nome_do_teste.elf
riscv32-unknown-elf-objcopy -O binary build/$nome_do_teste.elf build/$nome_do_teste.bin
hexdump -v -e '1/4 "%08x" "\n"' build/$nome_do_teste.bin > memory/$nome_do_teste.hex

echo "Teste $nome_do_teste, compilado"