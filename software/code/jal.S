.global _start

_start:
    addi a3, x0, 3;
    
    jal subrotina

    addi a4, x0, 5;


subrotina:
    addi a5, x0, 10;
