#ifndef __UART_H__
#define __UART_H__

#define UART_BASE_ADDR 0x80000000

#define UART_READ_DATA_IMEDIATE     0x00000000
#define UART_READ_RX_EMPTY_IMEDIATE 0x00000004
#define UART_READ_TX_EMPTY_IMEDIATE 0x00000008
#define UART_READ_RX_FULL_IMEDIATE  0x0000000C
#define UART_READ_TX_FULL_IMEDIATE  0x00000010

int uart_rx_empty();
int uart_tx_empty();
int uart_rx_full();
int uart_tx_full();
char uart_read();
void uart_write(char data);

int uart_read_string(char *data, int size);
void uart_write_string(char *data);
void uart_write_int(int data);

#endif // !__UART_H__