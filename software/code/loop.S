.global _start

_start:
    addi x2, zero, 10;
    beq zero, zero, loop;

loop:
    addi x15, x15, 1;

    beq x15, x2, end;

    beq x15, x15, loop;

end:
    addi x3, zero, 5;
