#include "lib/risco5.h"

int main(){
    char data[100] = "Hello World! Risco 5\n";
    uart_write_string(data);

    while(1){
        uart_read_string(data, 100);
        uart_write_string(data);
    }

    return 0;
}