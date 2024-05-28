#include "../lib/risco5.h"

// Path: ../lib/risco5.h

__asm__ (
    ".section .text\n"
    ".global _start\n"
    "_start:\n"
    "   li sp, 0x04000\n"
    "   j main\n"
);

int uart_rx_empty(){
    return *((volatile int *)(UART_BASE_ADDR + UART_READ_RX_EMPTY_IMEDIATE));
}

int uart_tx_empty(){
    return *((volatile int *)(UART_BASE_ADDR + UART_READ_TX_EMPTY_IMEDIATE));
}

int uart_rx_full(){
    return *((volatile int *)(UART_BASE_ADDR + UART_READ_RX_FULL_IMEDIATE));
}

int uart_tx_full(){
    return *((volatile int *)(UART_BASE_ADDR + UART_READ_TX_FULL_IMEDIATE));
}

char uart_read(){
    return *((volatile char *)(UART_BASE_ADDR + UART_READ_DATA_IMEDIATE));
}

char uart_read_string(char *data, int size){
    int i = 0;
    while(i < size){
        if(uart_rx_empty() == 0){
            continue;
        }
        data[i] = uart_read();
        if(data[i] == '\0') break;
        i++;
    }
    return i;
}

void uart_write(char data){
    *((volatile char *)(UART_BASE_ADDR)) = data;
}

void uart_write_string(char *data){
    while(*data){
        if(uart_tx_full() == 0){
            continue;
        }
        uart_write(*data);
        data++;
    }
}


void gpio_write_direction(int direction){
    *((volatile int *)(GPIO_BASE_ADDR + GPIO_WRITE_DIRECTION_IMEDIATE)) = direction;
}

void gpio_write_data(int data){
    *((volatile int *)(GPIO_BASE_ADDR + GPIO_WRITE_DATA_IMEDIATE)) = data;
}

int gpio_read_data(){
    return *((volatile int *)(GPIO_BASE_ADDR));
}

void *
memset (void *dest, register int val, register int len)
{
  register unsigned char *ptr = (unsigned char*)dest;
  while (len-- > 0)
    *ptr++ = val;
  return dest;
}

void
bcopy (const void *src, void *dest, int len)
{
  if (dest < src)
    {
      const char *firsts = (const char *) src;
      char *firstd = (char *) dest;
      while (len--)
	*firstd++ = *firsts++;
    }
  else
    {
      const char *lasts = (const char *)src + (len-1);
      char *lastd = (char *)dest + (len-1);
      while (len--)
        *lastd-- = *lasts--;
    }
}

void *
memcpy (void *out, const void *in, int length)
{
    bcopy(in, out, length);
    return out;
}