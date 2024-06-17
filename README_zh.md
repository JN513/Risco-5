# RISCO 5

<p align="center">
<img src="docs/docs/imgs/risco5.jpeg" alt="处理器标志" width="300px">
</p>

多周期[RISC-V](https://riscv.org/)处理器，采用RV32I实现，利用业余时间开发。

## 项目官方语言

项目采用巴西葡萄牙语作为官方语言，因此大部分文档和提交都是使用该语言。

## Jenkins CI

[![构建状态](https://lampiao.ic.unicamp.br/jenkins/buildStatus/icon?job=Risco_5)](https://lampiao.ic.unicamp.br/jenkins/blue/organizations/jenkins/Risco_5/activity)

## 实现

处理器采用Verilog HDL实现，具有无流水线的多周期设计。

## 软件

`software`目录包含用汇编编写的示例和测试，以及相应的内存文件。此外，还提供了一个用于将汇编代码转换为内存文件的脚本。处理器的官方固件也可在`software/firmware`目录中找到。

## 测试

`tests`目录包含使用[Iverilog](https://steveicarus.github.io/iverilog/)编写的多个测试。此目录中的所有测试都与Iverilog兼容。

## RISCO 5系列:

- Baby RISCO 5 - RV16I：仍在研究阶段
- Pequeno RISCO 5 - RV32I：[https://github.com/JN513/Pequeno-Risco-5/](https://github.com/JN513/Pequeno-Risco-5/)
- RISCO 5 - RV32I：[https://github.com/JN513/Risco-5](https://github.com/JN513/Risco-5)
- Grande RISCO 5 - RV32I：[https://github.com/JN513/Grande-Risco-5](https://github.com/JN513/Grande-Risco-5)
- RISCO 5 Bodybuilder - RV64I：仍在研究阶段

## 疑问和建议

官方文档可在[https://jn513.github.io/Risco-5/](https://jn513.github.io/Risco-5/)找到。如有任何疑问或建议，请随时使用GitHub上的[ISSUES](https://github.com/JN513/Risco-5/issues)部分。欢迎贡献，所有的[Pull requests](https://github.com/JN513/Risco-5/pulls)将得到审核并尽可能合并。

## 贡献

如果您想为项目做出贡献，请随时参与。[CONTRIBUTING.md](https://github.com/JN513/Risco-5/blob/main/CONTRIBUTING.md)文件包含了必要的指导。

## 许可证

该项目采用[CERN-OHL-P-2.0许可证](https://github.com/JN513/Risco-5/blob/main/LICENSE)，允许完全自由使用。软件采用[MIT许可证](https://github.com/JN513/Risco-5/blob/main/LICENSE-MIT)，文档采用[CC BY-SA 4.0许可证](https://github.com/JN513/Risco-5/blob/main/LICENSE-CC)。

Logo作者：[Mateus Luck](https://www.instagram.com/mateusluck/)