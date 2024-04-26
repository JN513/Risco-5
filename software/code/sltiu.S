.global _start

_start:
    addi a1, zero, 10      # Carrega o primeiro número (10) em a1
    addi a2, zero, 20      # Carrega o segundo número (20) em a2

    sltiu a3, a1, 15 # rs1 < imm
    sltiu a4, a2, 10 # rs2 < imm

    li a5, 0xFFFFFFFF
    li a6, 0x00000DFF
    li a0, 0x00000000

    sltiu a7, a5, 00000000 # 0 rs1 < imm
    sltiu t0, a6, -2048 # 1
    sltiu t1, a0, 0 # 0
    sltiu t2, a5, 0 # 0
    sltiu t3, a0, -2048 # 1 
