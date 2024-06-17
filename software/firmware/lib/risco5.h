#ifndef __RISCO_5_H__
#define __RISCO_5_H_8

#define MEM_SIZE       0x00004000
#define LED_BASE_ADDR  0x40000000
#define UART_BASE_ADDR 0x80000000
#define GPIO_BASE_ADDR 0xC0000000
#define STACK_INIT     MEM_SIZE - 4
#define FRAME_POINTER  0X00002000

#define UART_READ_DATA_IMEDIATE     0x00000000
#define UART_READ_RX_EMPTY_IMEDIATE 0x00000004
#define UART_READ_TX_EMPTY_IMEDIATE 0x00000008
#define UART_READ_RX_FULL_IMEDIATE  0x0000000C
#define UART_READ_TX_FULL_IMEDIATE  0x00000010

#define GPIO_WRITE_DIRECTION_IMEDIATE     0x00000000
#define GPIO_WRITE_DATA_IMEDIATE          0x00000004

#define NOP_TIME 5 // 4 cycles
#define CLK_FREQ 50000000 // 50 MHz
#define MS_TO_CYCLES 50000 // 1MS
#define NUM_NOPS_TO_MS 12500 // 1MS

int uart_rx_empty();
int uart_tx_empty();
int uart_rx_full();
int uart_tx_full();
char uart_read();
void uart_write(char data);

int uart_read_string(char *data, int size);
void uart_write_string(char *data);
void uart_write_int(int data);

void gpio_write_direction(int direction);
void gpio_write_data(int data);
int gpio_read_data();

void set_led_value(int value);

void *memset (void *dest, register int val, register int len);
void *memcpy (void *out, const void *in, int length);
int strlen(const char *str);
char *strcpy(char *destination, const char *source);
int strcmp(const char *str1, const char *str2);
char *strcat(char *destination, const char *source);

void delay_ms(int time);


#endif // __RISCO_5_H__