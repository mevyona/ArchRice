#!/bin/bash

rclone --vfs-cache-mode writes mount OneDrive: ~/OneDrive &

while [ ! -d "$HOME/OneDrive" ]; do
    sleep 5
done

python ~/OneDrive/BOT/Mevyona/src/bot.pyw
