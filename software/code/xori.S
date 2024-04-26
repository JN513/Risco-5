.global _start

_start:
    addi x10, zero, 5;
    addi x11, zero, 3;
    add x12, x10, x11;

    xori x9, x10, 7;
    xori x8, x10, 6;
    xori x13, x12, 5;
