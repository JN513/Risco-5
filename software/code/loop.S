.global _start

_start:
    addi x2, x0, 10;
    beq x0, x0, loop;

loop:
    addi x15, x15, 1;

    beq x15, x2, end;

    beq x15, x15, loop;

end:
    addi x3, x0, 5;
