# RISCO 5

<p align="center">
<img src="docs/docs/imgs/risco5.jpeg" alt="Processor logo" width="300px">
</p>

Multi-cycle processor [RISC-V](https://riscv.org/) with RV32I/E[M] implementation, developed during some days off.

- **Não fala Inglês? [clique aqui](https://github.com/JN513/Risco-5/blob/main/README_pt.md)**

## Project Official Language

The official language adopted by the project is Brazilian Portuguese; therefore, most of the documentation and commits are in this language.

## Processor CI

[![Build Status](https://processorci.ic.unicamp.br/jenkins/buildStatus/icon?job=Risco-5)](https://processorci.ic.unicamp.br/jenkins/blue/organizations/jenkins/Risco-5/activity)

## Implementation

The processor was implemented using Verilog HDL and features a multi-cycle implementation without pipelining.

## Software

The `software` directory contains examples and tests written in Assembly, along with their respective memory files. Additionally, there's a script available to convert Assembly code into memory files. The official processor firmware is also available in the `software/firmware` directory.

## Tests

The `tests` directory includes various tests built using [Iverilog](https://steveicarus.github.io/iverilog/). All tests in this directory are compatible with Iverilog.

## RISCO 5 Family:

- Baby RISCO 5 - RV32E optimized to TinyTapeout: [https://github.com/JN513/Baby-Risco-5](https://github.com/JN513/Baby-Risco-5)
- Pequeno RISCO 5 - RV32I single cycle implementation (ARCHIVED): [https://github.com/JN513/Pequeno-Risco-5/](https://github.com/JN513/Pequeno-Risco-5/)
- RISCO 5 - RV32I/E[M]: [https://github.com/JN513/Risco-5](https://github.com/JN513/Risco-5)
- Grande RISCO 5 - RV32I Implementation with pipeline: [https://github.com/JN513/Grande-Risco-5](https://github.com/JN513/Grande-Risco-5)
- RISCO 5 Bodybuilder - RV64I: Still in speculative phase
- RISCO 5S - RV32IM Simulator writing in C language: [https://github.com/JN513/Risco-5S](https://github.com/JN513/Risco-5S)

## Questions and Suggestions

The official documentation is available at: [https://jn513.github.io/Risco-5/](https://jn513.github.io/Risco-5/). If you have any questions or suggestions, feel free to use the [ISSUES](https://github.com/JN513/Risco-5/issues) section on GitHub. Contributions are welcome, and all [Pull requests](https://github.com/JN513/Risco-5/pulls) will be reviewed and merged if possible.

## Contribution

If you'd like to contribute to the project, please feel free to do so. The [CONTRIBUTING.md](https://github.com/JN513/Risco-5/blob/main/CONTRIBUTING.md) file contains the necessary instructions.

## License

This project is licensed under the [CERN-OHL-P-2.0 license](https://github.com/JN513/Risco-5/blob/main/LICENSE), which grants full freedom for use. The software is licensed under the [MIT License](https://github.com/JN513/Risco-5/blob/main/LICENSE-MIT), and the documentation under [CC BY-SA 4.0](https://github.com/JN513/Risco-5/blob/main/LICENSE-CC).

Logo author: [Mateus Luck](https://www.instagram.com/mateusluck/)
