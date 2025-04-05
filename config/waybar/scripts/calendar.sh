#!/usr/bin/env bash

# Script pour afficher un calendrier via Yad ou tout autre outil GUI

TODAY=$(date +%d)
MONTH=$(date +%m)
YEAR=$(date +%Y)

# Déterminer quel outil est disponible
if command -v yad &> /dev/null; then
    yad --calendar --day=$TODAY --month=$MONTH --year=$YEAR \
        --title="Calendrier" --width=300 --height=300 \
        --button="Fermer:0" --center --borders=10 \
        --window-icon=calendar
elif command -v zenity &> /dev/null; then
    zenity --calendar --day=$TODAY --month=$MONTH --year=$YEAR \
           --title="Calendrier" --text="Date actuelle:"
elif command -v rofi &> /dev/null; then
    # Générer un calendrier de base avec cal et l'afficher via rofi
    CALENDAR=$(cal -m | sed "s/\b${TODAY}\b/<b><span background='#9D78BB' foreground='#15081A'>${TODAY}<\/span><\/b>/")
    echo -e "$CALENDAR" | rofi -dmenu -markup-rows -no-fixed-num-lines -p "Calendrier" -theme-str 'window {width: 20%; height: 30%;}' -theme-str 'listview {lines: 8;}' > /dev/null
else
    # Dernier recours: utiliser notify-send
    notify-send "Calendrier" "$(cal -m)" -t 10000
fi