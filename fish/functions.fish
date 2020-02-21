
function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set -l normal (set_color normal)
    set -l yellow (set_color yellow)
    set -l suffix (set_color purple) '$ ' $normal
    set -l prompt_status
    set -l git_status
    set -l git_info

    if test $last_status -ne 0
        set prompt_status (set_color red) "$last_status "
    end

    if set -l git_branch (command git symbolic-ref HEAD 2>/dev/null | string replace refs/heads/ '')
        if set -l count (command git rev-list --count --left-right origin...HEAD 2>/dev/null)
            echo $count | read -l behind ahead
            if test "$ahead" -gt 0
                set git_status "$git_status"(set_color red)^
            end
            if test "$behind" -gt 0
                set git_status "$git_status"(set_color red)v
            end
        end

        for i in (git status --porcelain | string sub -l 2 | uniq)
            if set -l char (string match -r '^[ADMR]' $i)
                set git_status "$git_status"(set_color green)$char
            end
            if set -l char (string match -r '[ADMR]$' $i)
                set git_status "$git_status"(set_color red)$char
            end
            if set -l char (string match -r '[CU]' $i)
                set git_status "$git_status"(set_color yellow)$char
            end
            if test $i = '??'
                set git_status "$git_status"(set_color red)'?'
            end
        end

        if test "$git_status" != ''
            set git_status ' '(echo $git_status | uniq | string join '')
        end
        set git_info "$yellow<$git_branch$git_status$yellow> "
    end

    echo -n -s (set_color green) "$USER" $normal @ (set_color cyan) (prompt_hostname) $normal ' ' (set_color $fish_color_cwd) (prompt_pwd) ' ' $prompt_status $git_info $suffix
end
