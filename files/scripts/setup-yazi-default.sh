#!/usr/bin/env bash
# Script to set Yazi as default file manager
# For use with BlueBuild images

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Setting up Yazi as default file manager...${NC}"

# Create applications directory if it doesn't exist
APPS_DIR="${HOME}/.local/share/applications"
mkdir -p "${APPS_DIR}"

# Create yazi.desktop file
DESKTOP_FILE="${APPS_DIR}/yazi.desktop"
echo -e "${YELLOW}Creating ${DESKTOP_FILE}...${NC}"

cat > "${DESKTOP_FILE}" << 'EOF'
[Desktop Entry]
Name=Yazi
Comment=Blazing fast terminal file manager
Exec=ghostty -e yazi %u
Terminal=false
Type=Application
Icon=utilities-terminal
Categories=System;FileTools;FileManager;
MimeType=inode/directory;
EOF

# Make sure the desktop file is executable
chmod +x "${DESKTOP_FILE}"

# Update desktop database
if command -v update-desktop-database &> /dev/null; then
    echo -e "${YELLOW}Updating desktop database...${NC}"
    update-desktop-database "${APPS_DIR}"
fi

# Set Yazi as default for directories
echo -e "${YELLOW}Setting Yazi as default file manager...${NC}"
xdg-mime default yazi.desktop inode/directory

# Verify the configuration
CURRENT_DEFAULT=$(xdg-mime query default inode/directory)
if [ "${CURRENT_DEFAULT}" = "yazi.desktop" ]; then
    echo -e "${GREEN}✓ Success! Yazi is now the default file manager.${NC}"
else
    echo -e "${RED}✗ Warning: Default file manager is still ${CURRENT_DEFAULT}${NC}"
    exit 1
fi

echo -e "${GREEN}Setup complete!${NC}"
echo -e "You can now open directories with: ${YELLOW}xdg-open /path/to/directory${NC}"
