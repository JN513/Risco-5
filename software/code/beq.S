.global _start

_start:
    addi x12, x0, 1;
    addi x9, x0, 1;

    beq x12, x9, desvio;

    addi x13, x0, 5;
    add x14, x12, x13;
    sw x14, 0(x12);
    lw x14, 0(x12);
    sub x11, x13, x12;
    addi x10, x0, 25;
    addi x10, x10, -15;
    and x15, x12, x13;
    or x15, x12, x13;
    addi x10, x0, 100;

desvio:
    addi x16, x0, 17;
    andi x16, x16, 17;
