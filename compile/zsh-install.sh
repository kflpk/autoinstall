#!/bin/bash

tmpd=$(mktemp -d)

git clone https://git.code.sf.net/p/zsh/code $tmpd/zsh-code

cd $tmpd/zsh-code

git checkout "zsh-5.8"

./Util/preconfig
./configure

make
sudo make install

sudo bash -c 'echo "usr/local/bin/zsh" >> /etc/shells'
sudo chsh $USER -s /usr/local/bin/zsh
