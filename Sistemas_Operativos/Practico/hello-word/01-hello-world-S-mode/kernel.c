typedef unsigned char uint8;
typedef unsigned int  uint32;
typedef unsigned long uint64;
typedef unsigned int  size_t;

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

// main kernel function. Here we have in supervisor (kernel) mode.
void kernel_main(void) {
    // uncomment next line to hangs qemu (why?)
    // se puede saber en que modo estamos, mediante el status y ver los bits pero bueno.
    asm volatile("csrr a0, mhartid");

    console_puts("Hello world from S-mode\n");

    for (;;) {
    }
}
