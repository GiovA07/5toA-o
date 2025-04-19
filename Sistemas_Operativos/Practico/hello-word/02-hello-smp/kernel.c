#include "arch.h"
#include "spinlock.h"

typedef unsigned char uint8;
typedef unsigned char uint32;
typedef unsigned long uint64;

/****************************************************************************
 * Universal Asynchronous Receiver-Transmitter (UART) device controller     *
 * UART_THR address port: Transmitter Holding Register
 * UART_LSR address port: Line Status Register
 * UART_STATUS_EMPTY: LSR bit 6 Transmitter empty
 ****************************************************************************/
#define UART        0x10000000
#define UART_THR    (uint8*)(UART+0x00)
#define UART_LSR    (uint8*)(UART+0x05)
#define UART_STATUS_EMPTY 0x40

int console_putc(char ch) {
    // wait for UART transmitter register empty
	while ((*UART_LSR & UART_STATUS_EMPTY) == 0)
        ;
    // write character to UART THR to start transmission
	return *UART_THR = ch;
}

// write string to console
void console_puts(const char *s) {
	while (*s)
        console_putc(*s++);
}

spinlock lk;

void kernel_main(void) {
    if (cpuid() == 0) {
        acquire(&lk);
        console_puts("Hello from cpu 0!\n");
        release(&lk);
    } else {
        acquire(&lk);
        console_puts("Hello from other cpu!\n");
        release(&lk);
    }
    for (;;) {
    }
}
