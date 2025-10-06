#!/usr/bin/env bash

set -oue pipefail

set -eux

# Install Material Symbols font
mkdir -p /usr/local/share/fonts
curl -L "https://github.com/google/material-design-icons/raw/master/variablefont/MaterialSymbolsRounded%5BFILL%2CGRAD%2Copsz%2Cwght%5D.ttf" -o /usr/local/share/fonts/MaterialSymbolsRounded.ttf

sudo curl -L "https://github.com/tonsky/FiraCode/releases/latest/download/FiraCode-Regular.ttf" -o /usr/share/fonts/FiraCode-Regular.ttf

sudo curl -L "https://github.com/rsms/inter/raw/refs/tags/v4.1/docs/font-files/InterVariable.ttf" -o /usr/share/fonts/InterVariable.ttf

# Install dgop
sudo sh -c "curl -L https://github.com/AvengeMedia/dgop/releases/latest/download/dgop-linux-$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/').gz | gunzip | tee /usr/local/bin/dgop > /dev/null && chmod +x /usr/local/bin/dgop"

fc-cache -fv

mkdir ~/.config/quickshell && git clone https://github.com/AvengeMedia/DankMaterialShell.git ~/.config/quickshell/dms

sudo sh -c "curl -L https://github.com/AvengeMedia/danklinux/releases/latest/download/dms-$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/').gz | gunzip | tee /usr/local/bin/dms > /dev/null && chmod +x /usr/local/bin/dms"
