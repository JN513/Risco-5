.global _start

_start:
    csrrc a1, mcause, 5;
    csrr a2, mcause;
    csrrc a1, mcause, 3;
    csrr a4, mcause;
