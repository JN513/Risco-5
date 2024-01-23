.text
.global _start;

_start:
    addi x2, x0, 2047;
    slli x2, x2, 15;

    addi x15, x0, 9;

#    beq x1, x1, loop;
#
#loop:
#    addi x15, x0, 1;
#
#    beq x1, x1, time;
#
#time:
#    addi x3, x0, x1;
#
#    blt x3, x3, time;
