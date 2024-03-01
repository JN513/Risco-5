.global _start

_start:
    addi a1, zero, 10      # Carrega o primeiro número (10) em a1
    addi a2, zero, 20      # Carrega o segundo número (20) em a2

    add a3, a1, a2       # Soma a1 e a2, armazena o resultado em a3
    
    sw a3, 40(zero)
    sw a2, 44(zero)
    sw a1, 48(zero)

    lw a1, 40(zero)
    lw a3, 44(zero)
    lw a2, 48(zero)
