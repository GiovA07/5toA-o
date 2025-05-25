# Tasks

In this step we create a *tasks module* (see `task.h` and `task.c`).

We are implementing *cooperative* threads (*coroutines*) because each thread
voluntarily leaves (*yield*) the cpu.

In next steps we'll develop *preemption*: A tasks can leave CPU on timer
interrupts.

## Tasks

A task is represented by `struct task` type. In `task.c` a *task/process control
block table* is defined.

Each task has a *process id*, its *state* (`TASK_RUNNABLE` or `TASK_RUNNING`),
its stack and the saved stack pointer (stack top).

Task creation (in `create_task(fn_address)`) is simple. An empty stack
descriptor slot in `tasks[]` table is found. Then it is initialized as en
previous *context-switch* step.

The *current task* (a pointer to task descriptor per CPU) is updated in each
context switch.

Function `yield()` change current task to `TASK_RUNNABLE` and calls
`scheduler()`. The scheduler select a next task using a *round/robin* strategy.
Then it makes the context switch to the selected task.

## Testing tasks

The main kernel function create two tasks: `task_a` and `task_b` and calls
`scheduler()`.

Each task start an infinite loop printing a message, do a small *busy wait
loop* and then calls `yield()`.

## Exercise

Do all necessary modifications to create tasks with *priorities*.

- Task creation: `create_task(pc, stack, priority)`
- Scheduling: The scheduler should select a `RUNNABLE` task with highest
  priority.

What problems can this scheduling algorithm have?

El problema con este scheduler es que siempre agarra la tarea que tiene mas importancia para hacerla primero. Entonces, si hay dos tareas con mas prioridad que otras, el scheduler se la pasa saltando solamente entre esas dos, hasta que una se acabe o no pueda seguir. Mientras tanto, las tareas que no son tan importantes se quedan esperando, porque el scheduler siempre va por las mas importantes. 
Por ende este scheduler Esto hace que esas tareas menos importantes puedan quedarse esperando hasta que alguna de las otras tareas termine.

Ademas, no está bueno porque no les da un ratito a todas las tareas para usar la CPU. Una forma de arreglarlo seria hacer que las tareas que llevan mucho tiempo esperando vayan subiendo de importancia poco a poco, así en algún momento les toca correr.