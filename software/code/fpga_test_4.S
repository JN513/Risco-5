
.global _start

_start:
    li s0, 0x80000000 # endereço da UART
    li s1, 0x40000000; # endereço dos leds

    li s2, 74 # 'J'

    li t0, 0;
    li t1, 0;
    li t3, 0;

    li s3, 255; # Numero a ser contado nos leds
    li s4, 2; # numero de vezes que precisa contar para mandar algo na uart
    li s5, 800000; # delay

loop:
    addi t0, t0, 5; # incrementa t0

    sw t0, 0(s1)

    call delay; # call delay

    bge t0, s3, reset; # if t0 == s3 reset

    j loop; # jump to loop

delay:
    li t1, 0;
delay_loop:
    addi t1, t1, 1;

    beq t1, s5, fim; # if t1 == s5 fim

    j delay_loop; # jump to delay

fim:
    ret

reset:
    #addi t3, t3, 1;
    li t0, 0;

    sw s3, 0(s1);

    #beq t3, s4, send_uart; # if t3 == s4 send_uart
    j send_uart;

    call delay; # call loop

    j loop; # jump to loop

send_uart:
    li t3, 0;

    sw s2, 0(s0);

    call delay;

    lw t4, 4(s0);

    beqz t4, read_uart;

    j loop;

read_uart:
    lw s2, 0(s0);

    sw s2, 0(s4);

    j loop;
