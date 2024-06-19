.global _start

_start:
    li a0, 0xC0000000
    li a1, 0x00000000

    sw a1, 0(a0)

    li a1, 0x00000000
    sw a1, 8(a0)

    li a1, 25000

    sw a1, 0xC(a0)

    li a1, 12000

    sw a1, 0x10(a0)
