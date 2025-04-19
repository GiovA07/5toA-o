#include <stdio.h>
#include <stdlib.h> /* wait() */
#include <sys/wait.h>
#include <unistd.h> /* UNIX syscalls */
#include <string.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>


void invertString (char *str);

void invertString (char *str) {
    int longitud = strlen(str);
    for (int i = 0; i < longitud / 2; i++) {
        char temp = str[i];
        str[i] = str[longitud - i - 1];
        str[longitud - i - 1] = temp;
    }
}


int main(int argc, char const *argv[])
{
    const char *fifoName = "./myfifo";
    int pid;
    char buffer[100];

        
    if (mkfifo(fifoName, 0666) == -1) {
        printf("No se creo el fifo");
        exit(1);
     }
 
    //creo el fork
    pid = fork();

    if (pid < 0) {
        perror("Error al crear el proceso hijo");
        exit(EXIT_FAILURE);
    }

    if (pid == 0) { //hijo
        int fd = open(fifoName, O_RDONLY); //O_RDONLY ES DE LECTURA SOLAMENTE
        if (fd == -1) {
            perror("Error al abrir el FIFO para lectura");
            exit(EXIT_FAILURE);
        }

        read(fd, buffer, sizeof(buffer));
        invertString(buffer);

        printf("Hijo: la cadena invertida es: %s \n", buffer);
        close(fd);

        // fd = open(fifoName, O_WRONLY); //O_WRONLY ES DE ESCRITURA SOLAMENTE
        // if (fd == -1) {
        //     perror("Error al abrir el FIFO para ESCRITURA");
        //     exit(EXIT_FAILURE);
        // }
        // write(fd, buffer, strlen(buffer) + 1);
        // close(fd);
        
    } else { //padre
        char msg[] = "Hola soy tu padre";
        int fd = open(fifoName, O_WRONLY);
        if (fd == -1) {
            perror("Error al abrir el FIFO para escritura \n");
            exit(EXIT_FAILURE);
        }
        write(fd, msg, strlen(msg)+1);
        close(fd);

        // Eliminar el FIFO
        unlink(fifoName);
    }

    return 0;
}
