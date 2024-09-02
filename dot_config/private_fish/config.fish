# editor set
set -gx EDITOR nvim
set fish_key_bindings fish_vi_key_bindings
if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/mateusz/.ghcup/bin $PATH # ghcup-env

bind yy fish_clipboard_copy
bind pp fish_clipboard_paste
set -g hydro_symbol_prompt "\$"
set -g hydro_color_pwd $fish_color_cwd
