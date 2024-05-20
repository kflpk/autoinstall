#!/bin/bash

TPM_DIR="$XDG_DATA_HOME/tmux-plugins/tpm"
mkdir -p $TPM_DIR

git clone "https://github.com/tmux-plugins/tpm" $TPM_DIR
$TPM_DIR/bin/install_plugins
