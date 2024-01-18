.global _start

_start:
    addi x1, x0, 1
    addi x2, x0, 2

    bge x2, x1, desvio

    addi x3, x0, 10

desvio:
    addi x4, x0, 15
    add x4, x4, x2
