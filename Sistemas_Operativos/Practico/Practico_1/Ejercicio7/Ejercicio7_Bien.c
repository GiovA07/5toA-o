// Este es el ejercicio 7, porque el que habia hecho nose porque era distinto XD.
    /* Implementar un programa en C que comunique al proceso padre con un proceso 
    hijo por medio de un *pipe* (ver `pipe()` syscall). 
    El proceso padre deberá enviarle un string y el hijo deberá responderle 
    con el string en mayúsculas. El proceso padre deberá mostrar el 
    identificador de proceso (pid) del hijo y la cadena recibida. */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <ctype.h>
#include <sys/types.h>
#include <sys/wait.h>

#define BUFFER_SIZE 50


void to_uppercase(char *str) {
    for (int i = 0; str[i]; i++) {
        str[i] = toupper((char)str[i]);
    }
}

int main(int argc, char const *argv[])
{
    int pipe1[2]; //padre -> nijo
    int pipe2[2]; //hijo -> padre

    char bufferPipe1[BUFFER_SIZE];
    char bufferPipe2[BUFFER_SIZE];

    pipe(pipe1);
    pipe(pipe2);

    int pid = fork();

    if (pid == 0) { //proceso hijo
        close(pipe1[1]); //cerrar extremo de escritura
        close(pipe2[0]); //cerrar extremo de lectura

        read(pipe1[0], bufferPipe1, BUFFER_SIZE);
        close(pipe1[0]);
        printf("Cadena recibida por el padre: %s\n", bufferPipe1);

        to_uppercase(bufferPipe1);

        write(pipe2[1], bufferPipe1, BUFFER_SIZE);
        close(pipe2[1]);
        exit(0);

    } else if (pid > 1) { 
         // === Proceso Padre ===

         //Cerramos los extremos que no usamos 
        close(pipe1[0]); //cerrar extremo de lectura
        close(pipe2[1]); //cerrar extremo de escritura

        char msg[] = "Hola soy tu padre";
        write(pipe1[1], msg, strlen(msg) + 1);
        close(pipe1[1]); //cerrar extremo de escritura

        read(pipe2[0], bufferPipe2, BUFFER_SIZE);
        close(pipe2[0]); //cerrar extremo de lectura

        wait(NULL);

        printf("PID del hijo: %d\n", pid);
        printf("Cadena recibida en mayusculas: %s\n", bufferPipe2);


    } else {
        printf("Error al crear proceso hijo en fork. ");
        exit(1);
    }
    
    

    return 0;
}
