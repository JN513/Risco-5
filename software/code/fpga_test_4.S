.global _start

_start:
    li a5, 63;
    li t1, 74;

    call gera_endereco;
    call gera_endereco_uart;

    #Valor todos os leds acessos
    li s4, 255;
    # valor final do loop
    li s3, 2000;
    add s3, s3, s3;

    slli s3, s3, 8;

    li a6, 0;
    li a7, 5;

    j reset;

check_uart_data:
    li t3, 73;
    sw t3, 0(a2)
    lw t2, 0(a2);
    beq t2, zero, read_uart_data; # if t2 == 0 then target

    ret;
    
read_uart_data:
    li t3, 73;
    sw t3, 0(a2)
    lw t2, 3(a2);
    mv t1, t2;

    ret;

gera_endereco:
    # Calcula o endereço dos leds
    li a4, 0x40000000;
    ret;

gera_endereco_uart:
    # Calcula o endereço da UART
    li a2, 0x80000000;
    ret;
    
send_uart_data:
    # Envia dados pela uart
    sw t1, 0(a2)

    ret;

show_all:
    sw s4, 0(a4);
    li a6, 0;

    call delay;
    call delay;
    call delay;

    call loop;

reset:
    add a3, zero, zero;
    addi a6, a6, 1;

    call check_uart_data;
    call send_uart_data;

    beq a6, a7, show_all;

    call loop;

count:
    addi t0, t0, 1;

    blt t0, s3, count;

    ret;

delay:
    mv s2, ra;
    li t0, 0;

    call count;

    mv ra, s2;

    ret;

loop:
    addi a3, a3, 1; # a3 = a3 + 1
    sw a3, 0(a4)
    call delay
    
    beq a3, a5, fim; # if a2 == a3 then fim
    call loop;

fim:
    call reset;
    