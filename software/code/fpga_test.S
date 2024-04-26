.text
.global _start;

_start:
    addi x2, zero, 2047;
    slli x2, x2, 15;

    addi x15, zero, 9;

#    beq x1, x1, loop;
#
#loop:
#    addi x15, zero, 1;
#
#    beq x1, x1, time;
#
#time:
#    addi x3, zero, x1;
#
#    blt x3, x3, time;
