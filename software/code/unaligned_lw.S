.text
.global _start

_start:
    li a0, 0x88887FFF
    li a1, 0xFFFFFFFF
    li a2, 0x88888888

    sw a1, 100(zero)
    sw a2, 104(zero)
    sw a0, 108(zero)

    lw a3, 101(zero)
    lw a4, 102(zero)
    lw a5, 103(zero)

    lh a6, 101(zero)
    lh a7, 102(zero)
    lh s2, 103(zero)

    lb s3, 101(zero)
    lb s4, 102(zero)
    lb s5, 103(zero)

    lhu s6, 101(zero)
    lhu s7, 102(zero)
    lhu s8, 103(zero)

    lbu s9, 101(zero)
    lbu s10, 102(zero)
    lbu s11, 103(zero)

    lh t3, 108(zero)
    lb t4, 109(zero) 
