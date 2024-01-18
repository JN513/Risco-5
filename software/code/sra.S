.global _start

_start:
    addi a1, x0, 10      # Carrega o primeiro número (10) em a1
    addi a2, x0, 20      # Carrega o segundo número (20) em a2
    addi a5, x0, 1

    sra a3, a1, a5
    sra a4, a2, a5
