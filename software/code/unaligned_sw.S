.text
.global _start

_start:
    li a0, 0x88887FFF
    li a1, 0xFFFFFFFF
    li a2, 0x88888888

    sw a1, 100(zero)
    sw a1, 104(zero)
    sw a2, 103(zero) 

    li a3, 5
