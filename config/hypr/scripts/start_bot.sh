#!/usr/bin/env fish

while not test -d "$HOME/OneDrive"
    sleep 5
end

python $HOME/OneDrive/BOT/Mevyona/src/bot.pyw