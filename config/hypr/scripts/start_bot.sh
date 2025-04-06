#!/bin/bash

./onedrive.sh

while [ ! -d "$HOME/OneDrive" ]; do
    sleep 5
done

python ~/OneDrive/BOT/Mevyona/src/bot.pyw
