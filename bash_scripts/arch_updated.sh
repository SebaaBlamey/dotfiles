#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "🔒 Se necesitan permisos de superusuario para ejecutar este script."
    sudo "$0" "$@"
    exit
fi

# Función para contar los paquetes por actualizar
count_updates() {
    echo "🔍 Verificando actualizaciones disponibles..."
    updates=$(checkupdates | wc -l)
    echo "📦 Total de paquetes por actualizar: $updates"
}

# Función para actualizar el sistema
update_system() {
    echo "⚙️ Actualizando la base de datos de paquetes..."
    sudo pacman -Sy

    echo "⬆️ Actualizando los paquetes instalados..."
    sudo pacman -Su --noconfirm

    echo "🧹 Limpiando paquetes huérfanos..."
    sudo pacman -Rns $(pacman -Qdtq) --noconfirm

    echo "♻️ Limpiando caché de paquetes antiguos..."
    sudo pacman -Sc --noconfirm

    echo "🎉 El sistema está completamente actualizado."
}

# Contar actualizaciones disponibles
count_updates

# Preguntar al usuario si desea proceder con la actualización
if [ "$updates" -eq 0 ]; then
    echo "✅ No hay paquetes por actualizar. Tu sistema ya está actualizado."
else
    read -p "¿Deseas actualizar los paquetes ahora? (s/n): " response
    case "$response" in
        [sS][iI] | [sS])
            update_system
            ;;
        *)
            echo "🚫 Actualización cancelada por el usuario."
            ;;
    esac
fi
