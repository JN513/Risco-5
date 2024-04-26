.global _start

_start:
    addi a1, zero, 10      # Carrega o primeiro número (10) em a1
    addi a2, zero, 20      # Carrega o segundo número (20) em a2

    add a6, a1, a2

    srai a3, a1, 1
    srai a4, a2, 1

    addi a5, zero, 5 

    li a6, -2

    srai a7, a6, 1
    li a6, -4

    srai t0, a6, 1
