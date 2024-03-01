.global _start

_start:
    addi a1, zero, 2047      # Carrega o primeiro número (2047) em a1

    add a1, a1, a1
    
    sb a1, 48(zero)

    lw a2, 48(zero)

