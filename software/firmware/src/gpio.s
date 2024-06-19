# Declarações globais das funções
.globl gpio_write_direction
.globl gpio_write_data
.globl gpio_read_data

.globl set_led_value

.globl set_pwm_period
.globl set_pwm_duty_cycle
.globl config_gpio_as_pwm

# Função para configurar a direção GPIO
config_gpio_direction:
    li t1, 0xC0000000   # Carrega o endereço do registrador de direção GPIO em t1
    sw a0, 0(t1)        # Armazena o valor de a0 (argumento) no endereço t1 (configuração de direção GPIO)

    ret                 # Retorna da função

# Função para escrever dados em GPIO
gpio_write_data:
    li t1, 0xC0000004   # Carrega o endereço do registrador de escrita de dados GPIO em t1
    sw a0, 0(t1)        # Armazena o valor de a0 (argumento) no endereço t1 (escrita de dados GPIO)

    ret                 # Retorna da função

# Função para ler dados de GPIO
gpio_read_data:
    li t1, 0xC0000000   # Carrega o endereço do registrador de leitura de dados GPIO em t1
    lw a0, 0(t1)        # Carrega o valor do registrador t1 para a0 (retorno da leitura de dados GPIO)

    ret                 # Retorna da função

# Função para definir o valor de um LED
set_led_value:
    li t1, 0x40000000   # Carrega o endereço do registrador de controle de LED em t1
    sw a0, 0(t1)        # Armazena o valor de a0 (argumento) no endereço t1 (controle de LED)

    ret                 # Retorna da função

# Função para definir o período do PWM
set_pwm_period:
    li t1, 0xC000000C   # Carrega o endereço do registrador de período do PWM em t1
    slli a1, a1, 16     # Desloca o valor de a1 (argumento) 16 bits para a esquerda
    or a0, a0, a1       # Combina os valores de a0 e a1
    sw a0, 0(t1)        # Armazena o valor de a0 (argumento) no endereço t1 (configuração do período do PWM)

    ret                 # Retorna da função

# Função para definir o ciclo de trabalho (duty cycle) do PWM
set_pwm_duty_cycle:
    li t1, 0xC0000010   # Carrega o endereço do registrador de ciclo de trabalho do PWM em t1
    slli a1, a1, 16     # Desloca o valor de a1 (argumento) 16 bits para a esquerda
    or a0, a0, a1       # Combina os valores de a0 e a1
    sw a0, 0(t1)        # Armazena o valor de a0 (argumento) no endereço t1 (configuração do ciclo de trabalho do PWM)

    ret                 # Retorna da função

# Função para habilitar/desabilitar o PWM
config_gpio_as_pwm:
    li t1, 0xC0000008   # Carrega o endereço do registrador de controle de habilitação do PWM em t1
    sw a0, 0(t1)        # Armazena o valor de a0 (argumento) no endereço t1 (controle de habilitação do PWM)

    ret                 # Retorna da função
