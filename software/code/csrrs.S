.global _start

_start:
    li a0, 5;
    li a3, 3;
    csrrs a1, mcause, a0;
    csrr a2, mcause;
    csrrs a1, mcause, a3;
    csrr a4, mcause;
