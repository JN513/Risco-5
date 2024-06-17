.globl gpio_write_direction
.globl gpio_write_data
.globl gpio_read_data

.globl set_led_value

gpio_write_direction:
    li t1, 0xC0000000
    sw a0, 0(t1)

    ret

gpio_write_data:
    li t1, 0xC0000004
    sw a0, 0(t1)

    ret

gpio_read_data:
    li t1, 0xC0000000
    lw a0, 0(t1)

    ret

set_led_value:
    li t1, 0x40000000
    sw a0, 0(t1)

    ret
