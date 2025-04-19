#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>

int commandExec(const char* string) {
    int pid;

    pid = fork();

    if(pid == 0) {
        //hijo
        execl("/bin/sh", "sh", "-c", string, NULL);

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

    if (argc < 2) {
        fprintf(stderr, "Uso: %s cmd [args]\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    if (strcmp(argv[2], "&") == 0) {
        // Ejecutar en segundo plano
        const char* comando = argv[1];
        int pid = fork();
        if (pid == 0) {
            execl("/bin/sh", "sh", "-c", comando, NULL);
        }
        //NO hago el wait ya que el padre no tiene que esperar.
        
    } else if (strcmp(argv[2], "|") == 0) {
        const char* comando1 = argv[1];
        const char* comando2 = argv[3];
        // Manejar una pipe
        int pipe1[2];
        int pid1;
        int pid2;
        char buffer[100];

        if (pipe(pipe1) < 0) {  // Crear la pipe
            perror("Error al crear la pipe");
            exit(EXIT_FAILURE);
        }

        pid1 = fork();

        if (pid1 == 0) { //hijo
            close(pipe1[0]);
            // Usando dup2(fd_file, STDOUT_FILENO), le estás diciendo al sistema que "redirija" lo que se escriba en STDOUT al archivo asociado a fd_file.
            if (dup2(pipe1[1], STDOUT_FILENO) < 0) { //salida estándar (STDOUT)
                perror("Error en dup2 para comando1");
                exit(EXIT_FAILURE);
            }

            close(pipe1[1]); //ya lo redirigi hacia aca

            execl("/bin/sh", "sh", "-c", comando1, NULL);
            perror("Error al ejecutar comando1");
            exit(EXIT_FAILURE);

        } // el padre no hace nada

        pid2 = fork();
        if (pid2 == 0) {
            close(pipe1[1]);
            // Usando dup2(fd_file, STDOUT_FILENO), le estás diciendo al sistema que "redirija" lo que se escriba en STDOUT al archivo asociado a fd_file.
            if (dup2(pipe1[0], STDIN_FILENO) < 0) { //entrada estándar (STDIN)
                perror("Error en dup2 para comando2");
                exit(EXIT_FAILURE);
            }
            close(pipe1[0]);

            execl("/bin/sh", "sh", "-c", comando2, NULL);
            //todo lo que se ejecuta a partir de aca es solo si sale error del execl
            perror("Error al ejecutar comando2");
            exit(EXIT_FAILURE);

        }

    } else if (strcmp(argv[2], ";")  == 0) {            //
        const char* comando1 = argv[1];
        const char* comando2 = argv[3];
        commandExec(comando1);
        commandExec(comando2);

    } else if (strcmp(argv[2], "&&") == 0) {
        const char* comando1 = argv[1];
        const char* comando2 = argv[3];
        int status = commandExec(comando1);
        if (status == 0)
            commandExec(comando2);
            //aca es como hacer en el mismo else despues del primer comando hacer el wait, porque yo lo dividi en 2 partes, aunq es lo mismo.

    } else if (strcmp(argv[2], "||")  == 0) {
        const char* comando1 = argv[1];
        const char* comando2 = argv[3];
        int status = commandExec(comando1);
        
        // Solo se ejecuta comando2 si comando1 NO se ejecutó exitosamente.
        if (!(WIFEXITED(status) && WEXITSTATUS(status) == 0)) {
            printf("DEBUG: salió con código: %d\n", WEXITSTATUS(status));
            printf("DEBUG: salió con código: %d\n", WIFEXITED(status));
            commandExec(comando2);
        }

    } else if (strcmp(argv[2], "<") == 0) {
        const char* comando1 = argv[1];
        const char* archive = argv[3];

        int pid, status;

        pid = fork();

        if (pid < 0) {
            perror("Error en fork");
            exit(EXIT_FAILURE);
        }

        if (pid == 0) { //hijo
            int fd = open(archive, O_RDONLY);
            if (dup2(fd, STDIN_FILENO) < 0) { //entrada estándar (STDIN)
                perror("Error en dup2 para el archivo");
                exit(EXIT_FAILURE);
            }

            close(fd);

            execl("/bin/sh", "sh", "-c", comando1, (char*)NULL);
            perror("Error en execl");
            exit(EXIT_FAILURE);

        } else {
            waitpid(pid, &status, 0);
        }
        

    } else if (strcmp(argv[2], ">") == 0) {
        const char* comando1 = argv[1];
        const char* archive = argv[3];
        int pid;
        
        pid = fork();

        if (pid < 0) {
            perror("Error en fork");
            exit(EXIT_FAILURE);
        }
        if (pid == 0) {
            int fd = open(archive, O_WRONLY | O_CREAT | O_TRUNC);
            if (dup2(fd, STDOUT_FILENO) < 0) {
                perror("Error en dup2 para el archivo");
                exit(EXIT_FAILURE);
            }
            close(fd);
            execl("/bin/sh", "sh", "-c", comando1, (char*)NULL);
            perror("Error en execl");
            exit(EXIT_FAILURE);
        } else {
            wait(NULL);
        }
        
        

    } else if (strcmp(argv[2], ">>") == 0) {
        const char* comando1 = argv[1];
        const char* archive = argv[3];
        int pid;
        
        pid = fork();

        if (pid < 0) {
            perror("Error en fork");
            exit(EXIT_FAILURE);
        }
        if (pid == 0) {
            int fd = open(archive, O_WRONLY | O_CREAT | O_APPEND);
            if (dup2(fd, STDOUT_FILENO) < 0) {
                perror("Error en dup2 para el archivo");
                exit(EXIT_FAILURE);
            }
            close(fd);
            execl("/bin/sh", "sh", "-c", comando1, (char*)NULL);
            perror("Error en execl");
            exit(EXIT_FAILURE);
        } else {
            wait(NULL);
        }
    } else {
        fprintf(stderr, "Comando no reconocido\n");
        exit(EXIT_FAILURE);
    }

    return 0;
}
