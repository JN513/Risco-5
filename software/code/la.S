.text
.global _start;

_start:
    li a0, 10;
    la a1, desvio;

    jalr ra, a1, 0;

    li a3, 5;

desvio:
    li a2, 4;
    ret;
