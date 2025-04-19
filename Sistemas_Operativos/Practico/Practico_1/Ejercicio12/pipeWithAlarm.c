#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <time.h>
#include <signal.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>

void handleAlarm(int sign) {
    printf("Recibi la señal SIGALRM\n");
    printf("El proceso ha finalizado.\n");
    exit(EXIT_FAILURE);
}

int main(int argc, char const *argv[])
{
    int pid, fd;
    const char *fifoName = "./myfifo";

    if (mkfifo(fifoName, 0666) == -1) {
        printf("No se creo el fifo");
        exit(1);
     }

    signal(SIGALRM, handleAlarm);
    pid = fork();

    if(pid < 0) {
        perror("Error al crear proceso hijo");
        exit(EXIT_FAILURE);
    }

    if (pid == 0) { //hijo
        char buffer[100];
        fd = open(fifoName, O_RDONLY); //O_RDONLY ES DE LECTURA SOLAMENTE
        if (fd == -1) {
            perror("Error al abrir el FIFO para lectura");
            exit(EXIT_FAILURE);
        }
        alarm(20);
        read(fd, buffer, sizeof(buffer));

        printf("Los datos recibidos fueron: %s", buffer);

    } else {
        fd = open(fifoName, O_WRONLY); // Abrir para escritura
        if (fd == -1) {
            perror("Error al abrir FIFO para escritura");
            exit(EXIT_FAILURE);
        }
        sleep(25); //simulo como que tardo mas d 20 seg
        const char *message = "Hola desde el proceso padre\n";
        write(fd, message, strlen(message));
        close(fd);
        wait(NULL);
    }
    close(fd);
    unlink(fifoName);
    return 0;
}
