.globl atoi
.globl itoa

atoi: # recebe a string a ser convertida e retorna um inteiro - int atoi (const char *str); 
    addi t0, zero, 0    # t0 = 0  (resultado)
    addi t1, zero, 0    # t1 = 0  (sinal: 0 = positivo, 1 = negativo)
    addi t2, zero, 0    # t2 = 0  (índice da string)
    addi t5, zero, 10   # t5 = 10 (multiplicador para conversão de caractere para dígito)

atoi_loop:
    lbu t3, 0(a0)     # Carregar o byte atual da string

    beqz t3, atoi_done  # Se caractere nulo, terminar

    # Ignorar espaços em branco
    li t4, 32         # Código ASCII para espaço
    beq t3, t4, atoi_skip

    # Verificar o sinal
    li t4, 45         # Código ASCII para '-'
    beq t3, t4, atoi_negative
    li t4, 43         # Código ASCII para '+'
    beq t3, t4, atoi_skip

    # Verificar se é um dígito
    li t4, 48         # Código ASCII para '0'
    blt t3, t4, atoi_done  # Se menor que '0', terminar
    li t4, 57         # Código ASCII para '9'
    bgt t3, t4, atoi_done  # Se maior que '9', terminar

    # Converter caractere para dígito e atualizar resultado
    li t4, 48
    sub t3, t3, t4    # t3 = t3 - '0'
    mul t0, t0, t5    # resultado = resultado * 10
    add t0, t0, t3    # resultado = resultado + (t3 - '0')

atoi_skip:
    addi a0, a0, 1    # Avançar para o próximo caractere
    j atoi_loop

atoi_negative:
    addi t1, zero, 1    # Definir sinal como negativo
    j atoi_skip

atoi_done:
    # Aplicar sinal negativo se necessário
    beq t1, zero, atoi_return
    sub t0, zero, t0    # resultado = -resultado

atoi_return:
    mv a0, t0         # Retornar resultado em a0
    ret

itoa: # recebe um inteiro, o buffer a ser escrito e a base para conversão - char *itoa ( int value, char *str, int base );
    addi sp, sp, -4    # Reservar espaço na pilha
    sw a1, 0(sp)      # Salvar ponteiro para string

    # Inicializar variáveis
    addi t1, zero, 0   # t1 = 0 (sinal: 0 = positivo, 1 = negativo)
    addi t6, zero, 10  # t6 = 10 (verificador se numero ou letra)

    # Verificar o sinal
    blt a0, zero, itoa_negative
    j itoa_abs_done

itoa_negative:
    addi t1, zero, 1   # t1 = 1 (negativo)
    neg a0, a0         # t3 = -t3

itoa_abs_done:
    mv t2, a0          # t2 = valor absoluto

itoa_convert_loop:
    beqz t2, itoa_convert_done  # Se valor for zero, terminar

    rem t3, t2, a2     # t3 = t2 % base
    div t2, t2, a2     # t2 = t2 / base

    blt t3, t6, itoa_convert_number

    addi t3, t3, 87     # t3 = t3 + 87 (correção para letras)

    j itoa_convert_store

itoa_convert_number:
    addi t3, t3, 48     # t3 = t3 + '0'

itoa_convert_store:
    sb t3, 0(a1)       # Armazenar caractere na string
    addi a1, a1, 1    # Avançar para o próximo caractere
    j itoa_convert_loop

itoa_convert_done:
    beq t1, zero, itoa_finish  # Se positivo, retornar
    li t3, 45          # t3 = '-'
    sb t3, 0(a1)       # Adicionar sinal negativo
    addi a1, a1, 1    # Avançar para o próximo caractere
    sb zero, 0(a1)    # Adicionar terminador nulo
    addi a1, a1, -1    # Avançar para o próximo caractere

itoa_finish:
    lw t6, 0(sp)   # ponteiro inicial da string

itoa_invert_loop:
    lbu t4, 0(a1);
    lbu t5, 0(t6);

    sb t5, 0(a1);
    sb t4, 0(t6);

    addi a1, a1, -1;
    addi t6, t6, 1;

    bge t6, a1, itoa_return;
    j itoa_invert_loop;

itoa_return:
    lw a0, 0(sp)   # Restaurar ponteiro para string
    addi sp, sp, 44  # Liberar espaço na pilha

    ret
