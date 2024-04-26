.global _start

_start:
    addi a1, zero, 10      # Carrega o primeiro número (10) em a1
    addi a2, zero, 20      # Carrega o segundo número (20) em a2
    addi a5, zero, 1

    srl a3, a1, a5
    srl a4, a2, a5
