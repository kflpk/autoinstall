#!/bin/bash

if [ -e /bin/apt ]; then
  INSTALL="sudo apt install"
else if [ -e /bin/pacman ]; then
  INSTALL="sudo pacman -S"
fi
fi

PACKAGES="vim \
neovim \
zsh \
git \
dunst \
bspwm \
sxhkd \
tmux \
htop \
stow"


git clone ""