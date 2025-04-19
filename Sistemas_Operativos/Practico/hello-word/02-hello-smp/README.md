# Symmetric multiprocessing (SMP)

Modern CPUs are actually multiprocessors (or multicore). In this step we add SMP
support to our kernel.

In this platform, cores are called *harts*. Each core has an *hartid*. Each core
starts on power-on, so we have multiple processors running the same initial
code.

Now, we have to set its own stack to each CPU.

The linker script `kernel.ld` was modified to extend ths stacks area. We added
space to 4 stacks of 4KB each.

## Source code

We add an *hardware abstraction layer (HAL)* module (`arch.h`, `arch.s`) and put
the *boot* code there. In this module, we put all low-level,
platform-independent code and data.

Boot code in `arch.s` now includes setting the *stack pointer* of each CPU at
its corresponding initial stack address. *hart 0* set its `sp` register at 
`__stack0 + 4096 * 1`, *hart 1* set its `sp` at `__stack0 + 4096 * 2` and so on.

Then, each CPU calls to `kernel_main()` as before.

In `arch.s` we define other utility functions like `cpuid()` to get the *hart
id*.

Also, we have added the *spinlock* module (`spinlock.c/h`) which implement
*busy-waiting locks*.

## Exercise: Running a SMP machine

1. Makefile run `qemu` rule it with option `smp 2`. You could see mixed output
   on console. Why does this happen?

El problema está en como acceden al mismo tiempo los dos CPUs al UART, específicamente en la función console_puts().
Aunque console_putc() espera a que el UART este listo para escribir, no impide que otro CPU interrumpa en medio de una palabra o linea.

2. Modify the `kernel_main()` function to get no mixed output.
    if (cpuid() == 0) {
        acquire(&lk);
        console_puts("Hello from cpu 0!\n");
        release(&lk);
    } else {
        acquire(&lk);
        console_puts("Hello from other cpu!\n");
        release(&lk);
    }