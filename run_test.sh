#!/usr/bin/zsh

mkdir -p build

echo "Digite o nome do teste:"
read nome_do_teste

cp software/memory/$nome_do_teste.hex software/memory/generic.hex

iverilog -o build/soc_test.o -s soc_tb -I src/ src/core/*.v src/peripheral/*.v tests/soc_test.v
vvp build/soc_test.o

rm software/memory/generic.hex

echo "Teste $nome_do_teste, executado"