    ; gini.asm
    global gini_process   ; Definir la etiqueta de la función

    section .text
gini_process:
    ; El valor de gini se pasa como parámetro en la pila (float).
    fld dword [esp + 4]      ; Cargar el valor de gini (float) en el registro ST(0).
    fistp dword [esp + 8]    ; Convertir el valor flotante a entero y almacenarlo en la pila.
    
    ; Obtener el valor entero de la pila
    mov eax, [esp + 8]       ; Cargar el valor entero en eax.

    ; Sumar 1 al valor entero
    add eax, 1            ; Sumar 10 al valor de eax.

    ; Devolver el resultado
    ret                      ; Regresar, el valor final está en eax (registro de retorno en x86).

