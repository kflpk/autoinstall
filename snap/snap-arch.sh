#!/bin/bash

git clone https://aur.archlinux.org/snapd.git /tmp/snapd
cd /tmp/snapd
makepkg -si

$SUDO systemctl enable --now snapd.socket
$SUDO ln -s /var/lib/snapd/snap /snap

