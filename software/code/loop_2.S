.global _start

_start:
    addi x2, x0, 2047;
    addi x4, x0, 255;
    addi x10, x0, 2000;
    addi x10, x10, 1000;
    addi x16, x0, 76;
    slli x2, x2, 15;

    beq x0, x0, reset;

reset:
    add x15, x0, x0; # x15 = x0 + x0
    add x3, x0, x0;

    beq x0, x0, loop;

loop:
    addi x15, x15, 1;
    lw x16, 2000(x10);

    beq x15, x4, reset;

    beq x0, x0, time;


time:
    addi x3, x3, 1;

    beq x3, x2, loop;

    beq x0, x0, time;

