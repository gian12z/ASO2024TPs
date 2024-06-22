#!/bin/bash

# punto 1, generar un número aleatorio entre 1 y 100
numero_secreto=$(( RANDOM % 100 + 1 ))

echo "¡Bienvenido al juego de adivinanza!"
echo "El sistema eligio un número entre 1 y 100. ¿Puede adivinar cuál es?"

while true; do
    read -p "Introduzca el nuemro que crea que es: " intento

    if ! [[ "$intento" =~ ^[0-9]+$ ]]; then
        echo "Por favor, introduce un número válido."
        continue
    fi

    if (( intento < numero_secreto )); then
        echo "Demasiado bajo. Intente nuevamente."
    elif (( intento > numero_secreto )); then
        echo "Demasiado alto. Intente nuevamente."
    else
        echo "¡Felicidades! Usted adivino el número."
        break
    fi
done