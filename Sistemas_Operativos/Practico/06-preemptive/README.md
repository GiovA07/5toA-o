# Preemptive tasks

In this project we handle clock interrupts to implement preemtive multitasking.

## The Core local interrupt controller (CLINT)

There is a CLINT device per core. It provide timer functionalities.
In our platform the CLINT controller is memory mapped starting at address
0x2000000.

It contains a *shared* 64 bits timer counter register (MTIME) witch is updated
by the internal clock and counts cycles from boot.

For each hart there is a 64 bits comparator register (MTIME_CMP). See `arch.h`
to see memory mapped addresses. This registes only can be accesed in *machine
mode*.

When MTIME reaches the MTIME_CMP register, it throws an interrupt and jumps to a
*machine mode trap handler*.

In `arch.c` we added the `next_timer_interrupt(int cpu_id)` function to schedule
the next timer interrupt.

This function simply put in the MTIME_CMP register the value of MTIME plus an
constant interval.

This RISC-V board CLINT 

## Trap handling

In this step we have included low and high level trap handling.

In `arch.s` we add two low level trap handling routines:

On boot, the `mtvec` CSR was set to point to `m_trap`, so the `m_trap` routine
handle traps in *machine mode*. Timer interrupts are handled here.
It just call to `next_timer_interrupt(int cpu_id)` function.

Also, on boot each hart was set to delegate other interrupts to *supervisor mode*
and set `stvec` pointing to `s_trap`.

With this configuration, each hart will deliver timer interrupts to `m_trap` and
other interrupts and exceptions to `s_trap`.

The `m_trap` routine (running in machine mode) *delegate* trap handling to
*supervisor mode*. It is done by setting the *supervisor interrupt pending* CSR
(`sip`) bit 2 (timer interrupts). The `mret` instruction will jump to `s_trap`
routine.

The `s_trap` handler save all CPU registers in current stack and the it calls
the `trap(sp)` high level trap handling function (defined in `trap.c`).

The `trapframe` structure represents the interrupted task state saved on its
kernel mode stack.

The function `trap(struct trapframe* tf)` get the trap cause *interrupt,
exception or software interrupt number)* and handle the corresponding case.

For now, we are interested only in timer interrupts. In such a case, it
increments a global `ticks` variable and makes current task leaves the CPU by
calling `yield()`.

## Exercises

1. Suppose a 32 bits timer running at 1Mhz (1000000 cycles per second). How long
   it takes to overflow?

    Si tenemos un timer de 32 bits, significa que puede contar hasta 2^32 = 4,294,967,296 - 1 (-1 porque comienza desde 0).
    Con lo cual si corre el timer en 1Mhz que es 1 ciclo cada microsegundo, lo que significa que hace 1.000.000 de ciclos por segundo.

    1000000 ciclos por 1 segundo
    4,294,967,296 por x segundos

    4294967296  / 1000000 = Correra por 4294.967296 segundos.
    Pasados a minutos: 4294.967296 / 60 = 71.582788267 minutos.
    Pasados a horas: 71.582788267 / 60 = 1.193 horas, 0.193 x 60 = 11.580 minutos, 0.580 x 60 = 34 segundos.

    Por ende el tiempo que le tomara hacer overflow sera de: 1 hora, 11 minutos y 34 segundos.

2. Suppose an OS con a 32 bits internal clock counter incremented each second.
   In how many days it will overflow? And for a 64 bits counter?

   Como dije anteriormente, significa que puede contar hasta 2^32 − 1 = 4,294,967,295
    Luego como dice que el reloj interno incrementa cada segundo x1 significa que 4,294,967,295 segundos.
    Ahora lo pasamos a dias: 
        4,294,967,295  segundos/ 60 segundos = 71582788.25 minutos.
        71582788.25 minutos / 60 minutos = 1193046.47083 horas. 
        1193046.47083 horas / 24 horas = 49710.2696179167 dias.
        Lo que equivale a 49710.2696179167 dias / 365 dias = 136 años.

    En 64 bits:
        Significa que puede contar hasta 2^64 − 1 = 18446744073709551615
        Luego como dice que el reloj interno incrementa cada segundo x1 significa que 18446744073709551615 segundos.
        Ahora lo pasamos a dias: 
            18446744073709551615  segundos/ 60 segundos = 307445734561825860.25 minutos.
            307445734561825860.25 minutos / 60 minutos = 5124095576030431 horas. 
            5124095576030431 horas / 24 horas = 213503982334601.291 dias.
            Lo que equivale a 213503982334601.291 dias / 365 dias = 584942417355 años.


3. Define a contant `QUANTUM` which represents the maximum number of ticks to be
   used by a `RUNNING` task in a CPU burst. A task should yield the CPU when it
   had consumed its quantum.
   Hints: When a task is scheduled, it starts a new quantum. Modify the `trap()`
   function (in `trap.c`) to get this behaviour.

   Para realizarlo primero defini una constante QUANTUM = 3 y un atributo en task llamado cant_ticks_task iniciandolo en  para ir incrementandolo a medida que se vaya interrumpiendo por reloj.

    Inicializamos en la create task al atributo cant_ticks_task = 0 y modificamos el siguiente if en TRAP, para que solo haga yield en una interrupcion de reloj, cuando la tarea corriente de esa cpu llegue al quantum.

    if (task && task == cpus_state[cpu_id].task && task->state == RUNNING)
        if(++task->cant_ticks_task == QUANTUM)
            yield();

    Ademas agregamos en scheduler, que cada vez que elija una nueva tarea a ejecutarse, esta reinicie el atributo de cant_ticks_task a 0. Para que cada vez que se haga una interrupcion de reloj, se vaya incrementando hasta llegar al valor que tiene la constante QUANTUM.


4. Function `sleep(ticks)` (in `task.c`) *suspend* the calling task until
   `ticks` elapsed. Function `wake_up_for_timer()` wakeup tasks waiting for
   ticks.
   In this code, the task *B* goes to sleep but it never wakeup.
   Fix it by doing the necessary modificaion in `task.c` to wakeup waiting tasks
   when the given ticks elapsed.
   Hint: You just have to find which function should add the call to `wake_up_for_timer()`.

Aqui lo unico que hicimos fue agregar la funcion `wake_up_for_timer()` en la funcion `inc_ticks()`, esto lo hicimos para que cada vez que realice un incremento, pueda despertar aquellas tareas las cuales estan esperando por una cierta cantidad de ticks.