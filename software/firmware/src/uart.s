# Declarações globais das funções
.globl uart_rx_empty
.globl uart_tx_empty
.globl uart_rx_full
.globl uart_tx_full
.globl uart_read
.globl uart_write
.globl uart_read_string
.globl uart_write_string

# Função para verificar se o buffer de recepção da UART está vazio
uart_rx_empty:
    li t1, 0x80000004   # Carrega o endereço do registrador de status de recepção vazia da UART em t1
    lw a0, 0(t1)        # Carrega o valor do registrador t1 para a0 (retorno se o buffer de recepção está vazio)

    ret                 # Retorna da função

# Função para verificar se o buffer de transmissão da UART está vazio
uart_tx_empty:
    li t1, 0x80000008   # Carrega o endereço do registrador de status de transmissão vazia da UART em t1
    lw a0, 0(t1)        # Carrega o valor do registrador t1 para a0 (retorno se o buffer de transmissão está vazio)

    ret                 # Retorna da função

# Função para verificar se o buffer de recepção da UART está cheio
uart_rx_full:
    li t1, 0x8000000C   # Carrega o endereço do registrador de status de recepção cheia da UART em t1
    lw a0, 0(t1)        # Carrega o valor do registrador t1 para a0 (retorno se o buffer de recepção está cheio)

    ret                 # Retorna da função

# Função para verificar se o buffer de transmissão da UART está cheio
uart_tx_full:
    li t1, 0x80000010   # Carrega o endereço do registrador de status de transmissão cheia da UART em t1
    lw a0, 0(t1)        # Carrega o valor do registrador t1 para a0 (retorno se o buffer de transmissão está cheio)

    ret                 # Retorna da função

# Função para ler um caractere da UART
uart_read:
    li t1, 0x80000000   # Carrega o endereço do registrador de leitura da UART em t1
    lw a0, 0(t1)        # Carrega o valor do registrador t1 para a0 (retorno do caractere lido da UART)

    ret                 # Retorna da função

# Função para escrever um caractere na UART
uart_write:
    li t1, 0x80000000   # Carrega o endereço do registrador de escrita da UART em t1
    sw a0, 0(t1)        # Armazena o valor de a0 (caractere a ser escrito) no endereço t1 (escrita na UART)

    ret                 # Retorna da função

uart_read_string:
    li t1, 0x80000000   # t1 = 0x80000000 (uart address)
    li t0, 10           # t0 = 10 (\n)
    li t2, 0            # t2 = 0 (counter)

uart_read_string_loop:
    lw t3, 0(t1)        # t3 = load word from address t1 (uart)
    sw t3, 0(a0)        # store word t3 into address a0 (memory buffer)

    addi a0, a0, 1      # increment a0 (buffer address)
    addi t2, t2, 1      # increment t2 (character count)

    beq t3, t0, uart_read_string_end  # if t3 == t0 (\n), jump to uart_read_string_end
    beq t2, a1, uart_read_string_end  # if t2 == a1 (maximum characters), jump to uart_read_string_end
    
    j uart_read_string_loop    # jump back to uart_read_string_loop

uart_read_string_end:
    mv a0, t2   # move t2 (character count) to a0 (return value)
    ret         # return from function

uart_write_string:
    li t1, 0x80000000   # t1 = 0x80000000 (uart address)
    li t2, 0x80000010   # t2 = 0x80000010 (buffer address)
    li t0, 10           # t0 = 10 (\n)

uart_write_string_loop:
    lw t3, 0(t2)        # t3 = load word from address t2 (buffer)

    bnez t3, uart_write_string_loop   # if t3 != 0, loop (skip if buffer is full)

    lw t3, 0(a0)        # t3 = load word from address a0 (string character)
    sw t3, 0(t1)        # store word t3 into address t1 (uart)

    addi a0, a0, 1      # increment a0 (string address)

    beq t3, t0, uart_write_string_end # if t3 == t0 (\n), jump to uart_write_string_end
    beq t3, zero, uart_write_string_end   # if t3 == 0 (end of string), jump to uart_write_string_end

    j uart_write_string_loop   # jump back to uart_write_string_loop

uart_write_string_end:
    ret     # return from function
