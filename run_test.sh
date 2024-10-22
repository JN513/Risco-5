#!/usr/bin/bash

mkdir -p build

# Verifica se um argumento foi passado, caso contrário executa read
if [ -z "$1" ]; then
    echo "Digite o nome do teste:"
    read nome_do_teste
else
    nome_do_teste=$1
fi

cp software/memory/$nome_do_teste.hex software/memory/generic.hex

iverilog -o build/soc_test.o -s soc_tb -I src/core -I src/peripheral src/core/*.v src/peripheral/*.v tests/soc_test.v
vvp build/soc_test.o

rm software/memory/generic.hex

echo "Teste $nome_do_teste, executado"