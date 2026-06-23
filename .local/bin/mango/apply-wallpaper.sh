#!/usr/bin/env bash

WALL="$1"

if [ ! -f "$WALL" ]; then
  notify-send "Wallpaper" "Archivo no encontrado"
  exit 1
fi

# ------------------------------------------------
# Variables
# ------------------------------------------------

STATE_FILE="$HOME/.cache/awww/current_wallpaper"

mkdir -p "$(dirname "$STATE_FILE")"

# ------------------------------------------------
# Iniciar daemon
# ------------------------------------------------

if ! pgrep -x "awww-daemon" >/dev/null; then
  awww-daemon &
  sleep 1
fi

# ------------------------------------------------
# Aplicar wallpaper
# ------------------------------------------------

awww img "$WALL" \
  --transition-type grow \
  --transition-fps 60 \
  --transition-duration 1.5 \
  --transition-pos center

# ------------------------------------------------
# Guardar estado
# ------------------------------------------------

echo "$WALL" >"$STATE_FILE"

# ------------------------------------------------
# Generar colores automáticamente
# ------------------------------------------------

matugen image "$WALL" \
  --source-color-index 0 \
  --mode dark \
  --type scheme-vibrant

# ------------------------------------------------
# Recargar Waybar
# ------------------------------------------------

killall waybar >/dev/null 2>&1

waybar \
  -c ~/.config/mango/waybar/config.jsonc \
  -s ~/.config/mango/waybar/style.css \
  >/dev/null 2>&1 &

# ------------------------------------------------
# Recargar SwayNC
# ------------------------------------------------

swaync-client -rs >/dev/null 2>&1

# ------------------------------------------------
# Notificación
# ------------------------------------------------

notify-send "Matugen" "Tema actualizado" -i "$WALL"
