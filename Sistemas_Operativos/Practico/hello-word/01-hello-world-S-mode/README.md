# Hello world kernel in S-mode

The initial kernel code (`boot` in `start.s`) runs in M-mode.

Changing to *Supervisor or S-mode* cpu have to *return (or leave)* from
*M-mode* by executing the `mret` instruction.

The `mret` instruction uses two machine-mode *Control and Status Registers
(CSRs)*:

- `mstatus`: Contains a field (two bits) with the *saved machine previous
  privilege (MPP)*.
- `mepc`: The previous mode saved *program counter*.

Going from M-mode to S-mode requires setting field `MPP` in `mstatus` and
an (function or instruction) address in `mepc` where `mret` will jump.

It is done at begin of `boot()` in `start.s`. The `mepc` register points to
`supervisor()` entry code.

Then, all range *memory access permissions* for S-mode is enabled by setting
`pmpcfg0` and `pmpaddr0` CSRs.

Also, interrupts and exceptions are *delegated (routed)* to S-mode by setting
`mideleg` and `medeleg` CSRs.

After that the `mret` instruction *returns* to *supervisor* code.

Supervisor code disables [paging], sets the CPU initial stack and calls
`kernel_main()` function, defined in `kernel.c`.

[paging]: # "A memory handling mechanism for protection and virtual memory."

## Exercises

1. Compile and execute this kernel.

2. Uncomment the `asm volatile...` line to verify kernel code is running in
   S-mode. Explain the behaviour in this case.

Sucede que el kernel aunque si arranco en M‑mode, ahora se encuentra en Supervisor mode. 

El registro CSR mhartid solamente es accesible en M‑mode. Intentar leerlo desde S‑mode genera una excepcion. Al generar esta excepcion la CPU no sabe que hacer al atraparla y termina esperando en el mismo punto.