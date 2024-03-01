.global _start

_start:
    addi a1, zero, 2047      # Carrega o primeiro número (2047) em a1

    sw a1, 40(zero)
    lb a2, 40(zero)
