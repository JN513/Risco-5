.global _start

_start:
    addi x1, zero, 1
    addi x2, zero, 2

    bltu x2, x1, desvio

    addi x3, zero, 10

desvio:
    addi x4, zero, 15
    add x4, x4, x2
