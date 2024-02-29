.global _start

_start:
    addi a3, x0, 3;
    add a3, a3, a3;
    
    jal ra, subrotina;

    addi a4, x0, 7;

subrotina:
    addi a5, x0, 10;
    jalr zero, ra, 0;
