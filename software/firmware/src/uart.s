.globl uart_rx_empty
.globl uart_tx_empty
.globl uart_rx_full
.globl uart_tx_full
.globl uart_read
.globl uart_write
.globl uart_read_string
.globl uart_write_string

uart_rx_empty:
    li t1, 0x80000004
    lw a0, 0(t1)

    ret

uart_tx_empty:
    li t1, 0x80000008
    lw a0, 0(t1)

    ret

uart_rx_full:
    li t1, 0x8000000C
    lw a0, 0(t1)

    ret

uart_tx_full:
    li t1, 0x80000010
    lw a0, 0(t1)

    ret

uart_read:
    li t1, 0x80000000
    lw a0, 0(t1)

    ret

uart_write:
    li t1, 0x80000000
    sw a0, 0(t1)

    ret

uart_read_string:
    li t1, 0x80000000 # uart address
    li t0, 10 # \n
    li t2, 0 # counter

uart_read_string_loop:
    lw t3, 0(t1)
    sw t3, 0(a0)

    addi a0, a0, 1
    addi t2, t2, 1

    beq t3, t0, uart_read_string_end
    beq t2, a1, uart_read_string_end
    
    j uart_read_string_loop

uart_read_string_end:
    mv a0, t2 # return the number of characters read
    ret

uart_write_string:
    li t1, 0x80000000 # uart address
    li t2, 0x80000010
    li t0, 10 # \n

uart_write_string_loop:
    lw t3, 0(t2)

    bnez t3, uart_write_string_loop; # skip if buffer is full

    lw t3, 0(a0)
    sw t3, 0(t1)

    addi a0, a0, 1

    beq t3, t0, uart_write_string_end # t3 == \n
    beq t3, zero, uart_write_string_end # t3 == 0

    j uart_write_string_loop

uart_write_string_end:
    ret
