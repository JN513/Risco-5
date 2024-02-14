.global _start

_start:
    addi a3, x0, 3;
    add a3, a3, a3;
    
    la x1, subrotina;

    jalr a2, x1, 0;

    addi a4, x0, 7;

subrotina:
    addi a5, x0, 10;
    jalr zero, ra, 0;
