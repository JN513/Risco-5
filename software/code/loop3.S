.global _start

_start:
    addi x5, zero, 63;
    addi a4, zero, 2047
    add a4, a4, a4
    addi a4, a4, 2

    j reset;
    
reset:
    add x3, zero, zero;
    j loop;

loop:
    addi x3, x3, 1; # x3 = x3 + 1
    sw x3, 0(a4)
    
    beq x3, x5, fim; # if t0 == t1 then fim
    j loop;

fim:
    addi x4, zero, 5
    j reset;
    