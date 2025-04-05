#!/bin/bash

if pamixer --get-mute | grep -q true; then
    pamixer --unmute
    notify-send "🔊 Audio activé"
else
    pamixer --mute
    notify-send "🔇 Audio coupé"
fi