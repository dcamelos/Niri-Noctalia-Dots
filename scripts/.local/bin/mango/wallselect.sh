#!/usr/bin/env bash

# ------------------------------------------------
# Directorios
# ------------------------------------------------

WALL_DIR="$HOME/Imágenes/wallpapers"
CACHE_DIR="$HOME/.cache/noctalia/wallpapers"
RASI_CONF="$HOME/.config/rofi/WallSelect.rasi"

STATE_FILE="$HOME/.cache/awww/current_wallpaper"

# ------------------------------------------------
# Iniciar daemon
# ------------------------------------------------

if ! pgrep -x "awww-daemon" >/dev/null; then
  awww-daemon &
  sleep 1
fi

# ------------------------------------------------
# Wallpaper actual
# ------------------------------------------------

CURRENT_WALL=""

if [ -f "$STATE_FILE" ]; then
  CURRENT_WALL=$(basename "$(cat "$STATE_FILE")")
fi

# ------------------------------------------------
# Generar lista para Rofi
# ------------------------------------------------

LISTA=""
ROW=0
ITER=0

while read -r wall; do
  [ -z "$wall" ] && continue

  FILE_NAME=$(basename "$wall")

  if [ "$FILE_NAME" = "$CURRENT_WALL" ]; then
    ROW=$ITER
  fi

  ICON_PATH="$CACHE_DIR/$FILE_NAME"

  if [ ! -f "$ICON_PATH" ]; then
    ICON_PATH="$wall"
  fi

  LISTA+="${FILE_NAME}\0icon\x1f${ICON_PATH}\n"

  ((ITER++))

done < <(find "$WALL_DIR" -type f \( \
  -iname "*.jpg" -o \
  -iname "*.jpeg" -o \
  -iname "*.png" -o \
  -iname "*.JPG" -o \
  -iname "*.JPEG" -o \
  -iname "*.PNG" -o \
  -iname "*.webp" -o \
  -iname "*.gif" \
  \))

# ------------------------------------------------
# Lanzar Rofi
# ------------------------------------------------

choice=$(echo -e "$LISTA" | rofi -dmenu -i \
  -theme "$RASI_CONF" \
  -p "󰸉 MangoWM:" \
  -selected-row "$ROW" \
  -show-icons)

# ------------------------------------------------
# Aplicar wallpaper seleccionado
# ------------------------------------------------

if [ -n "$choice" ]; then
  FULL_PATH="$WALL_DIR/$choice"

  if [ -f "$FULL_PATH" ]; then
    ~/.local/bin/mango/apply-wallpaper.sh "$FULL_PATH"
  fi
fi
