.global _start

_start:
    addi a1, zero, 10      # Carrega o primeiro número (10) em a1
    addi a2, zero, 20      # Carrega o segundo número (20) em a2
    addi a5, zero, 1

    sra a3, a1, a5
    sra a4, a2, a5

    li a6, -2;

    sra a7, a6, a5

    li a6, -1000;
    sra t0, a6, a5
