.global _start

_start:
    addi a1, x0, 10      # Carrega o primeiro número (10) em a1
    addi a2, x0, 20      # Carrega o segundo número (20) em a2

    add a3, a1, a2       # Soma a1 e a2, armazena o resultado em a3
    
    sw a3, 1(x0)
    sw a2, 2(x0)
    sw a1, 3(x0)

    lw a1, 1(x0)
    lw a3, 2(x0)
    lw a2, 3(x0)
