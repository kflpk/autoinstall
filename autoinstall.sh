#!/bin/bash

# Check if the system has sudo or doas
if [ -e /bin/sudo ]; then
  SUDO=sudo
else if [ -e /bin/doas ]; then
  SUDO=doas
fi
fi

# Check what package manager the system has
if [ -e /bin/apt ]; then
  INSTALL="$SUDO apt install -y"
else if [ -e /bin/pacman ]; then
  INSTALL="$SUDO pacman -S --noconfirm"
else if [ -e /bin/dnf ]; then
  INSTALL="$SUDO dnf -y install"
fi
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
exa \
rsync \
scp \
sshd"

CARGO_PACKAGES="bat \
tldr \
ncspot \
tokei \
exa"

###### INSTALL ALL PACKAGES #########
for package in $PACKAGES
do
  $INSTALL $package
done

cargo install $CARGO_PACKAGES






####### GET RID OF OLD BASH DOTFILES ########
if [ -e ~/.bashrc ]; then
  mv ~/.bashrc ~/.bashrc.old
fi

if [ -e ~/.bash_profile ]; then
  mv ~/.bash_profile ~/.bash_profile.old
fi

git clone --recursive "git@github.com:Yoshua-chan/dotfiles.git" ~/.dotfiles

(cd ~/.dotfiles; stow */)







##### DOWNLOAD AND INSTALL FONTS #####
FONTS=$(mktemp -d)

mkdir $FONTS/fonts

wget "https://github.com/JetBrains/JetBrainsMono/releases/download/v2.242/JetBrainsMono-2.242.zip" -O "$FONTS/JetBrainsMono.zip"
wget "https://github.com/tonsky/FiraCode/releases/download/5.2/Fira_Code_v5.2.zip" -O "$FONTS/FiraCode.zip"
wget "https://github.com/microsoft/cascadia-code/releases/download/v2108.26/CascadiaCode-2108.26.zip" -O "$FONTS/CascadiaCode.zip"

for file in $FONTS/*.zip
do
  unzip $file -d "$FONTS/fonts/$(basename $file .zip)"
done

rm -r $FONTS/*.zip

for dir in $FONTS/fonts/*
do
  $SUDO cp -r $dir /usr/share/fonts/truetype/
done

$SUDO fc-cache -fv
