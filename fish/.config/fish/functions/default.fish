function fish_prompt --description 'Write out the prompt'
    set -l normal (set_color -o normal)
    set -q fish_color_status
    or set -g fish_color_status red

    set -l color_cwd $fish_color_cwd
    set -l suffix '>'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set -l suffix '#'
    end

    echo -n -s (prompt_login) " " (set_color $color_cwd) (prompt_pwd -full-length-dirs=3 --dir-length=1) $normal (fish_vcs_prompt) $normal " " $suffix " "
end
