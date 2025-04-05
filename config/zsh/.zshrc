# main zsh settings. env in ~/.zprofile
# read second


# source global shell alias & variables files
[ -f "$XDG_CONFIG_HOME/shell/alias" ] && source "$XDG_CONFIG_HOME/shell/alias"
[ -f "$XDG_CONFIG_HOME/shell/vars" ] && source "$XDG_CONFIG_HOME/shell/vars"

# load modules
zmodload zsh/complist
autoload -U compinit && compinit
autoload -U colors && colors
# autoload -U tetris # main attraction of zsh, obviously


# cmp opts
zstyle ':completion:*' menu select # tab opens cmp menu
zstyle ':completion:*' special-dirs true # force . and .. to show in cmp menu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33 # colorize cmp menu
# zstyle ':completion:*' file-list true # more detailed list
zstyle ':completion:*' squeeze-slashes false # explicit disable to allow /*/ expansion

# main opts
setopt append_history inc_append_history share_history # better history
# on exit, history appends rather than overwrites; history is appended as soon as cmds executed; history shared across sessions
setopt auto_menu menu_complete # autocmp first menu match
setopt autocd # type a dir to cd
setopt auto_param_slash # when a dir is completed, add a / instead of a trailing space
setopt no_case_glob no_case_match # make cmp case insensitive
setopt globdots # include dotfiles
setopt extended_glob # match ~ # ^
setopt interactive_comments # allow comments in shell
unsetopt prompt_sp # don't autoclean blanklines
stty stop undef # disable accidental ctrl s

HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="$XDG_CACHE_HOME/zsh_history"
HISTCONTROL=ignoreboth

NEWLINE=$'\n'
PROMPT="${NEWLINE}%K{#2E3440}%F{#E5E9F0}$(date +%_I:%M%P) %K{#3b4252}%F{#ECEFF4} %n %K{#4c566a} %~ %f%k ❯ "
echo -e "${NEWLINE}\033[48;2;46;52;64;38;2;216;222;233m $0 \033[0m\033[48;2;59;66;82;38;2;216;222;233m $(uptime -p | cut -c 4-) \033[0m\033[48;2;76;86;106;38;2;216;222;233m $(uname -r) \033[0m"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias a='alias | grep -v "alias "'
alias nf='neofetch'
alias ff='fastfetch'
alias c='clear'
alias ls='ls -l --color=auto'
alias lsa='ls -a --color=auto'
alias root='cd /'
alias ..='cd ..'
alias update='sudo pacman -Syu'
alias wash='sudo pacman -Rns $(pacman -Qdtq)'
alias clean='sudo pacman -Rns $(pacman -Qdtq)'
alias sn='shutdown now'
alias r='sudo reboot'
alias pm='sudo pacman -S'
alias pmr='sudo pacman -Rns'
alias yayr='yay -Rns'
alias nano='sudo nano'
alias conf='nvim ~/.zshrc'
alias reload='source ~/.zshrc'
alias hyprconf='nvim ~/.config/hypr/hyprland.conf'
alias keyconf='nvim ~/.config/hypr/keybindings.conf'
alias rm='sudo rm -R'

mkd() {
  mkdir -p "$1" && cd "$1"
}

precmd() {
  echo -ne "\033]0;${USER}@${HOST}: ${PWD}\007"
}