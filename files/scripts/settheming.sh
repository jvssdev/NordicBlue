#!/usr/bin/env bash
# Tell build process to exit if there are any errors.
set -oue pipefail

# Use system directories instead of $HOME (which doesn't exist during build)
ICON_DIR="/usr/share/icons"
THEME_DIR="/usr/share/themes"

mkdir -p "$ICON_DIR" "$THEME_DIR"

install_colloid_icons() {
  echo "Installing Colloid Icon Theme..."
  git clone https://github.com/vinceliuice/Colloid-icon-theme.git /tmp/colloid-icons
  cd /tmp/colloid-icons
  ./install.sh -d "$ICON_DIR"
  cd -
  rm -rf /tmp/colloid-icons
  echo "Colloid Icon Theme installed."
}

install_colloid_gtk() {
  echo "Installing Colloid GTK Theme..."
  git clone https://github.com/vinceliuice/Colloid-gtk-theme.git /tmp/colloid-gtk
  cd /tmp/colloid-gtk
  ./install.sh -d "$THEME_DIR"
  cd -
  rm -rf /tmp/colloid-gtk
  echo "Colloid GTK Theme installed."
}

# Fix for Flatpak
flatpak override --filesystem=xdg-config/gtk-3.0 
flatpak override --filesystem=xdg-config/gtk-4.0

install_colloid_icons
install_colloid_gtk
