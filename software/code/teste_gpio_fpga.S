.global _start

_start:
    li s0, 0xC0000000 # GPIO base address
    li s1, 0x80000000 # UART base address
    li s2, 0 # gpio values

    li a0, 0x00000001 # GPIO 0 MASK
    li a1, 0x00000002 # GPIO 1 MASK
    li a2, 0x00000004 # GPIO 2 MASK
    li a3, 0x00000008 # GPIO 3 MASK
    li a4, 0x00000010 # GPIO 4 MASK
    li a5, 0x00000020 # GPIO 5 MASK
    li a6, 0x00000040 # GPIO 6 MASK
    li a7, 0x00000080 # GPIO 7 MASK

    li t0, 0x000000F0 # Direction for GPIO 0-3 as output and 4-7 as input

    sw t0, 0(s0) # Set direction for GPIO 0-3 as output and 4-7 as input

    or s2, s2, a0 # Set GPIO 0 high
    or s2, s2, a1 # Set GPIO 1 high
    or s2, s2, a2 # Set GPIO 2 high
    or s2, s2, a3 # Set GPIO 3 high

    sw s2, 4(s0) # Set GPIO 0-3 high

    #xor s2, s2, a0 # Set GPIO 0 low
    #xor s2, s2, a1 # Set GPIO 1 low
    #xor s2, s2, a2 # Set GPIO 2 low
    #xor s2, s2, a3 # Set GPIO 3 low

    sw s2, 4(s0) # Set GPIO 0-3 high
