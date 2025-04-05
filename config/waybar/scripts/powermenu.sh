#!/usr/bin/env bash

# Script pour afficher un menu de gestion d'alimentation
# Ce script fonctionne avec rofi ou wofi (pour Wayland)

# Détecter quel menu est disponible
if command -v rofi &> /dev/null; then
    LAUNCHER="rofi -dmenu -i -p 'Système' -theme-str 'window {width: 20%; border-radius: 4px;}'"
elif command -v wofi &> /dev/null; then
    LAUNCHER="wofi --show dmenu -p 'Système'"
else
    echo "Ni rofi ni wofi n'est installé."
    exit 1
fi

# Options
OPTIONS="Verrouiller écran\nDéconnexion\nRedémarrer\nÉteindre\nAnnuler"

# Afficher le menu
CHOICE=$(echo -e $OPTIONS | eval $LAUNCHER)

# Gérer la sélection
case "$CHOICE" in
    "Verrouiller écran")
        if command -v swaylock &> /dev/null; then
            swaylock -c 000000
        elif command -v hyprlock &> /dev/null; then
            hyprlock
        else
            notify-send "Erreur" "Aucun utilitaire de verrouillage trouvé"
        fi
        ;;
    "Déconnexion")
        if pgrep -x "Hyprland" > /dev/null; then
            hyprctl dispatch exit
        elif pgrep -x "sway" > /dev/null; then
            swaymsg exit
        else
            loginctl terminate-user $USER
        fi
        ;;
    "Redémarrer")
        systemctl reboot
        ;;
    "Éteindre")
        systemctl poweroff
        ;;
    *)
        exit 0
        ;;
esac