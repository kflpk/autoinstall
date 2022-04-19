#!/bin/bash
mkdir -p ~/.config/Code
cd ~/.config/Code
git clone "https://github.com/Yoshua-chan/vscode-settings" User
cd ./User
git remote set-url origin "git@github.com:Yoshua-chan/vscode-settings.git"


for extension in $(cat vscode-extensions.txt)
do
    code --install-extension "$extension"
done