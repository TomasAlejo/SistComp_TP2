#!/bin/bash

# Limpiar archivos anteriores
echo "Limpiando archivos antiguos..."
rm -f gini_process.o gini.o gini_process

# Compilar el archivo C
echo "Compilando gini_process.c..."
gcc -m32 -c gini_process.c -o gini_process.o

# Compilar el archivo ensamblador
echo "Compilando gini.asm..."
nasm -f elf32 gini.asm -o gini.o

# Vincular los archivos objeto
echo "Vinculando los archivos objeto..."
gcc -m32 gini_process.o gini.o -o gini_process

# Verificar si la compilación fue exitosa
if [ $? -eq 0 ]; then
    echo "Compilación y vinculación completadas con éxito."
else
    echo "Error en la compilación o vinculación."
    exit 1
fi

# Mostrar el archivo compilado
echo "El ejecutable gini_process ha sido creado exitosamente."

