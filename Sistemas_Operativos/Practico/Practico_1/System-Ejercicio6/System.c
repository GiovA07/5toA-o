
#include <stdio.h>
#include <stdlib.h> /* wait() */
#include <sys/wait.h>
#include <unistd.h> /* UNIX syscalls */

int system(const char* string) {
    int pid;

    pid = fork();

    if(pid == 0) {
        //hijo
        execl("/bin/sh", "sh", "-c", string, (char*)NULL);

        //Si no se ejecuta
        printf("Ooops, exec() failed!\n"); 
        exit(-1);
    } else if (pid > 0) {
        //padre
        int child,status;
        child = wait(&status);
        return status;
    } else {
        printf("Ooops, folk() failed!\n"); 
        exit(-1);
    }
}

int main(int argc, char const *argv[]) {
    if (argc != 2) {
        // Verifica que se pase exactamente un comando como argumento.
        printf("Uso: %s \"<comando>\"\n", argv[0]);
        return 1;
    }

    // Toma el comando directamente desde argv[1].
    const char* comando = argv[1];

    printf("Ejecutando el comando: %s\n", comando);

    // Llama a la función custom_system para ejecutar el comando.
    int resultado = system(comando);

    if (resultado == -1) {
        printf("Hubo un error al ejecutar el comando.\n");
    } else {
        printf("El comando terminó con estado: %d\n", resultado);
    }

    return 0;
}