#include "../lib/gpio.h"

int get_pwm_period(int freq) {
    return CLK_FREQ / freq;
}

int get_pwm_duty_cycle(int period, int duty_cycle) {
    return period * duty_cycle / 65536;
}