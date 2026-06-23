#!/usr/bin/env bash

# 1. Definimos tus carpetas específicas del Home
# Esto evitará buscar en carpetas del sistema o archivos ocultos de configuración
CARPETAS=(
  "$HOME/Descargas"
  "$HOME/Documentos"
  "$HOME/Escritorio"
  "$HOME/Imágenes"
  "$HOME/Música"
  "$HOME/Plantillas"
  "$HOME/Proyectos"
  "$HOME/Público"
  "$HOME/Scripts"
  "$HOME/Vídeos"
)

# 2. Generamos la lista de rutas completas
# Verificamos que cada carpeta exista antes de buscar para evitar errores
LISTA_COMPLETA=$(find "${CARPETAS[@]}" -type f \( -iname "*.pdf" -o -iname "*.epub" \) 2>/dev/null)

# 3. Rofi mostrando el PATH completo
# Quitamos el comando 'basename' para que Rofi reciba la ruta completa
SELECCION_RUTA=$(echo "$LISTA_COMPLETA" | rofi -dmenu -i -p "📖 Libros" -theme "/home/david/.config/rofi/zathura.rasi")

# 4. Abrimos directamente la selección
if [ -n "$SELECCION_RUTA" ]; then
  # Como SELECCION_RUTA ya contiene el path completo, no hace falta buscarlo con grep
  if [ -f "$SELECCION_RUTA" ]; then
    zathura "$SELECCION_RUTA" &
    disown
  fi
fi
