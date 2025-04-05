#!/bin/bash

if pamixer --default-source --get-mute | grep -q true; then
    pamixer --default-source --unmute
    notify-send "🎙️ Microphone activé"
else
    pamixer --default-source --mute
    notify-send "🔇 Microphone coupé"
fi