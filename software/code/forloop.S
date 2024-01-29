.text
.global _start

_start:
    call main

main:
  addi t0, zero, 0    # i
  addi t1, zero, 0    # a
  addi t2, zero, 100  # constante 100 para limite do for

for:
  bge t0, t2, fim     # i >= 100 ? vá para o fim
  add t1, t1, t0      # a += i
  addi t0, t0, 1      # i++
  j for              # vá para o início do loop

fim:
  jr ra               # retorne
