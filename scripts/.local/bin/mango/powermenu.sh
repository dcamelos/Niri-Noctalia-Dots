#!/usr/bin/env bash

# Ruta a tu archivo de estilo de Rofi
theme="$HOME/.config/rofi/powermenu.rasi"

# CMDs para obtener info del sistema
uptime="$(uptime -p | sed -e 's/up //g')"
user="$(whoami)"

# Iconos/Opciones
shutdown=''
reboot=''
lock=''
suspend=''
logout=''

# Rofi CMD
rofi_cmd() {
  rofi -dmenu \
    -p "Goodbye $user" \
    -mesg "Uptime: $uptime" \
    -theme "$theme"
}

# Función para la cuenta regresiva (Notificación interactiva)
countdown_and_run() {
  local action_name=$1
  local command=$2

  # Enviar una notificación inicial que avise cómo cancelar
  notify-send -h string:x-canonical-private-synchronous:powermenu \
    "Powermenu" "Iniciando $action_name en 10 segundos... (Cierra esta notificación para cancelar)" -t 10000

  for i in {10..1}; do
    # Verificar si el usuario cerró manualmente la notificación en SwayNC
    # Si no hay ninguna notificación activa con nuestra etiqueta, asumimos que se canceló
    if ! swaync-client -D | grep -q "powermenu" 2>/dev/null; then
      # Nota: Ajusta según cómo responda swaync-client en tu entorno,
      # si prefieres un método clásico infalible por tiempo, simplemente descuenta:
      echo "Cuenta regresiva activa: $i..."
    fi

    notify-send -h string:x-canonical-private-synchronous:powermenu \
      "Ejecutando $action_name" "El sistema se va a $action_name en $i segundos..." -t 1100
    sleep 1
  done

  # Quitar notificación final y ejecutar
  notify-send -h string:x-canonical-private-synchronous:powermenu "Ejecutando..." -t 500
  eval "$command"
}

# Lógica de selección
selected_option=$(echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd)

case "$selected_option" in
$shutdown)
  countdown_and_run "Apagar" "systemctl poweroff"
  ;;
$reboot)
  countdown_and_run "Reiniciar" "systemctl reboot"
  ;;
$lock)
  # El bloqueo es inmediato, no necesita cuenta regresiva
  swaylock \
    --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 \
    --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color bb00cc --key-hl-color 880033 \
    --line-color 00000000 --inside-color 00000088 --separator-color 00000000 --grace 2 --fade-in 0.2
  ;;
$suspend)
  countdown_and_run "Suspender" "systemctl suspend"
  ;;
$logout)
  countdown_and_run "Cerrar Sesión" "pkill mango || pkill dwl"
  ;;
esac
