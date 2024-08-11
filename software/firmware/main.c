#include "lib/risco5.h"
#include "lib/uart.h"
#include "lib/gpio.h"

void send_string(char *str){
    int len = strlen(str);

    for (int i = 0; i < len; i++)
    {
        uart_write(str[i]);
        delay_ms(1);
    }
}

int main(){
    send_string("Hello World!\n\0");
    //config_gpio_direction(0x00000000);
    set_led_value(0x000000CC);
    config_gpio_as_pwm(0x00000003);

    set_pwm_period(50000, 0x00000000);

    int duty_cicle = 20000;

    set_pwm_duty_cycle(duty_cicle, 0x00000000);
/*
    while (1)
    {
        duty_cicle += 1000;
        if(duty_cicle > 45000){
            duty_cicle = 0;
        }

        delay_ms(1000);

        set_pwm_duty_cycle(duty_cicle, 0x00000000);
    }
*/
    return 0;
}