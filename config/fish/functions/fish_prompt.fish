function fish_prompt
    set -l last_status $status
    set -l cmd_duration $CMD_DURATION
    
    set -l bg_main 1E1E2E
    set -l bg_lighter 313244
    set -l main_color E2C0FC
    set -l accent_color B4BEFE
    set -l secondary_accent CBA6F7
    set -l error_color F38BA8
    set -l success_color A6E3A1
    set -l info_color 89DCEB
    set -l warn_color FAB387
    set -l path_color E2C0FC
    set -l user_host_color CBA6F7
    
    set -l separator ""
    set -l git_symbol "󰊢"
    set -l python_symbol ""
    set -l node_symbol ""
    set -l time_symbol "󰥔"
    set -l folder_symbol "󰝰"
    set -l error_symbol ""
    set -l root_symbol "󰯄"
    set -l user_symbol "󰣇"
    set -l machine_symbol "󰌢"
    set -l prompt_char "→"
    set -l right_separator ""
    set -l arch_symbol "󰣇"
    set -l round_left ""
    set -l round_right ""
    
    function __segment
        set -l bg $argv[1]
        set -l fg $argv[2]
        set -l content $argv[3]
        set -l next_bg $argv[4]
        
        set_color -b $bg $fg
        echo -n "$content"
        
        if test -n "$next_bg"
            set_color -b $next_bg $bg
            echo -n "$separator"
        else
            set_color normal
            set_color $bg
            echo -n "$separator"
        end
        set_color normal
    end
    
    function __rounded_segment
        set -l bg $argv[1]
        set -l fg $argv[2]
        set -l content $argv[3]
        set -l next_bg $argv[4]
        
        set_color $bg
        echo -n "$round_left"
        set_color -b $bg $fg
        echo -n "$content"
        set_color $bg
        echo -n "$round_right"
        
        if test -n "$next_bg"
            set_color -b $next_bg $bg
            echo -n "$separator"
        else
            set_color normal
        end
        set_color normal
    end
    
    function __right_segment
        set -l bg $argv[1]
        set -l fg $argv[2]
        set -l content $argv[3]
        
        set_color -b $bg $fg
        echo -n "$content"
        set_color normal
        set_color $bg
        echo -n "$right_separator"
        set_color normal
    end
    
    echo
    
    __segment $main_color $bg_main " $arch_symbol " $bg_lighter
    
    __segment $user_host_color $bg_main " "(whoami)" " $bg_lighter
    
    __rounded_segment $path_color $bg_main " $folder_symbol "(prompt_pwd)" " $info_color
    
    if command -sq git; and git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set -l git_branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
        set -l git_status (git status --porcelain 2>/dev/null)
        set -l git_color $success_color
        set -l git_state ""
        
        if test -n "$git_status"
            set git_color $warn_color
            set -l changes (count $git_status)
            set git_state " $changes"
        end
        
        set -l ahead_behind (git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null)
        if test $status -eq 0
            echo $ahead_behind | read behind ahead
            test $behind -gt 0; and set git_state "$git_state "
            test $ahead -gt 0; and set git_state "$git_state "
        end
        
        __segment $git_color $bg_main " $git_symbol $git_branch $git_state " $secondary_accent
    end
    
    if set -q VIRTUAL_ENV
        __segment $secondary_accent $bg_main " $python_symbol "(basename $VIRTUAL_ENV)" "
    end
    
    set -l right_prompt ""
    
    if test $cmd_duration -gt 2000
        set -l duration (math $cmd_duration / 1000)
        set right_prompt "$right_prompt$(__right_segment $info_color $bg_main " $time_symbol $duration s ")"
    end
    
    if set -q VIRTUAL_ENV
        set -l venv_name (basename $VIRTUAL_ENV)
        __segment $accent_color $bg_main "$python_symbol $venv_name" $warn_color
    end
    
    if test -e package.json
        set -l node_version (node -v | string replace -r '^v' '')
        __segment $warn_color $bg_main "$node_symbol $node_version"
    end
    
    set -l right_prompt ""
    
    if test $cmd_duration -gt 2000
        set -l duration (math $cmd_duration / 1000)
        set right_prompt "$right_prompt$(__right_segment $info_color $bg_main " $time_symbol $duration s ")"
    end
    
    set -l jobs_count (jobs -p | wc -l)
    if test $jobs_count -gt 0
        set right_prompt "$right_prompt$(__right_segment $info_color $bg_main "󱜯 $jobs_count")"
    end
    
    if test $last_status -ne 0
        set right_prompt "$right_prompt$(__right_segment $error_color $bg_main "$error_symbol $last_status ")"
    end
    
    set right_prompt "$right_prompt$(__right_segment $main_color $bg_main)"
    
    set -l term_width (tput cols)
    set -l prompt_width (string length (string replace -a '\e[[\d;]*m' '' "$right_prompt"))
    set -l padding_width (math "$term_width - $prompt_width")
    
    printf "%*s%s\n" $padding_width "" "$right_prompt"
    
    if test (id -u) -eq 0
        set_color $error_color
        echo -n "$prompt_char "
    else
        if test $last_status -eq 0
            set_color $main_color
            echo -n "$prompt_char "
        else
            set_color $error_color
            echo -n "$prompt_char "
        end
    end
    
    set_color normal
end
