#!/bin/bash

LOCAL_FOLDER="$HOME/Documents/Universidad"
REMOTE_GDRIVE_FOLDER="gdrive:/Universidad"


# Preguntar al usuario la dirección de la sincronización
echo "¿Qué acción deseas realizar? 🤔"
echo "1) Sincronizar LOCAL -> GDRIVE 🌍"
echo "2) Sincronizar GDRIVE -> LOCAL 🖥️"
read -p "Selecciona una opción (1 o 2): " SYNC_OPTION

# Función para sincronizar LOCAL -> GDRIVE
sync_local_to_gdrive() {
        rclone sync "$LOCAL_FOLDER" "$REMOTE_GDRIVE_FOLDER" --progress --verbose
        if [ $? -eq 0 ]; then
            notify-send "Sincronización completada 🎉" "Se ha sincronizado la carpeta $LOCAL_FOLDER con $REMOTE_GDRIVE_FOLDER"
            echo "✅ Sincronización completada: LOCAL -> GDRIVE 🌍"
        else
            notify-send "Error en la sincronización ❌" "Ha ocurrido un error al sincronizar la carpeta $LOCAL_FOLDER con $REMOTE_GDRIVE_FOLDER"
            echo "❌ Error en la sincronización: LOCAL -> GDRIVE 🌍"
        fi
}

# Función para sincronizar GDRIVE -> LOCAL
sync_gdrive_to_local() {
    show_differences
    read -p "¿Deseas continuar con la sincronización? (s/n): " CONTINUE
    if [ "$CONTINUE" = "s" ]; then
        rclone sync "$REMOTE_GDRIVE_FOLDER" "$LOCAL_FOLDER" --progress --verbose
        if [ $? -eq 0 ]; then
            notify-send "Sincronización completada 🎉" "Se ha sincronizado la carpeta $REMOTE_GDRIVE_FOLDER con $LOCAL_FOLDER"
            echo "✅ Sincronización completada: GDRIVE -> LOCAL 🖥️"
        else
            notify-send "Error en la sincronización ❌" "Ha ocurrido un error al sincronizar la carpeta $REMOTE_GDRIVE_FOLDER con $LOCAL_FOLDER"
            echo "❌ Error en la sincronización: GDRIVE -> LOCAL 🖥️"
        fi
    else
        echo "Sincronización cancelada por el usuario."
    fi
}

# Ejecutar la opción seleccionada
if [ "$SYNC_OPTION" -eq 1 ]; then
    sync_local_to_gdrive
elif [ "$SYNC_OPTION" -eq 2 ]; then
    sync_gdrive_to_local
else
    notify-send "Opción no válida 🚫" "No se ha realizado ninguna acción"
    echo "🚫 Opción no válida. Por favor, selecciona 1 o 2."
fi
