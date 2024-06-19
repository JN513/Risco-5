.global _start

_start:
    li a0, 0xC0000000
    li a1, 0x0000001F

    sw a1, 0(a0)
