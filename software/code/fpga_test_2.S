.global _start

_start:
    addi s0, zero, 255
    li s1, 0x40000000;
    li s2, 3000000

    addi t0, zero, 0
    addi t1, zero, 0

loop:
    addi t0, t0, 1

    sw t0, 0(s1)

    call delay; # call delay

    beq t0, s0, reset; # if t0 == s0 reset

    j loop; # jump to loop

delay:
    li t1, 0;
delay_loop:
    addi t1, t1, 1;

    beq t1, s2, fim; # if t1 == s2 fim

    j delay_loop; # jump to delay

fim:
    ret

reset:
    li t0, 0;

    sw s0, 0(s1)

    call delay; # call loop

    j loop; # jump to loop
    