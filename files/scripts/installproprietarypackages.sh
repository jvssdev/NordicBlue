#!/usr/bin/env bash
set -oue pipefail

echo "Adding negativo17 multimedia repository..."
curl -Lo /etc/yum.repos.d/negativo17-fedora-multimedia.repo https://negativo17.org/repos/fedora-multimedia.repo
sed -i '0,/enabled=1/{s/enabled=1/enabled=1\npriority=90/}' /etc/yum.repos.d/negativo17-fedora-multimedia.repo

PACKAGES=(
    "libheif"
    "libva"
    "libva-intel-media-driver"
    "mesa-dri-drivers"
    "mesa-filesystem"
    "mesa-libEGL"
    "mesa-libGL"
    "mesa-libgbm"
    "mesa-va-drivers"
    "mesa-vulkan-drivers"
    "gstreamer1-plugin-libav"
    "rar"
)

AVAILABLE_PACKAGES=()
echo "Checking available packages in fedora-multimedia repository..."
for pkg in "${PACKAGES[@]}"; do
    if dnf list --repo=fedora-multimedia "$pkg" &>/dev/null; then
        AVAILABLE_PACKAGES+=("$pkg")
        echo "  ✓ $pkg is available"
    else
        echo "  ✗ $pkg is not available (skipping)"
    fi
done

if [ ${#AVAILABLE_PACKAGES[@]} -gt 0 ]; then
    echo "Overriding ${#AVAILABLE_PACKAGES[@]} packages with multimedia-optimized versions..."
    rpm-ostree override replace \
      --experimental \
      --from repo='fedora-multimedia' \
        "${AVAILABLE_PACKAGES[@]}"
    echo "Successfully replaced packages."
else
    echo "No packages available to replace."
fi

echo "Proprietary packages installation completed."
