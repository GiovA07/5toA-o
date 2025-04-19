#include <stdio.h>
#include <signal.h>
#include <unistd.h>

int countSignal = 0;

void myHandler(int signal) {
    countSignal++;
    printf("Recibi la señal SIGINT, Conteo: %d\n", countSignal);
}

int main() {
    // Este es el manejador de la se;al 
    signal(SIGINT, myHandler);

    while (1) {
        printf("Esperando señales... Presiona Ctrl+C para enviar SIGINT\n");
        sleep(1); // No me detecta sino
    }
    return 0;
}
