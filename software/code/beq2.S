.global _start

_start:
    addi x12, zero, 1;
    addi x9, zero, 2;

    beq x12, x9, desvio;

    addi x13, zero, 5;
    add x14, x12, x13;
    sw x14, 0(x12);
    lw x14, 0(x12);
    sub x11, x13, x12;
    addi x10, zero, 25;
    addi x10, x10, -15;
    and x15, x12, x13;
    or x15, x12, x13;
    addi x10, zero, 100;

desvio:
    addi x16, zero, 17;
    andi x16, x16, 17;
