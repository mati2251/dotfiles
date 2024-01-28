#!bin/bash
sudo pacman -S --noconfirm --needed \
    git \
    neovim \
    fish \
    alacritty \
    tmux \
    chezmoi

git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

chezmoi init https://github.com/$GITHUB_USERNAME/dotfiles.git
