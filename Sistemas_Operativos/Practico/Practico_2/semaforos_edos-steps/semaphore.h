
#pragma once
#include "arch.h"
#include "task.h"
#include "spinlock.h"

struct semaphore {
    int      value;   // contador
    spinlock lock;    // para proteger value y la lista de espera
};

void sem_init(struct semaphore *s, int value); // Inicializa el valor del semáforo s.

void sem_wait(struct semaphore *s); // Si el valor de s está en cero, suspende al invocante. Sino, decrementa el valor del semáforo s.

void sem_signal(struct semaphore *s); // Incrementa el valor de s y despierta a los threads o procesos bloqueados en s
