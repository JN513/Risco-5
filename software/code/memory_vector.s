.text

.global _start

_start:
    la a0, numbers
    addi a2, a0, 40
    li a1, 10

store:
    beq a2, a0, mid

    sw a1, 0(a0)

    addi a0, a0, 4
    addi a1, a1, 1

    j store

mid:
    la a0, numbers

load:
    beq a2, a0, stop

    lw a1, 0(a0)

    addi a0, a0, 4

    j load

stop:
    li ra, 5

.data
numbers: .skip 40;
