#!/usr/bin/env bash

# Directorios
WALL_DIR="$HOME/Imágenes/WALLS/wallpapers"
# Cambia esta ruta a la carpeta donde guardaste las miniaturas 889x500 (o 500x800)
CACHE_DIR="$HOME/Imágenes/WALLS/miniaturas"
RASI_CONF="$HOME/.config/rofi/WallSelect.rasi"

# 1. Obtener wallpaper actual para resaltar la fila
CURRENT_WALL=$(basename "$(qs -c noctalia-shell ipc call wallpaper get all | awk '{print $NF}')" 2>/dev/null)

# 2. Generar lista con iconos apuntando a la CACHE
LISTA=""
while read -r wall; do
  # El nombre es el original, pero el ICONO es el de la miniatura
  LISTA+="${wall}\0icon\x1f${CACHE_DIR}/${wall}\n"
done < <(ls "$WALL_DIR")

# 3. Calcular fila seleccionada
ROW=0
if [ -n "$CURRENT_WALL" ]; then
  ROW=$(ls "$WALL_DIR" | grep -nE "^${CURRENT_WALL}$" | cut -d: -f1)
  ((ROW--))
fi

# 4. Lanzar Rofi
choice=$(echo -e "$LISTA" | rofi -dmenu -i \
  -theme "$RASI_CONF" \
  -p "󰸉 Noctalia:" \
  -selected-row "${ROW:-0}" \
  -show-icons)

# 5. Aplicar (Usando la ruta original de WALL_DIR)
if [ -n "$choice" ]; then
  # Aplicamos el wallpaper original (alta calidad)
  qs -c noctalia-shell ipc call wallpaper set "$WALL_DIR/$choice" all

  # La notificación puede usar la miniatura para cargar más rápido
  notify-send "Noctalia" "Wallpaper: $choice" -i "$CACHE_DIR/$choice"
fi
