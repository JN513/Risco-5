.global _start

_start:
    addi a1, x0, 10      # Carrega o primeiro número (10) em a1
    addi a2, x0, 20      # Carrega o segundo número (20) em a2

    sub a3, a2, a1       # Soma a1 e a2, armazena o resultado em a3
    sub a4, a3, a2
    sub a5, a4, a1
