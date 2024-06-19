#include "lib/risco5.h"
#include "lib/uart.h"
#include "lib/gpio.h"

int main(){
    //config_gpio_direction(0x00000000);
    set_led_value(0x000000CC);
    config_gpio_as_pwm(0x00000003);

    int periodo = get_pwm_period(1000);

    set_pwm_period(periodo, 0x00000000);

    int duty_cicle = get_pwm_duty_cycle(periodo, 40000);

    set_pwm_duty_cycle(duty_cicle, 0x00000000);

    return 0;
}