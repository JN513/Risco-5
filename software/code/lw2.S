.global _start

_start:
    addi a1, zero, 2047      # Carrega o primeiro número (2047) em a1
    add a1, a1, a1

    slli a1, a1, 5

    sw a1, 40(zero)
    lw a2, 40(zero)
