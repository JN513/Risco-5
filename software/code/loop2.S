.global _start

_start:
    addi x1, zero, 20;
    addi x2, zero, 10;
    add x3, zero, zero;

loop:
    addi x3, x3, 1; # x3 = x3 + 1
    
    beq x1, x2, fim; # if t0 == t1 then fim
    addi x1, x1, 2
    addi x2, x2, 3
    j loop

fim:
    addi x4, zero, 5
    jr ra;
    