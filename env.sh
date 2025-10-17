#!/bin/bash

# Terminar la ejecución si un comando falla
set -e 

# Asegúrate de que el archivo .env exista
if [ ! -f .env ]; then
    echo "Error: El archivo .env no se encuentra. Crea uno con las credenciales necesarias."
    exit 1
fi

# Cargar las variables de entorno
source .env 

echo "Despliegue de la pila LAMP ..."
