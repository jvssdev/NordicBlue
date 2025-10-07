#!/usr/bin/env bash
set -oue pipefail

# Install dgop
mkdir -p /usr/local/bin
ARCH=$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/')
curl -L "https://github.com/AvengeMedia/dgop/releases/latest/download/dgop-linux-${ARCH}.gz" | gunzip > /usr/local/bin/dgop
chmod +x /usr/local/bin/dgop

# Install dms
curl -L "https://github.com/AvengeMedia/danklinux/releases/latest/download/dms-${ARCH}.gz" | gunzip > /usr/local/bin/dms
chmod +x /usr/local/bin/dms


# Clone DankMaterialShell config
mkdir -p /etc/skel/.config/quickshell
git clone https://github.com/AvengeMedia/DankMaterialShell.git /etc/skel/.config/quickshell/dms
