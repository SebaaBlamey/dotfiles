#!/bin/bash

check_updates() {
    clear
    echo -e "🔍 Buscando actualizaciones..."
    yay -Sy &> /dev/null
    yay_updates=$(yay -Qu | wc -l)
    clear
    echo -e "📦 Actualizaciones pendientes: \033[1;32m$yay_updates\033[0m"
}

ask_for_update() {
    read -p "¿Desea actualizar el sistema? [Y/n]: " choice
    case "$choice" in
        [yY][eE][sS]|[yY]|"")
            echo -e "🔄 Actualizando sistema..."
            yay -Syu --noconfirm
            echo -e "✅ \033[1;32mSistema actualizado.\033[0m Saliendo..."
            ;;
        [nN][oO]|[nN])
            echo -e "🚪 \033[1;31mSaliendo...\033[0m"
            ;;
        *)
            echo -e "❌ \033[1;31mOpción no válida. Saliendo...\033[0m"
            ;;
    esac
}

if [ "$1" == "--check" ]; then
    check_updates
    ask_for_update
else
    echo -e "Uso: \033[1;34m$0 [--check]\033[0m"
fi
