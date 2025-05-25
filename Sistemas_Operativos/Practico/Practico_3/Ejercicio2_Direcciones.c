#include <stdio.h>
#include <stdlib.h>

//Segmento data
int var_global = 77;

//Segmento text
int func_example(){}

int main(int argc, char const *argv[])
{
    //Segmento Stack
    int varLocal = 777;
    //Segmento Heap
    int *heap_var = (int *)malloc(sizeof(int));

    printf("Dirección de código (función): %p\n", &func_example);
    printf("Dirección de datos (variable global): %p\n",&var_global);
    printf("Dirección de heap (malloc): %p\n", heap_var);
    printf("Dirección de stack (variable local): %p\n",&varLocal);

    free(heap_var);
    return 0;
}
