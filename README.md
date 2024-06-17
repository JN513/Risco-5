# RISCO 5

<p align="center">
<img src="docs/docs/imgs/risco5.jpeg" alt="Logo do processador" width="300px">
</p>

Processador [RISC-V](https://riscv.org/) de multi ciclo com implementação RV32I construído em alguns dias de folga.

## Jenkins CI

[![Build Status](https://lampiao.ic.unicamp.br/jenkins/buildStatus/icon?job=Risco_5)](https://lampiao.ic.unicamp.br/jenkins/job/Risco_5/)

## Implementação

O processador foi implementado utilizando Verilog HDL, e tem uma implementação multiciclo sem Pipeline.

## Software

O diretório software possui alguns exemplos e testes escritos em Assembly e os seus respectivos arquivos de memória, além disso está disponível um script para transformar Assembly em arquivo de memória.

## Testes

O diretório tests possui alguns testes construídos utilizando o [Iverilog](https://steveicarus.github.io/iverilog/), todos os testes lá disponíveis são compatíveis com o mesmo.

## Familia Risco 5:

- Baby Risco 5 - RV16I: Ainda especulativo
- Pequeno Risco 5 - RV32I: [https://github.com/JN513/Pequeno-Risco-5/](https://github.com/JN513/Pequeno-Risco-5/)
- Risco 5 - RV32I: [https://github.com/JN513/Risco-5](https://github.com/JN513/Risco-5)
- Grande Risco 5 - RV32I: [https://github.com/JN513/Grande-Risco-5](https://github.com/JN513/Grande-Risco-5)
- Risco 5 bodybuilder - RV64I: Ainda especulativo

## Dúvidas e sugestões

Em caso de dúvida ou sugestão fique a vontade para utilizar a seção [ISSUES](https://github.com/JN513/Risco-5/issues) do github. Caso se sinta à vontade e queira contribuir com algo qualquer Pull request e bem vindo, todos os [Pull requests](https://github.com/JN513/Risco-5/pulls) serão revisados e se possível mergeados.

## Licença

A licença utilizada no projeto é a [CERN-OHL-P-2.0 license]() que concede total liberdade para utilização do mesmo.

Autor da logo: [Mateus luck](https://www.instagram.com/mateusluck/)
