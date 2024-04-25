.global _start

_start:
    addi a1, zero, 10      # Carrega o primeiro número (10) em a1
    addi a2, zero, 20      # Carrega o segundo número (20) em a2

    add a3, a1, a2       # Soma a1 e a2, armazena o resultado em a3
    li a4, 0x40000000;
    
    sw a3, 68(zero)
    sw a2, 72(zero)
    sw a1, 76(zero)
    sw a3, 0(a4)

    lw a1, 68(zero)
    lw a3, 72(zero)
    lw a2, 76(zero)

    lw a5, 68(zero)
    lw a6, 72(zero)
    lw a7, 76(zero)
