#include <stdio.h>
#include <stdlib.h>

extern int gini_process(float gini_value); // Declaramos la función ensambladora

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Uso: %s <gini_float>\n", argv[0]);
        return 1;
    }

    // Convertir el argumento a float
    float gini = atof(argv[1]);

    // Llamar a la rutina en ensamblador
    int result = gini_process(gini);

    // Mostrar el resultado final
    printf("Índice GINI procesado +1: %d\n", result);

    return 0;
}

