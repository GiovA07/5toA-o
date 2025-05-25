#include "semaphore.h"

void sem_init(struct semaphore *s, int value){
    s->value = value;
    s->lock = 0;
}

 // Si el valor de s está en cero, suspende al invocante. Sino, decrementa el valor del semáforo s.
void sem_wait(struct semaphore *s) {
    acquire(&s->lock);
    if(--s->value < 0) {
        suspend((void*)s, &s->lock);
    }
    release(&s->lock);
}

// Incrementa el valor de s y despierta a los threads o procesos bloqueados en s
void sem_signal(struct semaphore *s) {
    acquire(&s->lock);
    s->value = s->value + 1;
    if(s->value <= 0) {
        wakeup((void*)s);
    }
    release(&s->lock);
}
