# Hello world kernel

In this first step, we develop a minimal kernel code for understanding some
concepts as

1. The boot process and kernel initialization.
2. Compiling and linking a program with no dependencies.
3. Interacting with a simple device (UART, a standard serial line communication
   device).
4. Running the kernel with Qemu.

It outputs "Hello World" by console connected to UART.

## Source code

This first step contains two source files. In `kernel.c` we define the kernel
main function `kernel_main()`. This function is called from the *boot* RISC-V
assembly low level code in `start.s`.

### RISC-V booting process

When the board is turned on, CPU starts in *machine* (*M*)-mode executing
code of the *Zero Stage Bootloader (ZSBL)* stored in a board ROM or FLASH memory.

This bootloader loads the kernel image file from the main storage device
configured in the board (option `-kernel <kernel-image>` in QEMU) and store from
the RAM physical memory address `0x80000000`, then it *jumps* there.

The `boot()` function is at `0x80000000`. See the *linker script* `kernel.ld`.

### The `boot()` function

This is the entry point from boot loader firmware. This function does:

1. Set the stack pointer register `sp = __kernel_end` (end of kernel static
   data plus 4KB). See the `linker.ld` script. It is explained below.
2. Call to `kernel_main()` function.

### The `kernel_main()` function

This function outputs to the console the message *Hello world* by calling
`console_puts()` and then enters in an infinite loop.

### Printing on console

The Risc-V board emulated by QEMU supports a console (terminal) connected to a
[UART](https://en.wikipedia.org/wiki/Universal_asynchronous_receiver-transmitter).

The *UART controller* registers are *memory-mapped* from physical address
`0x10000000`.

The UART programming interface is simple. To send a byte (character) we have to
wait the *transmitter (tx) holding register* (*THR*) until it will be empty and
then put on it the value to send. Transmission on the serial device will start.

The *line status register* (*LSR*) contains status bits. Bit 6 is on when the
*THR* is empty (ready for accept a new value to transmit).

The function `console_putc(c)` follows the UART protocol for sending a byte. The
function `console_puts(str)` just calls `console_putc()` character by character.

## Build system

The Makefile rule *kernel* compile and link `start.s` and `kernel.c` source
files generating the `kernel` binary file using the `kernel.ld` script.

The binary file `kernel` is a standalone program (no dependencies).
It is loaded by boot firmware at physical memory address `0x80000000`.

The linker script `kernel.ld` define instructions for linker for address
assignments to each program section. It instruct the linker where to put program
sections and boot function symbol. Then goes static (global) data sections
(`.rodata`, `.data` and `.bss`).

Below of data sections, the symbol `__stack0` is defined (4KB aligned), a space
of 4KB is reserved for stack and the symbol `__kernel_end` is provided.

These symbols are in symbol tables in the executable (binary) file. The linker
produce the executable file in
[ELF](https://www.cs.cmu.edu/afs/cs/academic/class/15213-f00/docs/elf.pdf)
format.

A program can access to linker defined symbol values. In `start.s`, the `boot`
function set the cpu `sp` register at stack base address (the `__kernel_end`
symbol).

From C code we can access to linker provided symbols by declaring as `external`
pointers.

## Build system

The build system is very simple based on `make`. It works by evaluating rules in
`Makefile`. In `Makefile` a `PREFIX` variable is defined depending of our tools
used. It assumes we are using the GNU toolchain. GNU tools are named using the
target triple *machine-vendor-os*. In GNU-Linux platforms the triplet can be
`riscv64-linux-gnu-`. In other platforms (like MacOS) it can be
`riscv64-unknown-elf-`.

The `CFLAGS` variable is set with gcc command options for cross-compiling to
RV-32 architecture and produce the `kernel` binary.

The `kernel` rule depends from source files and compile and link object files
and generates the `kernel` (ELF) executable. Also, disassemble the `kernel` code
into `kernel.asm` (by using `objdump`). We can analyze this file which contain
the generated code for functions and addresses and how the source code was
translated and linked.

## Compiling and running

1. Compiling and linking: `make`. It will recompile necessary source files and
   build (link) to produce the `kernel` binary file.
2. Running: `make qemu`
3. For quit QEMU press `Ctrl-a` then `x`

## Exercises

1. List kernel binary symbols by running `riscv64-<vendor-os>-nm -n kernel`,
   where `<vendor-os>` is your vendor-os gnu toolchain used. In GNU-Linux
   systems it should be `riscv64-linux-gnu-nm`. Do `man nm` to know what the
   second column values mean. Note that `__stack0` is 4KB alligned and compare
   with the `__kernel_end` symbol value.


   Al ejecutar el comando: riscv64-linux-gnu-nm -n kernel

      Obtengo:
      80000000 T boot
      8000000c T console_putc
      80000040 T console_puts
      80000084 T kernel_main
      80000138 r __GNU_EH_FRAME_HDR
      8000015c R __bss
      8000015c R __bss_end
      80001000 R __stack0
      80002000 R __kernel_end

      Significados de la 2da columna:
         "R"
         "r" El símbolo está en una sección de datos de solo lectura.

         "T"
         "t" El símbolo está en la sección de text, osea .text (serian las funciones, codigo ejecutable).

   Comparar __stack0 que esta alineado en 4kb con el valor del simbolo __kernel_end :

         Tengo en cuenta esto de kernel.ld:

                              /* reserve space for 1 page for stack */
                              . = ALIGN(0x1000);
                              __stack0 = .;
                              . += 4096;
                              __kernel_end = .;


   __stack0:
      Como sabemos el kernel se carga en la dirección 0x80000000 (que seria el origen de la memoria RAM asignada).
      Con ALIGN(0x1000) seguramos que se comience en una dirección que sea un múltiplo de 4 KB. Es decir, la dirección resultante es 0x80000000 + 0x1000 = 0x80001000.

      Esto significaria que el stack comienza en la direccion: 0x80001000

   Despues tenemos que __kernel_end se encuentra en 4kb despues de el stack0. Ya que se reservan 4kb mas desde el stack hasta el kernel_end
    __kernel_end = __stack0 + 4096 = 0x80001000 + 0x1000 = 0x80002000.

    Por ende podemos concluir que el stack tiene solo 4kb, ya que inicia en 0x80001000 y termina en 0x80002000.



2. Open the `kernel.asm` file and analyze the kernel functions and its
   addresses.

   La etiqueta boot
      Dirección:
      Según la salida de nm y el script de enlace, boot está ubicado en 0x80000000.
      Esto concuerda con la sección .text iniciada en esa dirección, ya que el kernel se carga en el comienzo de la memoria RAM designada para el kernel.

   Comandos:
      la sp, __kernel_end:
      Aca lo que se hace es que, se carga en el registro de la pila "sp" la direccion almacenada en __kernel_end, ya que sabemos que la pila solo ocupa 4kb, se coloca sp en ese lugar, para ir apilando cosas desde esa direccion.

      call kernel_main:
      Después de configurar el stack, se llama a la función kernel_main.
         El comando nm muestra a kernel_main en 0x80000084.
         Esta función es la implementación en C donde se invocan funciones como la de console_puts, etc.


3. Run `riscv64-linux-gnu-readelf -at kernel` command to print ELF file
   contents. In particular, you should verify the *program entry point*, the
   machine type and program sections and headers.

   Verifico el punto de entrada del programa (*program entry point*): 
      Entry point address:               0x80000000

   Tipo de maquina (arquitectura para la que fue compilado el binario):
      Machine:                           RISC-V

   Secciones del programa:

   Section Headers:
  [Nr] Name
       Type            Addr     Off    Size   ES   Lk Inf Al
       Flags
  [ 0] 
       NULL            00000000 000000 000000 00   0   0  0
       [00000000]: 
  [ 1] .text
       PROGBITS        80000000 001000 0000a4 00   0   0  4
       [00000006]: ALLOC, EXEC
  [ 2] .rodata
       PROGBITS        800000a4 0010a4 00000e 01   0   0  4
       [00000032]: ALLOC, MERGE, STRINGS
  [ 3] .eh_frame
       PROGBITS        800000b4 0010b4 000084 00   0   0  4
       [00000002]: ALLOC
  [ 4] .eh_frame_hdr
       PROGBITS        80000138 001138 000024 00   0   0  4
       [00000002]: ALLOC
  [ 5] .riscv.attributes
       RISCV_ATTRIBUTE 00000000 00115c 00002f 00   0   0  1
       [00000000]: 
  [ 6] .comment
       PROGBITS        00000000 00118b 00002b 01   0   0  1
       [00000030]: MERGE, STRINGS
  [ 7] .symtab
       SYMTAB          00000000 0011b8 000150 10   8  13  4
       [00000000]: 
  [ 8] .strtab
       STRTAB          00000000 001308 000097 00   0   0  1
       [00000000]: 
  [ 9] .shstrtab
       STRTAB          00000000 00139f 00005c 00   0   0  1
       [00000000]: 

   Headers:
     Type            Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
      RISCV_ATTRIBUT 0x00115c 0x00000000 0x00000000 0x0002f 0x00000 R   0x1
      LOAD           0x001000 0x80000000 0x80000000 0x0015c 0x0015c R E 0x1000
      GNU_EH_FRAME   0x001138 0x80000138 0x80000138 0x00024 0x00024 R   0x4
      GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RW  0x10



4. Print the contents (in hexadecimal) of the `.text` section.

Contents of section .text:
 80000000 17210000 13010100 ef00c007 130101ff  .!..............
 80000010 23268100 13040101 b7070010 93875700  #&............W.
 80000020 83c70700 93f70704 63800700 b7070010  ........c.......
 80000030 2380a700 0324c100 13010101 67800000  #....$......g...
 80000040 130101ff 23261100 23248100 23229100  ....#&..#$..#"..
 80000050 13040101 93040500 03450500 630a0500  .........E..c...
 80000060 93841400 eff09ffa 03c50400 e31a05fe  ................
 80000070 8320c100 03248100 83244100 13010101  . ...$...$A.....
 80000080 67800000 130101ff 23261100 23248100  g.......#&..#$..
 80000090 13040101 17050000 13054501 eff05ffa  ..........E..._.
 800000a0 732540f1 6f000000                    s%@.o...     

5. Print the contents (in hexadecimal) of the `.rodata` section.
Contents of section .rodata:
 800000a8 48656c6c 6f20576f 726c6421 0a00      Hello World!..  

6. Verify that kernel code is running in M-mode by reading the `mhartid` CSR.
   register. Hint: You can use the `__asm__ __volatile__("assembly code")` *GCC
   extension*.
