#!/usr/bin/env bash
# Script to set Yazi as default file manager for BlueBuild
# Uses /etc/skel to apply to new users

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Setting up Yazi as default file manager...${NC}"

# Create skel directories
SKEL_APPS_DIR="/etc/skel/.local/share/applications"
SKEL_CONFIG_DIR="/etc/skel/.config"

mkdir -p "${SKEL_APPS_DIR}"
mkdir -p "${SKEL_CONFIG_DIR}"

# Create yazi.desktop file
DESKTOP_FILE="${SKEL_APPS_DIR}/yazi.desktop"
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

chmod 644 "${DESKTOP_FILE}"

# Create mimeapps.list to set default file manager
MIMEAPPS_FILE="${SKEL_CONFIG_DIR}/mimeapps.list"
echo -e "${YELLOW}Creating ${MIMEAPPS_FILE}...${NC}"

# Check if mimeapps.list already exists
if [ -f "${MIMEAPPS_FILE}" ]; then
    # Add or update the directory association
    if grep -q "inode/directory=" "${MIMEAPPS_FILE}"; then
        sed -i 's|inode/directory=.*|inode/directory=yazi.desktop|' "${MIMEAPPS_FILE}"
    else
        # Add to [Default Applications] section or create it
        if grep -q "\[Default Applications\]" "${MIMEAPPS_FILE}"; then
            sed -i '/\[Default Applications\]/a inode/directory=yazi.desktop' "${MIMEAPPS_FILE}"
        else
            echo -e "\n[Default Applications]\ninode/directory=yazi.desktop" >> "${MIMEAPPS_FILE}"
        fi
    fi
else
    # Create new mimeapps.list
    cat > "${MIMEAPPS_FILE}" << 'EOF'
[Default Applications]
inode/directory=yazi.desktop

[Added Associations]
inode/directory=yazi.desktop;
EOF
fi

chmod 644 "${MIMEAPPS_FILE}"

echo -e "${GREEN}✓ Yazi configuration added to /etc/skel${NC}"
echo -e "${GREEN}✓ New users will have Yazi as default file manager${NC}"
echo -e "${YELLOW}Note: Existing users need to run this manually or copy files from /etc/skel${NC}"
