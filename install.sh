#!bin/bash
sudo pacman -S --noconfirm --needed \
    git \
    neovim \
    fish \
    alacritty \
    tmux \
    chezmoi

chezmoi init https://github.com/$GITHUB_USERNAME/dotfiles.git
