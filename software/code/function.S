.text
.global _start

_start:
    jal x2, main

# Função que recebe um valor em a0 e retorna o dobro em a0
# O nome da função é "dobro"
dobro:
    add a0, a0, a0
    ret

main:
    li a0, 1
    call dobro  # a0 = 2
    li a0, 10
    call dobro  # a0 = 20
    li a0, 5
    call dobro  # a0 = 10
    ret
