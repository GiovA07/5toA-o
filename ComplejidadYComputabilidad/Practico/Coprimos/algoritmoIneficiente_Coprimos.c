//➡ Dados dos números x e y en binario:
// ➡ Para todo z <= min(x,y) hacer
// ➡ Si z|x y z|y, terminar y rechazar
// ➡ Sino aceptar

#include <stdio.h>

int main(int argc, char const *argv[])
{
    long long x, y;

    printf("Ingresa el numero x: ");
    scanf("%lld", &x);
    printf("\n");
    printf("Ingresa el numero y: ");
    scanf("%lld", &y);
    printf("\n");

    long long min = (x < y) ? x : y;
    
    for (long long z = 2; z <= min; z++){
        if(x % z == 0 && y % z == 0){
            printf("Los numeros %lld y %lld NO son coprimos", x, y);
            return 0;
        }
    }

    printf("Los numeros %lld y %lld SI son coprimos", x, y);
    return 0;
}
