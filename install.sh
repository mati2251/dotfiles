#!/bin/sh
git clone https://github.com/mati2251/dotfiles
cd dotfiles
set -x
make "$@"

