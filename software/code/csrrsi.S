.global _start

_start:
    csrrsi a1, mcause, 5;
    csrr a2, mcause;
    csrrsi a1, mcause, 3;
    csrr a4, mcause;
