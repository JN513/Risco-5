.global _start

_start:
    addi a1, x0, 10      # Carrega o primeiro número (10) em a1
    addi a2, x0, 20      # Carrega o segundo número (20) em a2

    add a6, a1, a2

    srai a3, a1, 1
    srai a4, a2, 1

    addi a5, x0, 5 
