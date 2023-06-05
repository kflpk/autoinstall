#!/bin/bash

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