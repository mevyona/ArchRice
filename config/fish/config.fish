if status is-interactive
    set fish_greeting

end

alias reload='source ~/.config/fish/config.fish'
alias conf='nano ~/.config/fish/config.fish'

alias pm='sudo pacman'
alias pms='sudo pacman -S'
alias pmr='sudo pacman -Rns'
alias update='sudo pacman -Syu'
alias clean='sudo pacman -Rns $(pacman -Qdtq)'

alias lsl='ls -lF'
alias lsa='ls -aF'

alias sn='shutdown now'

alias c='clear'
alias ff='fastfetch'

set -l main_color E2C0FC
set -l accent_color B4BEFE
set -l secondary_accent CBA6F7
set -l error_color F38BA8
set -l success_color A6E3A1
set -l info_color 89DCEB
set -l warn_color FAB387

set -U fish_color_normal normal
set -U fish_color_command $main_color
set -U fish_color_keyword $secondary_accent
set -U fish_color_quote $warn_color
set -U fish_color_redirection $info_color
set -U fish_color_end $success_color
set -U fish_color_error $error_color
set -U fish_color_param $accent_color
set -U fish_color_option $accent_color
set -U fish_color_comment $warn_color --italics
set -U fish_color_selection --background=$secondary_accent
set -U fish_color_search_match --background=$secondary_accent
set -U fish_color_operator $info_color
set -U fish_color_escape $info_color
set -U fish_color_autosuggestion 6c7086
set -U fish_color_cancel $error_color

set -U fish_pager_color_progress $info_color
set -U fish_pager_color_prefix $main_color --bold
set -U fish_pager_color_completion $accent_color
set -U fish_pager_color_description $warn_color
set -U fish_pager_color_selected_background --background=$secondary_accent

set -gx LS_COLORS "di=01;38;2;180;166;247:fi=38;2;205;214;244:ln=01;38;2;137;220;235:so=01;38;2;249;226;175:pi=01;38;2;249;226;175:ex=01;38;2;166;227;161:bd=01;38;2;245;194;231:cd=01;38;2;245;194;231:su=01;38;2;243;139;168:sg=01;38;2;243;139;168:tw=01;38;2;166;227;161:ow=01;38;2;166;227;161:*.md=38;2;137;220;235:*.txt=38;2;137;220;235:*.sh=01;38;2;166;227;161:*.py=01;38;2;166;227;161"

alias ls='ls -F --color=always'
alias dir='dir -F --color=always'
alias vdir='vdir -F --color=always'

set -gx GREP_COLORS "mt=01;38;2;226;192;252:fn=01;38;2;180;166;247:ln=01;38;2;137;220;235:bn=01;38;2;249;226;175:se=01;38;2;166;227;161"

set -Ux LESS_TERMCAP_md (printf "\e[01;38;2;226;192;252m")
set -Ux LESS_TERMCAP_me (printf "\e[0m")
set -Ux LESS_TERMCAP_so (printf "\e[01;38;2;137;220;235m")
set -Ux LESS_TERMCAP_se (printf "\e[0m")
set -Ux LESS_TERMCAP_us (printf "\e[01;38;2;180;166;247m")
set -Ux LESS_TERMCAP_ue (printf "\e[0m")