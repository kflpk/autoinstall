#!/bin/bash

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
  cp -r $dir $HOME/.local/share/fonts
done

fc-cache -fv

