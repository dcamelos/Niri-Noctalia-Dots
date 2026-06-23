#!/usr/bin/env bash

sleep 2

STATE_FILE="$HOME/.cache/awww/current_wallpaper"
WALL_DIR="$HOME/Imágenes/wallpapers"

# ------------------------------------------------
# Iniciar daemon
# ------------------------------------------------

if ! pgrep -x "awww-daemon" >/dev/null; then
  awww-daemon &
  sleep 1
fi

# ------------------------------------------------
# Restaurar wallpaper guardado
# ------------------------------------------------

if [ -f "$STATE_FILE" ]; then
  SAVED_WALL=$(cat "$STATE_FILE")

  if [ -f "$SAVED_WALL" ]; then
    ~/.local/bin/mango/apply-wallpaper.sh "$SAVED_WALL"
    exit 0
  fi
fi

# ------------------------------------------------
# Fallback si no existe estado
# ------------------------------------------------

DEFAULT_WALL=$(find "$WALL_DIR" -type f | head -n 1)

if [ -n "$DEFAULT_WALL" ]; then
  ~/.local/bin/mango/apply-wallpaper.sh "$DEFAULT_WALL"
fi
