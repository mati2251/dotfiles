all: gnome fish tmux alacritty neovim

minimal: fish tmux neovim

/usr/bin/stow:
	pacman -S --noconfirm stow

/usr/bin/git:
	pacman -S --noconfirm git

/usr/bin/nvim:
	pacman -S --noconfirm neovim

/usr/bin/tmux:
	pacman -S --noconfirm tmux

/usr/bin/alacritty:
	pacman -S --noconfirm alacritty

/usr/bin/fish:
	pacman -S --noconfirm fish

~/.themes/Dracula:
	wget 'https://github.com/dracula/gtk/archive/master.zip'
	unzip master.zip
	mkdir -p ~/.themes/Dracula
	cp -r gtk-master/ ~/.themes/Dracula
	rm -rf gtk-master master.zip
	cp -r ~/.themes/Dracula/gtk-master/gtk-3.0/ ~/.config/gtk-3.0/
	cp -r ~/.themes/Dracula/gtk-master/gtk-2.0/ ~/.config/gtk-2.0/
	cp -r ~/.themes/Dracula/gtk-master/gtk-4.0/ ~/.config/gtk-4.0/

~/.icons/dracula-icons-main:
	wget 'https://github.com/matheuuus/dracula-icons/archive/refs/heads/main.zip'
	unzip main.zip
	cp -r dracula-icons-main/ ~/.icons/
	rm -rf dracula-icons-main/ main.zip

.PHONY: gnome
gnome: ~/.themes/Dracula ~/.icons/dracula-icons-main
	stow gnome
	gsettings set org.gnome.desktop.background picture-uri 'file:///home/$(whoami)/.local/share/backgrounds/sheep.jpg'
	gsettings set org.gnome.desktop.background picture-options 'zoom'
	gsettings set org.gnome.desktop.peripherals.touchpad click-method 'fingers'
	gsettings set org.gnome.shell.app-switcher current-workspace-only true
	gsettings set org.gnome.desktop.interface icon-theme "dracula-icons-main"
	gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
	gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
	gsettings set org.gnome.shell.extensions.user-theme name "Dracula"
	@echo "Gnome configuration applied."

.PHONY: fish
fish: /usr/bin/fish
	stow fish
	chsh -s /usr/bin/fish
	@echo "Fish shell configuration applied."

.PHONY: tmux
tmux: /usr/bin/tmux
	stow tmux
	@echo "Tmux configuration applied."

.PHONY: alacritty
alacritty: /usr/bin/alacritty
	stow alacritty
	@echo "Alacritty configuration applied."

NEOVIM_ARGS :=

.PHONY: neovim
neovim: /usr/bin/nvim
	stow nvim $(NEOVIM_ARGS)
	@echo "Neovim configuration applied."

.PHONY: neovim-minimal
neovim-minimal: NEOVIM_ARGS := --ignore=.+dap.lua --ignore=.+lsp.lua --ignore=.+copilot.lua --ignore=.+telescope.lua
neovim-minimal: neovim
