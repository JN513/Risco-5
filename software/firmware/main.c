#include "lib/risco5.h"

int main(){
    char *buffer = "Hello World! Risco 5\n\0";

    int n = strlen(buffer);

    for(int i = 0; i < n; i++){
        if(uart_rx_full()) {
            i--;
            continue;
        }
        uart_write(buffer[i]);
    }

    while (1)
    {
        if(uart_rx_empty()) continue;
        
        char c = uart_read();
        uart_write(c);
    }

    return 0;
}