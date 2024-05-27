.global _start

_start:
    li s0, 0x80000000;

loop:
    lw t0, 4(s0);

    beqz t0, read;

    j loop;

read:
    lw t0, 0(s0);
    sw t0, 0(s0);

    j loop;
