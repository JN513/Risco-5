# RISCO 5

<p align="center">
<img src="docs/docs/imgs/risco5.jpeg" alt="Logo do processador" width="300px">
</p>

Processador multi-ciclo [RISC-V](https://riscv.org/) com implementação RV32I, desenvolvido durante alguns dias de folga.

- **Don't speak portuguse? [click here](https://github.com/JN513/Risco-5/blob/main/README_en.md)**
- **¿No hablas portugués? [Haz clic aquí](https://github.com/JN513/Risco-5/blob/main/README_en.md)**
- **Sprichst du kein Portugiesisch? [Hier klicken](https://github.com/JN513/Risco-5/blob/main/README_en.md)**

## Jenkins CI

[![Build Status](https://lampiao.ic.unicamp.br/jenkins/buildStatus/icon?job=Risco_5)](https://lampiao.ic.unicamp.br/jenkins/blue/organizations/jenkins/Risco_5/activity)

## Implementação

O processador foi implementado usando Verilog HDL e possui uma implementação multi-ciclo sem pipeline.

## Software

O diretório `software` contém exemplos e testes escritos em Assembly, juntamente com seus respectivos arquivos de memória. Além disso, há um script disponível para converter código Assembly em arquivos de memória. O firmware oficial do processador também está disponível no diretório `software/firmware`.

## Testes

O diretório `tests` inclui diversos testes construídos utilizando o [Iverilog](https://steveicarus.github.io/iverilog/). Todos os testes neste diretório são compatíveis com o Iverilog.

## Família Risco 5:

- Baby Risco 5 - RV16I: Ainda em fase especulativa
- Pequeno Risco 5 - RV32I: [https://github.com/JN513/Pequeno-Risco-5/](https://github.com/JN513/Pequeno-Risco-5/)
- Risco 5 - RV32I: [https://github.com/JN513/Risco-5](https://github.com/JN513/Risco-5)
- Grande Risco 5 - RV32I: [https://github.com/JN513/Grande-Risco-5](https://github.com/JN513/Grande-Risco-5)
- Risco 5 Bodybuilder - RV64I: Ainda em fase especulativa

## Dúvidas e Sugestões

A documentação oficial está disponível em: [https://jn513.github.io/Risco-5/](https://jn513.github.io/Risco-5/). Se tiver alguma dúvida ou sugestão, sinta-se à vontade para utilizar a seção de [ISSUES](https://github.com/JN513/Risco-5/issues) no GitHub. Contribuições são bem-vindas e todos os [Pull requests](https://github.com/JN513/Risco-5/pulls) serão revisados e, se possível, mesclados.

## Contribuição

Se deseja contribuir com o projeto, sinta-se à vontade para fazê-lo. O arquivo [CONTRIBUTING.md](https://github.com/JN513/Risco-5/blob/main/CONTRIBUTING.md) contém as instruções necessárias.

## Licença

Este projeto é licenciado sob a licença [CERN-OHL-P-2.0](https://github.com/JN513/Risco-5/blob/main/LICENSE), que concede total liberdade para uso. O software é licenciado sob a [Licença MIT](https://github.com/JN513/Risco-5/blob/main/LICENSE-MIT), e a documentação sob [CC BY-SA 4.0](https://github.com/JN513/Risco-5/blob/main/LICENSE-CC).

Autor da logo: [Mateus Luck](https://www.instagram.com/mateusluck/)