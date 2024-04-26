.global _start

_start:
    addi x10, zero, 5;
    addi x11, zero, 3;
    add x12, x10, x11;

    or x9, x10, x10;
    or x8, x10, x11;
    or x13, x12, x11;
    