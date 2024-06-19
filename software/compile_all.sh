#!/bin/zsh

diretorio="code"
march="rv32imzicsr"

mkdir -p build

# Verifica se o diretório existe
if [ -d "$diretorio" ]; then
    # Loop pelos arquivos no diretório
    for arquivo in "$diretorio"/*; do
        # Verifica se é um arquivo regular
        if [ -f "$arquivo" ]; then
            echo "Compilando $arquivo"  # Faça o que desejar com o arquivo
            nome_sem_extensao=$(basename "$arquivo" | sed 's/\.[^.]*$//')

            riscv32-unknown-elf-as -march=$march $arquivo -o build/$nome_sem_extensao.o
            riscv32-unknown-elf-ld build/$nome_sem_extensao.o -o build/$nome_sem_extensao.elf
            riscv32-unknown-elf-objcopy -O binary build/$nome_sem_extensao.elf build/$nome_sem_extensao.bin
            hexdump -v -e '1/4 "%08x" "\n"' build/$nome_sem_extensao.bin > memory/$nome_sem_extensao.hex

            echo "$arquivo compilado"  # Faça o que desejar com o arquivo
        fi
    done
else
    echo "O diretório não existe."
fi
