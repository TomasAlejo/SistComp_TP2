#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Uso: %s <gini_float>\n", argv[0]);
        return 1;
    }

    float gini = atof(argv[1]);
    int rounded = (int)roundf(gini);
    int final_value = rounded + 1;

    printf("%d\n", final_value);
    return 0;
}
