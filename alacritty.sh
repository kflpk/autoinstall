#!/bin/bash


# Install dependencies before installation

if [ -e /bin/apt ]; then
	$SUDO apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
else if [ -e /bin/pacman ]; then
	$SUDO pacman -S cmake freetype2 fontconfig pkg-config make libxcb libxkbcommon python
else if [ -e /bin/dnf ]; then
	$SUDO dnf install cmake freetype-devel fontconfig-devel libxcb-devel libxkbcommon-devel g++
fi
fi
fi

# Installation

BUILDDIR=$(mktemp -d)
cd $BUILDDIR
git clone https://github.com/alacritty/alacritty.git
cd alacritty

rustup override set stable
rustup update stable
cargo build --release

# Desktop entries
$SUDO cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
$SUDO cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
$SUDO desktop-file-install extra/linux/Alacritty.desktop
$SUDO update-desktop-database

# Manpages
$SUDO mkdir -p /usr/local/share/man/man1
gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
gzip -c extra/alacritty-msg.man | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null

# Autocompletion
mkdir -p ${ZDOTDIR:-~}/.zsh_functions
echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >> ${ZDOTDIR:-~}/.zshrc
cp extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty
