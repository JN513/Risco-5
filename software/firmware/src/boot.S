.global _start

_start:
    li sp, 0x04000;
    li t0, 0x00000000;

    jal main;
