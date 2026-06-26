#!/usr/bin/env bash

# RUTA AL ARCHIVO DE CONFIGURACIÓN DE ROFI
RASI_THEME="$HOME/.config/rofi/firefox-profiles.rasi" # Ajusta esta ruta si está en otro lado

# DEFINICIÓN DE PERFILES Y SUS COMANDOS
# Usamos un caso de Bash (case) para mapear el nombre con su comando exacto
declare -a Opciones=(
  "principal"
  "brave"
  "youtube"
  "UNAL"
)

# Unir las opciones con saltos de línea para pasárselas a Rofi
Seleccion=$(printf "%s\n" "${Opciones[@]}" | rofi -dmenu -i -p "Firefox Perfil:" -theme "$RASI_THEME")

# Ejecutar el comando según la opción seleccionada
case "$Seleccion" in
"principal")
  firefox --profile "$HOME/.config/mozilla/firefox/5kgll5fj.default-release" -no-remote &
  ;;
"brave")
  firefox --profile "$HOME/.config/mozilla/firefox/fYxUWjXE.Profile 2" -no-remote &
  ;;
"youtube")
  firefox --profile "$HOME/.config/mozilla/firefox/qVbwfYA8.Perfil 4" -no-remote &
  ;;
"UNAL")
  firefox --profile "$HOME/.config/mozilla/firefox/0AbhV36m.Perfil 3" -no-remote &
  ;;
*)
  # Si se presiona ESC o se cierra Rofi, no hace nada
  exit 0
  ;;
esac
