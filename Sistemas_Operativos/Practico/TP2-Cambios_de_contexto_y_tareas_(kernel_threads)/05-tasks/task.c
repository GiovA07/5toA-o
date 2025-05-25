#include "arch.h"
#include "klib.h"
#include "task.h"
#include "spinlock.h"

// tasks/processes table
static struct task tasks[TASK_MAX];
static spinlock tasks_lock = 0;

// Current task pointers (per cpu)
static struct task* current_tasks[NCPU];

// scheduler stack pointers (per cpu)
static uint32 scheduler_sp[NCPU];

// for task/process id assignment
static uint32 last_pid = 0;

// return current_task in this cpu
struct task* current_task(void)
{
    return current_tasks[cpuid()];
}

// create task with 'pc' as initial program counter
struct task* create_task(uint32 pc, int priority) {
    // Find an unused tasks table slot
    struct task *task = NULL;
    int i;
    acquire(&tasks_lock);
    for (i = 0; i < TASK_MAX; i++) {
        if (tasks[i].state == TASK_UNUSED) {
            task = &(tasks[i]);
            break;
        }
    }

    if (!task)
        panic("no free tasks slots\n");

    uint32* stack_bottom = (uint32 *)(task->kstack + TASK_KSTACKSIZE);

    // Initialize task structure
    task->sp = (vaddr) init_context(pc, stack_bottom);
    task->pid = ++last_pid;
    task->state = TASK_RUNNABLE;
    task->priority = priority;
    release(&tasks_lock);
    return task;
}

// select a new task to give the CPU
void scheduler(void)
{
    int cpu_id = cpuid();

    while(1) {
        struct task* next_task = NULL;
        int max_priority = 99999; // Valor inicial alto para encontrar la menor prioridad

        // Buscar la tarea runnable con la mejor prioridad
        acquire(&tasks_lock);
        for (int i = 0; i < TASK_MAX; i++) {
            if (tasks[i].state == TASK_RUNNABLE && tasks[i].priority < max_priority) {
                max_priority = tasks[i].priority;
                next_task = &tasks[i];
            }
        }

        // Si encontramos una tarea, ejecutarla
        if (next_task) {
            next_task->state = TASK_RUNNING;
            current_tasks[cpu_id] = next_task;
            release(&tasks_lock);
            context_switch(&(scheduler_sp[cpu_id]), &(next_task->sp));
        } else {
            release(&tasks_lock);
            // No hay tareas runnable, continuar el bucle
        }
    }
}


// current task leaves CPU
void yield(void)
{
    int cpu_id = cpuid();
    struct task *current = current_tasks[cpu_id];
    if (!current) {
        panic("yield(): No current task!");
    }
    current->state = TASK_RUNNABLE;
    context_switch(&(current->sp), &(scheduler_sp[cpu_id]));
}
