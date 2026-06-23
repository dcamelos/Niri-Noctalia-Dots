#!/usr/bin/env bash

WALL_DIR="$HOME/Imágenes/wallpapers"
INTERVAL=3600

while true; do
  WALL=$(find "$WALL_DIR" -type f \( \
    -iname "*.jpg" -o \
    -iname "*.jpeg" -o \
    -iname "*.png" -o \
    -iname "*.JPG" -o \
    -iname "*.JPEG" -o \
    -iname "*.PNG" -o \
    -iname "*.webp" -o \
    -iname "*.gif" \
    \) | shuf -n 1)

  if [ -n "$WALL" ]; then
    ~/.local/bin/mango/apply-wallpaper.sh "$WALL"
  fi

  sleep "$INTERVAL"
done
