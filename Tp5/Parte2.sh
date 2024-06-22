#!/bin/bash
# punto 8 mostrar la edad probable de un nombre ingresado por el usuario.
# Verifica si se ingresa un nombre como argumento
if [ $# -eq 0 ]; then
    echo "Uso: $0 <nombre>"
    exit 1
fi

# Nombre ingresado por el usuario
NOMBRE="$1"

# Link de la API
URL="https://api.genderize.io/?name=${NOMBRE}"

# Realiza la solicitud a la API y guarda la respuesta
RESPUESTA=$(curl -s "${URL}")

# Verifica si la respuesta contiene un error
if echo "$RESPUESTA" | grep -q "error"; then
    echo "Error al obtener los datos de género. Verifique el nombre ingresado."
    exit 1
fi

# Extrae los datos relevantes de la respuesta
GENERO=$(echo "$RESPUESTA" | jq -r '.gender')
PROBABILIDAD=$(echo "$RESPUESTA" | jq -r '.probability')
CONTEO=$(echo "$RESPUESTA" | jq -r '.count')

# Muestra los datos de género
echo "Datos para el nombre ${NOMBRE}:"
echo "Género probable: ${GENERO}"
echo "Probabilidad: ${PROBABILIDAD}"
echo "Conteo: ${CONTEO}"