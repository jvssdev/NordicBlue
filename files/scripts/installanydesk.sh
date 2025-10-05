#!/usr/bin/env bash
set -oue pipefail

cat > /etc/yum.repos.d/AnyDesk-Fedora.repo << EOF
[anydesk]
name=AnyDesk Fedora - stable
baseurl=http://rpm.anydesk.com/fedora/\$basearch/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://keys.anydesk.com/repos/RPM-GPG-KEY
enabled=1
priority=90
EOF

rpm-ostree install anydesk
