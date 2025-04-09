#!/bin/sh
git clone https://github.com/mati2251/dotfiles
cd dotfiles
if [ "$1" = "minimal" ]; then
    echo "Installing minimal configuration..."
    make minimal
else
    echo "Installing full configuration..."
    make all
fi

