#!/bin/bash

# Installing dependencies
if [ -e /bin/apt ]; then
	sudo apt install -y build-essential cmake g++
	sudo apt install -y qtbase5-dev qtbase5-private-dev qttools5-dev qttools5-dev-tools \
    libqt5svg5-dev libargon2-dev libminizip-dev libbotan-2-dev libqrencode-dev \
    zlib1g-dev asciidoctor libreadline-dev libpcsclite-dev libusb-1.0-0-dev \
    libxi-dev libxtst-dev  libqt5x11extras5-dev
else if [ -e /bin/pacman ]; then
	sudo pacman -S cmake make gcc
	sudo pacman -S qt5-base qt5-tools argon2 botan qrencode zlib asciidoctor readline \
    pcsclite libusb libxi libxtst qt5-x11extras minizip
else if [ -e /bin/dnf ]; then
	sudo dnf install make automake gcc-c++ cmake 
	sudo dnf install qt5-qtbase-devel qt5-qtbase-private-devel qt5-linguist qt5-qttools \
    qt5-qtsvg-devel libargon2-devel qrencode-devel botan2-devel readline-devel \
    zlib-devel rubygem-asciidoctor pcsc-lite-devel libusb1-devel libXi-devel \
    libXtst-devel qt5-qtx11extras-devel minizip-compat-devel
fi
fi
fi

tmpd=$(mktemp -d)

git clone https://github.com/keepassxreboot/keepassxc.git $tmpd/keepassxc

cd $tmpd/keepassxc

git checkout latest

mkdir build
cd build

cmake -DWITH_XC_ALL=ON ..
make

sudo make install
