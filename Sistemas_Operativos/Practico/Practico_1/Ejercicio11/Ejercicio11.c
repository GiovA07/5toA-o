#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <time.h>

// Función para generar un arreglo de tamaño N con valores aleatorios
void genArrayAleatorio(int *arr, int N) {
    // Semilla
    srand(time(NULL));

    for (int i = 0; i < N; i++) {
        arr[i] = rand() % 100 + 1; // Valores en el rango [1, 100]
    }
}
int minArrayInt(int *arr, int init, int end) {
    int min = arr[init];
    for (int i = init; i <= end; i++) {
       if (min > arr[i]) {
        min = arr[i];
       }
       
    }
    return min;
}


// Función para imprimir un arreglo
void imprimirArreglo(int *arr, int N) {
    printf("Arreglo generado:\n");
    for (int i = 0; i < N; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

int main(int argc, char const *argv[]) {
    int N;
    int p;

    // Pedimos al usuario el tamaño del arreglo
    printf("Ingresa el tamaño del arreglo (N): ");
    scanf("%d", &N);
    int arr[N];
    genArrayAleatorio(arr, N);
    imprimirArreglo(arr, N);
    printf("Ingresa en cuantas p porciones dividir el arreglo: ");
    scanf("%d", &p);
    printf("\n");


    int pid;
    int fds[2]; //pipe
    pipe(fds);

    for (int i = 0; i < p; i++) {
        pid = fork();
        if (pid < 0) {
            perror("Error al crear proceso hijo");
            exit(EXIT_FAILURE);
        }

        if (pid == 0) {
            int init = i * (N / p);
            int end = (i == p - 1) ? N - 1 : (init + (N / p) - 1);

            close(fds[0]); //cierro el q lee
            int min = minArrayInt(arr, init, end);
            write(fds[1], &min, sizeof(min));
            close(fds[1]); //cierro el q eescribe
            exit(1);

        }
        
    }

    if (pid > 0){
        // Dentro del padre
        close(fds[1]); // Cerrar extremo de escritura
        int min_global = arr[0];
        for (int i = 0; i < p; i++) {
            int min_hijo;
            read(fds[0], &min_hijo, sizeof(min_hijo)); // Leer del pipe
            if (min_hijo < min_global) {
                min_global = min_hijo;
            }
        }
        close(fds[0]);

        for (int i = 0; i < p; i++) {
            wait(NULL); // Esperar a que terminen todos los hijos
        }

        printf("El mínimo global es: %d\n", min_global);
    }
    

    return 0;
}
