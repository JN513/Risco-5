#ifndef __GPIO_H__
#define __GPIO_H__

#define LED_BASE_ADDR  0x40000000
#define GPIO_BASE_ADDR 0xC0000000

#define GPIO_WRITE_DIRECTION_IMEDIATE       0x00000000
#define GPIO_WRITE_DATA_IMEDIATE            0x00000004
#define GPIO_PWM_CONFIG_IMEDIATE            0x00000008
#define GPIO_PWM_PERIOD_CONFIG_IMEDIATE     0x0000000C
#define GPIO_PWM_DUTY_CYCLE_CONFIG_IMEDIATE 0x00000010

#define CLK_FREQ           50000000
#define MAX_PWM_FREQ       65535
#define MAX_PWM_DUTY_CYCLE 65535

void config_gpio_direction(int direction);
void gpio_write_data(int data);
int gpio_read_data();

void set_led_value(int value);

int get_pwm_period(int freq);
int get_pwm_duty_cycle(int period, int duty_cycle);

void set_pwm_period(int period, int id);
void set_pwm_duty_cycle(int duty_cycle, int id);

void config_gpio_as_pwm(int gpio_mask);

#endif // !__GPIO_H__