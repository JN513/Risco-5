.global _start

_start:
    li a0, 5;
    csrrw a1, mcause, a0;
    csrr a2, mcause;
