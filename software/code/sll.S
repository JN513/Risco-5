.global _start

_start:
    addi a1, x0, 10      # Carrega o primeiro número (10) em a1
    addi a2, x0, 20      # Carrega o segundo número (20) em a2
    addi a3, x0, 1

    sll a4, a1, a3
    sll a5, a2, a3
