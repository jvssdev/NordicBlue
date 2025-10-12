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
  echo "Installing Colloid GTK Theme (for GTK apps in COSMIC)..."
  git clone https://github.com/vinceliuice/Colloid-gtk-theme.git /tmp/colloid-gtk
  cd /tmp/colloid-gtk
  ./install.sh -d "$THEME_DIR"
  cd -
  rm -rf /tmp/colloid-gtk
  echo "Colloid GTK Theme installed."
}
# Note: Flatpak overrides cannot be run during image build
# They will be handled by a systemd user service that runs on first boot
create_flatpak_setup_service() {
  echo "Creating Flatpak theme setup service..."
  
  SERVICE_DIR="/usr/lib/systemd/user"
  mkdir -p "$SERVICE_DIR"
  
  # Create the service file
  cat > "$SERVICE_DIR/flatpak-theme-setup.service" <<EOF
[Unit]
Description=Setup Flatpak GTK theme access
After=graphical-session.target
ConditionPathExists=%h/.local/share/flatpak

[Service]
Type=oneshot
ExecStart=/usr/bin/flatpak override --user --filesystem=xdg-config/gtk-3.0:ro
ExecStart=/usr/bin/flatpak override --user --filesystem=xdg-config/gtk-4.0:ro
ExecStart=/usr/bin/flatpak override --user --filesystem=/usr/share/themes:ro
ExecStart=/usr/bin/flatpak override --user --filesystem=/usr/share/icons:ro
RemainAfterExit=yes

[Install]
WantedBy=default.target
EOF

  echo "Flatpak setup service created at $SERVICE_DIR/flatpak-theme-setup.service"
  echo "Users can enable it with: systemctl --user enable flatpak-theme-setup.service"
}

# Install themes
install_colloid_icons
install_colloid_gtk
create_flatpak_setup_service

echo "Theme installation complete!"
