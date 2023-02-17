#!/bin/bash

# Check if the system has sudo or doas

if [ -e /bin/sudo ]; then
  export SUDO=sudo
else if [ -e /bin/doas ]; then
  export SUDO=doas
fi
fi

# Check what package manager the system has

if [ -e /bin/apt ]; then
  export INSTALL="$SUDO apt install -y"
else if [ -e /bin/pacman ]; then
  export INSTALL="$SUDO pacman -S --noconfirm"
else if [ -e /bin/dnf ]; then
  export INSTALL="$SUDO dnf -y install"
fi
fi
fi

mkdir -p ~/.config ~/.cache ~/.local/share/applications ~/.local/share/fonts ~/.local/bin

############## PACKAGE LISTS ################
PACKAGES="vim \
neovim \
build-essential \
binutils
gcc \
g++ \
gcc-avr \
avr-libc \
avrdude \
binutils-msp430 \
gcc-msp430 \
gdb-msp430 \
msp430-libc \
msp430mcu \
mspdebug \
clang \
python3 \
python3-pip \
python3-venv \
make \
cmake \
git \
zsh \
exa \
tmux \
htop \
wget \
curl \
rsync \
scp \
sshd \
stow \
firefox \
thunderbird \
gimp \
youtube-dl \
pcmanfm \
pandoc \
texlive \
latexmk \
texlive-latex-extra \
texlive-lang-polish \
texlive-fonts-extra \
texlive-bibtex-extra \
flatpak \
python3-tk"

GNOME_PACKAGES="ark \
gnome-tweaks"

CARGO_PACKAGES="bat \
tldr \
ncspot \
tokei \
exa"

SNAP_PACKAGES=("code --classic"
"scrcpy")

###### INSTALL ALL PACKAGES #########

for package in $PACKAGES
do
  $INSTALL $package
done

# PACKAGES FOR GNOME

if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
	echo "GNOME detected, installing additional packages"
	$INSTALL $GNOME_PACKAGES
fi

# CARGO AND PIP

./rustup.sh

cargo install $CARGO_PACKAGES

./alacritty.sh

pip3 install -r python-packages.txt

# INSTALL SNAPS AND SNAP PACKAGES

if [ -e /bin/apt ]; then
  ./snap-debian.sh
else if [ -e /bin/dnf ]; then
  ./snap-fedora.sh
else if [ -e /bin/pacman ]; then
  ./snap-arch.sh
fi
fi
fi

sleep 15

for i in $(seq 0 $(( ${#SNAP_PACKAGES[@]}-1)) )
do
  $SUDO snap install ${SNAP_PACKAGES[$i]}
done

####### GET RID OF OLD BASH DOTFILES ########
if [ -e ~/.bashrc ]; then
  mv ~/.bashrc ~/.bashrc.old
fi

if [ -e ~/.bash_profile ]; then
  mv ~/.bash_profile ~/.bash_profile.old
fi

git clone --recursive "https://github.com/Yoshua-chan/dotfiles" ~/.dotfiles

(cd ~/.dotfiles; stow */)

############### dev stuff ###################

./git-config.sh
./vscode.sh

##### INSATLL VIM-PLUG #######

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

$SUDO chsh $USER -s /bin/zsh
