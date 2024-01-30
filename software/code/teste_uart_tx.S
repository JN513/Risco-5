.global _start

_start:
    addi a1, x0, 10      # Carrega o primeiro número (10) em a1
    addi a2, x0, 20      # Carrega o segundo número (20) em a2

    add a3, a1, a2       # Soma a1 e a2, armazena o resultado em a3
    addi a4, x0, 2047
    add a4, a4, a4
    addi a4, a4, 6
    
    sw a3, 68(x0)
    sw a2, 72(x0)
    sw a1, 76(x0)
    sw a3, 0(a4)

    lw a1, 68(x0)
    lw a3, 72(x0)
    lw a2, 76(x0)

    lw a5, 68(x0)
    lw a6, 72(x0)
    lw a7, 76(x0)
