# editor set
set -gx EDITOR nvim
set fish_key_bindings fish_vi_key_bindings
if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/mateusz/.ghcup/bin $PATH # ghcup-env

zoxide init fish --cmd cd | source
