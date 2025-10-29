#!/usr/bin/env bash
set -oue pipefail

echo "Adding negativo17 multimedia repository..."

if [ ! -f /etc/yum.repos.d/negativo17-fedora-multimedia.repo ]; then
    curl -Lo /etc/yum.repos.d/negativo17-fedora-multimedia.repo \
        https://negativo17.org/repos/fedora-multimedia.repo
    
        sed -i '0,/enabled=1/{s/enabled=1/enabled=1\npriority=90/}' \
        /etc/yum.repos.d/negativo17-fedora-multimedia.repo
    
    echo "Repository added successfully."
else
    echo "Repository already exists, skipping."
fi
