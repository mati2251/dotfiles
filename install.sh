#!bin/bash
sudo pacman -S --noconfirm --needed \
  git \
  neovim \
  fish \
  alacritty \
  tmux \
  chezmoi \
  zoxide 
chezmoi init https://github.com/$GITHUB_USERNAME/dotfiles.git
# gnome config
# dracula gtk
wget 'https://github.com/dracula/gtk/archive/master.zip'
unzip master.zip
cp -r gtk-master/ ~/.themes/Dracula
rm -rf gtk-master master.zip
gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
gsettings set org.gnome.shell.extensions.user-theme name "Dracula"
cp -r ~/.themes/Dracula/gtk-3.0/ ~/.config/gtk-3.0/
cp -r ~/.themes/Dracula/gtk-2.0/ ~/.config/gtk-2.0/
cp -r ~/.themes/Dracula/gtk-4.0/ ~/.config/gtk-4.0/

# dracula icons
wget 'https://github.com/matheuuus/dracula-icons/archive/refs/heads/main.zip'
unzip main.zip
cp -r dracula-icons-main/ ~/.icons/
rm -rf dracula-icons-main/ main.zip
gsettings set org.gnome.desktop.interface icon-theme "dracula-icons-main"

# wallpaper 
gsettings set org.gnome.desktop.background picture-uri 'file:///home/$(whoami)/.local/share/backgrounds/sheep.jpg'
gsettings set org.gnome.desktop.background picture-options 'zoom'

# tochpad
gsettings set org.gnome.desktop.peripherals.touchpad click-method 'fingers'

# workspaces
gsettings set org.gnome.shell.app-switcher current-workspace-only true
