#!/bin/bash

if [ -e /bin/apt ]; then
  INSTALL="sudo apt install -y"
else if [ -e /bin/pacman ]; then
  INSTALL="sudo pacman -S"
fi
fi


mkdir -p ~/.config ~/.cache ~/.local/share ~/.local/bin

PACKAGES="vim \
neovim \
zsh \
git \
dunst \
bspwm \
sxhkd \
tmux \
htop \
stow \
cargo \
gcc \
g++ \
clang \
make \
cmake \
build-essentials \
firefox \
wget \
curl \
exa"

###### INSTALL ALL PACKAGES #########
for package in $PACKAGES
do
  $INSTALL $package
done

CARGO_PACKAGES="bat \
tldr \
ncspot \
tokei \
exa"

cargo install $CARGO_PACKAGES

####### GET RID OF OLD BASH DOTFILES ########
if [ -e ~/.bashrc ]; then
  mv ~/.bashrc ~/.bashrc.old
fi

if [ -e ~/.bash_profile ]; then
  mv ~/.bash_profile ~/.bash_profile.old
fi

git clone --recursive "git@github.com:Yoshua-chan/dotfiles.git" ~/.dotfiles

##### DOWNLOAD AND INSTALL FONTS #####
FONTS=$(mktemp -d)
wget "https://github.com/JetBrains/JetBrainsMono/releases/download/v2.242/JetBrainsMono-2.242.zip" -O "$FONTS/JetBrainsMono.zip"
wget "https://github.com/tonsky/FiraCode/releases/download/5.2/Fira_Code_v5.2.zip" -O "$FONTS/FiraCode.zip"