#ifndef GPIO_H
#define GPIO_H

typedef enum 
{ 
    RESET, 
    SET
} gpio_state;

typedef enum 
{
    INPUT = 0x0,
    OUTPUT_PP = 0x1,
    AF_PP = 0x2,
    ANALOG = 0x3,
    OUTPUT_OD = 0x11,
    AF_OD = 0x12, 
} gpio_mode;

extern void gpio_init(uint16_t pin, gpio_mode mode);
extern void gpio_read_pin(gpio_state* state, int pin);
extern void gpio_write_pin(uint16_t pin, gpio_state state);
extern void gpio_toggle_pin(uint16_t pin);

#endif