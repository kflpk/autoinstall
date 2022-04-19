#!/bin/bash

ssh-keygen -t ssh -b 4096

git config --global alias.adog "log --all --decorate --oneline --graph"
git config --global alias.ll   "log --oneline"
git config --global alias.s    "status"
git config --global alias.aa   "stage -A"
git config --global alias.d    "diff"

git config --global alias.co   "checkout"
git config --global alias.cob  "checkout -b"
git config --global alias.br   "branch"
git config --global alias.cm   "commit -m"

