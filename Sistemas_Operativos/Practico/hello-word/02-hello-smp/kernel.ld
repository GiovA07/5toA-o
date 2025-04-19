ENTRY(boot)

SECTIONS {
    /* program sections start at this address */
    . = 0x80000000;

    __kernel_start = .;

    .text :{
        /* first, place the "boot" section (boot function) */
        KEEP(*(.text.boot));
        /* then other program code */
        *(.text .text.*);
    }

    /* the read-only (constants) data section */
    .rodata : ALIGN(4) {
        *(.rodata .rodata.*);
    }

    /* read/write data section */ 
    .data : ALIGN(4) {
        *(.data .data.*);
    }

    /* uninitilized data */
    .bss : ALIGN(4) {
        __bss = .;
        *(.bss .bss.* .sbss .sbss.*);
        __bss_end = .;
    }

    /* reserve space for 4 page stacks (4MB each) */
    __stack0 = .;
    . = ALIGN(4);
    . += 4096 * 4;
    __kernel_end = .;
}
