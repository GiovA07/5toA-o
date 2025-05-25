#include <stdio.h>

// ➡ Dados dos números x e y en binario:
// ➡ Repetir hasta que y = 0
// ➡ x = x mod y
// ➡ intercambiar x e y

// ➡ Si x = 1 aceptar, sino rechazar
int main(int argc, char const *argv[])
{
    long long x, y;

    printf("Ingresa el numero x: ");
    scanf("%lld", &x);
    printf("\n");
    printf("Ingresa el numero y: ");
    scanf("%lld", &y);
    printf("\n");



    while(y != 0) {
        x = x % y;
        long long aux = y;
        y = x;
        x = aux;
    }

    if(x == 1) {
        printf("Los numeros x e y SI son coprimos");
    } else {
        printf("Los numeros x e y NO son coprimos");
    }
    
    return 0;
}
