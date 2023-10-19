#!/bin/bash

# Verificar si se proporcionó una ruta como argumento
if [ -z "$1" ]; then
  echo "Debe proporcionar una ruta como argumento"
  exit 1
fi

# Si es un directorio lo comprime y encripta

if [ -d "$1" ]; then
  
  # Comprimir el directorio
  tar -cvf "$1.tar.gz" "$1"

  # Solicitar parámetro de contraseña

  read -s -p "Ingrese la contraseña para el archivo comprimido: " password

  # Encriptar el archivo comprimido

  openssl enc -aes-256-cbc -salt -pbkdf2 -in "./$1.tar.gz" -out "./$1.keylover" -pass pass:$password


  # Eliminar el directorio
  rm -rf "$1"

  # Elimina el archivo comprimido

  rm -rf "$1.tar.gz"

  exit 1

fi

# Si es un archivo con extension .keylover lo desencripta y descomprime

if [ -f "$1" ]; then

  # Verificar si la extensión es .keylover

  if [[ "$1" != *.keylover ]]; then
    echo "El archivo no tiene la extensión .keylover"
    exit 1
  fi

  # Solicitar parámetro de contraseña

  read -s -p "Ingrese la contraseña para el archivo comprimido: " password

  # Desencriptar el archivo comprimido

  openssl enc -aes-256-cbc -d -pbkdf2 -in "./$1" -out "./$1.tar.gz" -pass pass:$password

  # Descomprimir el archivo

  tar -xvf "$1.tar.gz"

  # Eliminar el archivo comprimido

  rm -rf "$1.tar.gz"

  # Eliminar el archivo encriptado

  rm -rf "$1"

  exit 1

fi





