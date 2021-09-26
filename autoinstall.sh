#!/bin/bash

if [ -e /bin/apt ]; then
  INSTALL="sudo apt install"
else if [ -e /bin/pacman ]; then
  INSTALL="sudo pacman -S"
fi
fi
