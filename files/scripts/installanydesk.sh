#!/usr/bin/env bash
set -euo pipefail

echo "Adding AnyDesk repository..."
cat > /etc/yum.repos.d/AnyDesk-Fedora.repo << "EOF" 
[anydesk]
name=AnyDesk Fedora - stable
baseurl=http://rpm.anydesk.com/fedora/$basearch/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://keys.anydesk.com/repos/RPM-GPG-KEY
EOF

echo "Installing AnyDesk..."
dnf install -y anydesk

echo "AnyDesk installation completed."
