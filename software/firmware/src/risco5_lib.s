.globl _start   # Declara o ponto de entrada global
.globl strlen   # Declara a função strlen global
.globl strcpy   # Declara a função strcpy global
.globl strcmp   # Declara a função strcmp global
.globl strcat   # Declara a função strcat global
.globl memcpy   # Declara a função memcpy global
.globl memset   # Declara a função memset global
.extern main    # Declara a função main como externa

.globl delay_ms # Declara a função delay_ms global

_start:
    li sp, 0x00008000 # Inicializa o ponteiro de pilha (SP) com 0x04000
    li t0, 0x00000000 # Inicializa t0 com 0 (não utilizado posteriormente)
    li s0, 0x00004000 # Inicializa o frame pointer (S0/FP) com 0x02000

    jal main          # Salta e liga para a função main
    jal exit          # Salta e liga para a função exit

# Função strlen: calcula o comprimento de uma string
strlen: # int strlen(char *str)
    addi t0, zero, 0  # Inicializa t0 (contador de comprimento) com 0
strlen_loop:
    lbu t1, 0(a0)     # Carrega um byte da string em t1
    beq t1, zero, strlen_end # Se o byte for nulo (fim da string), termina
    addi t0, t0, 1    # Incrementa o contador de comprimento
    addi a0, a0, 1    # Avança para o próximo byte da string
    j strlen_loop     # Repete o loop
strlen_end:
    mv a0, t0         # Move o comprimento da string para a0 (valor de retorno)
    ret               # Retorna da função

# Função strcpy: copia uma string de source para destination
strcpy: # char *strcpy(char *destination, const char *source)
    addi t0, a0, 0    # Salva o ponteiro inicial de destination em t0
strcpy_loop:
    lbu t1, 0(a1)     # Carrega um byte de source em t1
    beq t1, zero, strcpy_end # Se o byte for nulo, termina
    sb t1, 0(a0)      # Armazena o byte em destination
    addi a0, a0, 1    # Avança o ponteiro de destination
    addi a1, a1, 1    # Avança o ponteiro de source
    j strcpy_loop     # Repete o loop
strcpy_end:
    sb zero, 0(a0)    # Adiciona um terminador nulo em destination
    ret               # Retorna da função

# Função strcmp: compara duas strings
strcmp: # int strcmp(const char *str1, const char *str2)
    lbu t0, 0(a0)     # Carrega um byte de str1 em t0
    lbu t1, 0(a1)     # Carrega um byte de str2 em t1
    bne t0, t1, strcmp_cmp # Se os bytes forem diferentes, vai para strcmp_cmp
    beq t0, zero, strcmp_neg # Se t0 for nulo, str1 é menor
    beq t1, zero, strcmp_pos # Se t1 for nulo, str2 é menor
    addi a0, a0, 1    # Avança o ponteiro de str1
    addi a1, a1, 1    # Avança o ponteiro de str2
    j strcmp          # Repete o loop
strcmp_cmp:
    sub a0, t0, t1    # Calcula a diferença entre os bytes
    j strcmp_end      # Vai para o final
strcmp_neg:
    addi a0, zero, -1 # Retorna -1 se str1 é menor
    j strcmp_end
strcmp_pos:
    addi a0, zero, 1  # Retorna 1 se str2 é menor
strcmp_end:
    ret               # Retorna da função

# Função strcat: concatena duas strings
strcat: # char *strcat(char *destination, const char *source)
    addi t0, a0, 0    # Salva o ponteiro inicial de destination em t0
strcat_loop:
    lbu t1, 0(a0)     # Carrega um byte de destination em t1
    beq t1, zero, strcat_copy # Se o byte for nulo, vai para strcat_copy
    addi a0, a0, 1    # Avança o ponteiro de destination
    j strcat_loop     # Repete o loop
strcat_copy:
    lbu t1, 0(a1)     # Carrega um byte de source em t1
    sb t1, 0(a0)      # Armazena o byte em destination
    beq t1, zero, strcat_end # Se o byte for nulo, termina
    addi a0, a0, 1    # Avança o ponteiro de destination
    addi a1, a1, 1    # Avança o ponteiro de source
    j strcat_copy     # Repete o loop
strcat_end:
    addi a0, t0, 0    # Restaura o ponteiro inicial de destination
    ret               # Retorna da função

# Função memcpy: copia num bytes de source para destination
memcpy: # void *memcpy(void *destination, const void *source, size_t num)
    addi t0, a0, 0    # Salva o ponteiro inicial de destination em t0
    li t2, 0          # Inicializa t2 (contador de bytes copiados) com 0
memcpy_loop:
    lw t1, 0(a1)      # Carrega uma palavra de source em t1
    sw t1, 0(a0)      # Armazena a palavra em destination
    addi t2, t2, 1    # Incrementa o contador de bytes copiados
    beq t2, a3, memcpy_end # Se o contador atingir num, termina
    addi a0, a0, 1    # Avança o ponteiro de destination
    addi a1, a1, 1    # Avança o ponteiro de source
    j memcpy_loop     # Repete o loop
memcpy_end:
    mv a0, t0         # Move o ponteiro inicial de destination para a0 (valor de retorno)
    ret               # Retorna da função

# Função memset: define num bytes do bloco de memória apontado por ptr para o valor especificado
memset: # void *memset(void *ptr, int value, size_t num)
    addi t0, a0, 0    # Salva o ponteiro inicial de ptr em t0
    li t2, 0          # Inicializa t2 (contador de bytes definidos) com 0
memset_loop:
    sw a1, 0(a0)      # Armazena o valor em ptr
    addi t2, t2, 1    # Incrementa o contador de bytes definidos
    beq t2, a2, memset_end # Se o contador atingir num, termina
    addi a0, a0, 1    # Avança o ponteiro de ptr
    j memset_loop     # Repete o loop
memset_end:
    mv a0, t0         # Move o ponteiro inicial de ptr para a0 (valor de retorno)
    ret               # Retorna da função

# Função delay_ms: cria um atraso de a0 milissegundos
delay_ms:
    li t0, 0          # Inicializa t0 (contador de milissegundos) com 0
    li t1, 4167       # Define t1 como 4167 ciclos para aproximadamente 1ms

delay_loop:
    bge t0, a0, delay_end # Se t0 for maior ou igual a a0, termina
    addi t0, t0, 1    # Incrementa o contador de milissegundos
    li t2, 0          # Inicializa t2 (contador de ciclos) com 0
delay_1ms:
    addi t2, t2, 1    # Incrementa o contador de ciclos
    bge t2, t1, delay_loop # Se t2 for maior ou igual a t1, volta para delay_loop
    j delay_1ms       # Repete o loop de 1ms
delay_end:
    ret               # Retorna da função

# Função exit: finaliza o programa
exit:
    j exit            # Loop infinito para simular a saída do programa
