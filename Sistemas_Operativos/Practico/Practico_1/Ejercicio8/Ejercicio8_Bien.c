//Igual que en el ejericico 7, yo habia hecho otra cosa.

#include <stdio.h>
#include <stdlib.h> /* wait() */
#include <sys/wait.h>
#include <unistd.h> /* UNIX syscalls */
#include <string.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <ctype.h>

void to_uppercase(char *str) {
    for (int i = 0; str[i]; i++) {
        str[i] = toupper((char)str[i]);
    }
}


int main(int argc, char const *argv[])
{
    const char *fifoPadreAHijo = "./fifo_padre_a_hijo";
    const char *fifoHijoAPadre = "./fifo_hijo_a_padre";

    int pid;
    char buffer[100];

        
    if (mkfifo(fifoPadreAHijo, 0666) == -1) {
        printf("No se creo el fifo");
        exit(1);
     }

    if (mkfifo(fifoHijoAPadre, 0666) == -1) {
        printf("No se creo el fifo");
        exit(1);
     }

     pid = fork();

     if (pid == 0) {
        // === Proceso Hijo ===
        int fd_read = open(fifoPadreAHijo, O_RDONLY);
        read(fd_read, buffer, sizeof(buffer));
        close(fd_read);

        printf("Hijo: cadena recibida: %s\n", buffer);

        to_uppercase(buffer);

        int fd_write = open(fifoHijoAPadre, O_WRONLY);
        write(fd_write, buffer, sizeof(buffer));
        close(fd_write);
        exit(0);

     } else if (pid > 0) {
        // === Proceso Padre ===
        char msg[] = "hola soy tu padre";
        int fd = open(fifoPadreAHijo, O_WRONLY);
        write(fd, msg, strlen(msg) + 1);
        close(fd);

        fd = open(fifoHijoAPadre, O_RDONLY);
        read(fd, buffer, sizeof(buffer));


        printf("Cadena recibida en mayusculas: %s\n", buffer);
        wait(NULL);
        // Eliminar el FIFO
        unlink(fifoHijoAPadre);
        unlink(fifoPadreAHijo);


     } else {
        printf("No se pudo generar el proceso hijo del fork.");
        exit(1);
     }
     
     
 
    return 0;
}
