.global _start

_start:
    csrrwi a1, mcause, 5;
    csrr a2, mcause;
