#include <stdio.h>
#include <stdlib.h> /* wait() */
#include <sys/wait.h>
#include <unistd.h> /* UNIX syscalls */
#include <string.h>



void invertString (char *str);

void invertString (char *str) {
    int longitud = strlen(str);
    for (int i = 0; i < longitud / 2; i++) {
        char temp = str[i];
        str[i] = str[longitud - i - 1];
        str[longitud - i - 1] = temp;
    }
}


int main(int argc, char const *argv[]){

    int pipe1[2];
    int pid;
    char buffer[100];

    //creo la pipe
    if (pipe(pipe1) == -1) {
        perror("Error al crear el pipe");
        exit(EXIT_FAILURE);
    }

    //creo el fork
    pid = fork();

    if (pid < 0) {
        perror("Error al crear el proceso hijo");
        exit(EXIT_FAILURE);
    }


    if (pid == 0) { //proceso hijo

        close(pipe1[1]); // Cerrar el extremo de escritura de la pipe
        read(pipe1[0], buffer, 100);
        close(pipe1[0]);

        invertString(buffer);

        printf("La cadena invertida es: %s\n", buffer);

    } else { //proceso padre
        char msg[] = "Hola soy tu padre";
        close(pipe1[0]); // Cerrar el extremo de lectura de la pipe
        write(pipe1[1], msg, strlen(msg) + 1);
        close(pipe1[1]);
        wait(NULL); // Esperar al proceso hijo

    }
    

    return 0;
}

