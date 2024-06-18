#ifndef __GPIO_H__
#define __GPIO_H__

#define LED_BASE_ADDR  0x40000000
#define GPIO_BASE_ADDR 0xC0000000

#define GPIO_WRITE_DIRECTION_IMEDIATE     0x00000000
#define GPIO_WRITE_DATA_IMEDIATE          0x00000004

void gpio_write_direction(int direction);
void gpio_write_data(int data);
int gpio_read_data();

void set_led_value(int value);

#endif // !__GPIO_H__