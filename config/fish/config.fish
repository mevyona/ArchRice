function fish_prompt
    set_color green
    echo -n (whoami) "@" (hostname) " " (pwd) " > "
    set_color normal
end

if status is-interactive
    set fish_greeting

end

starship init fish | source
if test -f ~/.cache/ags/user/generated/terminal/sequences.txt
    cat ~/.cache/ags/user/generated/terminal/sequences.txt
end

alias reload='source ~/.config/fish/config.fish'
alias conf='nano ~/.config/fish/config.fish'

alias pm='sudo pacman'
alias pms='sudo pacman -S'
alias pmr='sudo pacman -Rns'
alias update='sudo pacman -Syu'
alias clean='sudo pacman -Rns $(pacman -Qdtq)'

alias rm='sudo rm -R'

alias lsl='ls -l'
alias lsa='ls -a'

alias sn='shutdown now'
alias r='reboot'

alias c='clear'
alias ff='fastfetch'
