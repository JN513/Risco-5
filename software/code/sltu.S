.global _start

_start:
    addi a1, zero, 10      # Carrega o primeiro número (10) em a1
    addi a2, zero, 20      # Carrega o segundo número (20) em a2

    sltu a3, a1, a2 # 1
    sltu a4, a2, a1 # 0

    li a5, 0xFFFFFFFF
    li a6, 0xDFFFFFFF
    li a0, 0x00000000

    sltu a7, a5, a6 # 0 rs1 < rs2
    sltu t0, a6, a5 # 1
    sltu t1, a0, a0 # 0
    sltu t2, a5, a0 # 0
    sltu t3, a0, a5 # 1 
