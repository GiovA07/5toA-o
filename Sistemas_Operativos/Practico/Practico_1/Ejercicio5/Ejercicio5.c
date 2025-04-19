#include <stdio.h>
#include <stdlib.h>


int main(int argc, char *argv[]) {
    if (argc != 2) {
        return 1; // Retorna error si no se proporciona argumento
    }

    // Convierte el argumento en un numero.
    int exit_status = atoi(argv[1]);

    return exit_status;
}

// Para verificar la salida debemos poner el siguiente comando en consola: echo $?

// Para ejecutar otro comando en caso que se realice con exito es con &&           ./Ejercicio5 0 &&  echo "Ejecucion con exito"
// Para ejecutar otro comando en caso que no se realice con exito es con ||        ./Ejercicio5 1 ||  echo "Ejecucion fallida"

    /* Tener en cuenta:
    El código de salida (exit status) de un proceso en UNIX es al reves de C:

    0 significa éxito (sin errores).

    Cualquier otro número (1-255) significa error o fallo.
    */