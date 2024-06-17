# RISCO 5

<p align="center">
<img src="docs/docs/imgs/risco5.jpeg" alt="Logo del procesador" width="300px">
</p>

Procesador multi-ciclo [RISC-V](https://riscv.org/) con implementación RV32I, desarrollado durante algunos días libres.

## Idioma oficial del proyecto

El idioma oficial adoptado por el proyecto es el portugués brasileño; por lo tanto, la mayor parte de la documentación y los commits están en este idioma.

## Jenkins CI

[![Estado de construcción](https://lampiao.ic.unicamp.br/jenkins/buildStatus/icon?job=Risco_5)](https://lampiao.ic.unicamp.br/jenkins/blue/organizations/jenkins/Risco_5/activity)

## Implementación

El procesador se implementó utilizando Verilog HDL y presenta una implementación multi-ciclo sin pipeline.

## Software

El directorio `software` contiene ejemplos y pruebas escritas en ensamblador, junto con sus respectivos archivos de memoria. Además, hay un script disponible para convertir código en ensamblador en archivos de memoria. El firmware oficial del procesador también está disponible en el directorio `software/firmware`.

## Tests

El directorio `tests` incluye diversas pruebas construidas utilizando [Iverilog](https://steveicarus.github.io/iverilog/). Todas las pruebas en este directorio son compatibles con Iverilog.

## Familia RISCO 5:

- Baby RISCO 5 - RV16I: Aún en fase especulativa
- Pequeno RISCO 5 - RV32I: [https://github.com/JN513/Pequeno-Risco-5/](https://github.com/JN513/Pequeno-Risco-5/)
- RISCO 5 - RV32I: [https://github.com/JN513/Risco-5](https://github.com/JN513/Risco-5)
- Grande RISCO 5 - RV32I: [https://github.com/JN513/Grande-Risco-5](https://github.com/JN513/Grande-Risco-5)
- RISCO 5 Bodybuilder - RV64I: Aún en fase especulativa

## Dudas y sugerencias

La documentación oficial está disponible en: [https://jn513.github.io/Risco-5/](https://jn513.github.io/Risco-5/). Si tienes alguna duda o sugerencia, no dudes en utilizar la sección de [ISSUES](https://github.com/JN513/Risco-5/issues) en GitHub. Se aceptan contribuciones y todos los [Pull requests](https://github.com/JN513/Risco-5/pulls) serán revisados y, si es posible, fusionados.

## Contribución

Si deseas contribuir al proyecto, no dudes en hacerlo. El archivo [CONTRIBUTING.md](https://github.com/JN513/Risco-5/blob/main/CONTRIBUTING.md) contiene las instrucciones necesarias.

## Licencia

Este proyecto está bajo la licencia [CERN-OHL-P-2.0](https://github.com/JN513/Risco-5/blob/main/LICENSE), que otorga total libertad para su uso. El software está bajo la [Licencia MIT](https://github.com/JN513/Risco-5/blob/main/LICENSE-MIT) y la documentación bajo [CC BY-SA 4.0](https://github.com/JN513/Risco-5/blob/main/LICENSE-CC).

Autor del logo: [Mateus Luck](https://www.instagram.com/mateusluck/)