#!/bin/bash

# ----------------------------------------
# Script de compilación para el TP2
# Este script organiza la compilación de los archivos fuente escritos en C y ensamblador,
# y genera el ejecutable dentro de una carpeta separada llamada build/
# ----------------------------------------

# Definir directorios base
SRC_DIR=$(dirname "$0")              # Ruta absoluta al directorio donde está este script (src/)
BUILD_DIR="$SRC_DIR/../build"        # Carpeta build/ en la raíz del proyecto

# Crear el directorio build si no existe
mkdir -p "$BUILD_DIR"

# LIMPIEZA DE BINARIOS Y OBJETOS ANTERIORES
# ----------------------------------------
# Elimina archivos previamente compilados para evitar conflictos.
# Los archivos .o (object) y el ejecutable final serán regenerados.
echo "Limpiando archivos anteriores en $BUILD_DIR..."
rm -f "$BUILD_DIR/gini_process.o" "$BUILD_DIR/gini.o" "$BUILD_DIR/gini_process"

# COMPILACIÓN DEL ARCHIVO EN C
# ----------------------------------------
# Compila gini_process.c utilizando gcc para 32 bits.
# -m32: Fuerza compilación para arquitectura de 32 bits (x86).
# -g3: Incluye información de depuración detallada para usar con GDB.
# -c: Solo compila (no enlaza).
# -o: Especifica el nombre del archivo de salida (.o = objeto).
echo "Compilando gini_process.c..."
gcc -m32 -g3 -c "$SRC_DIR/gini_process.c" -o "$BUILD_DIR/gini_process.o"

# COMPILACIÓN DEL ARCHIVO EN ENSAMBLADOR
# ----------------------------------------
# Compila gini.asm utilizando NASM.
# -f elf32: Genera código objeto en formato ELF de 32 bits.
# -g: Genera información de depuración.
# -F dwarf: Usa el formato DWARF, compatible con depuradores como GDB.
# -o: Especifica el archivo de salida objeto (.o).
echo "Compilando gini.asm..."
nasm -f elf32 -g -F dwarf "$SRC_DIR/gini.asm" -o "$BUILD_DIR/gini.o"

# VINCULACIÓN DE OBJETOS PARA GENERAR EL EJECUTABLE
# ----------------------------------------
# Combina los archivos objeto generados (.o) en un único ejecutable.
# -m32: Enlace en 32 bits.
# -g3: Conserva la información de depuración.
# El resultado es un ejecutable llamado gini_process.
echo "Vinculando los archivos objeto..."
gcc -m32 -g3 "$BUILD_DIR/gini_process.o" "$BUILD_DIR/gini.o" -o "$BUILD_DIR/gini_process"

# VERIFICACIÓN FINAL
# ----------------------------------------
# Se verifica si la compilación fue exitosa mediante el código de salida ($?).
# En caso de éxito, se informa la ubicación del ejecutable.
# En caso de error, se aborta el script con exit 1.
if [ $? -eq 0 ]; then
    echo "Compilación y vinculación completadas con éxito."
    echo "Ejecutable generado en: $BUILD_DIR/gini_process"
else
    echo "Error en la compilación o vinculación."
    exit 1
fi
