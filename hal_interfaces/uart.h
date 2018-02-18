#ifndef UART_H
#define UART_H

typedef enum { UART1, UART2, UART3 } UartDevice;

typedef void(*uart_receive_data)(char* data, int size);

extern void uart_init(UartDevice uartDevice, uart_receive_data dataReceiveCb);
extern void uart_transmit(char* data, int size);
extern void uart_start();
extern void uart_stop();

#endif
