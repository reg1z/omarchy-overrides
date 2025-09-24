#!/bin/bash
# Replaces systemd-networkd with NetworkManager
# Replaces Impala with nmtui

# Credit for 95% of this script goes to blazskufca (https://github.com/basecamp/omarchy/pull/1446)

USER_HOME=$(eval echo "~${SUDO_USER:-$USER}")
CURRENT_USER=$(whoami)
USER_ID=$(id -u $CURRENT_USER)

echo "Switching from systemd-networkd to NetworkManager"

if systemctl is-enabled --quiet NetworkManager.service 2>/dev/null; then
  echo "NetworkManager is already enabled, skipping migration"
  exit 0
fi

yay -S --noconfirm --needed networkmanager

if systemctl is-enabled --quiet systemd-networkd.service 2>/dev/null; then
  sudo systemctl disable --now systemd-networkd.service
fi

if systemctl is-enabled --quiet systemd-networkd-wait-online.service 2>/dev/null; then
  sudo systemctl disable --now systemd-networkd-wait-online.service
fi

if systemctl is-enabled --quiet wpa_supplicant.service 2>/dev/null; then
  sudo systemctl disable --now wpa_supplicant.service
  sudo systemctl mask wpa_supplicant.service
fi

if systemctl is-enabled --quiet iwd.service 2>/dev/null; then
  sudo systemctl disable --now iwd.service
fi

sudo mkdir -p /etc/NetworkManager/conf.d
sudo tee /etc/NetworkManager/conf.d/wifi_backend.conf >/dev/null <<EOF
[device]
wifi.backend=iwd
EOF

if [[ ! -L /etc/resolv.conf ]] || ! readlink /etc/resolv.conf | grep -q "systemd/resolve"; then
  # Backup existing resolv.conf if it's a regular file
  if [[ -f /etc/resolv.conf ]] && [[ ! -L /etc/resolv.conf ]]; then
    echo "Backing up existing /etc/resolv.conf to /etc/resolv.conf.backup"
    sudo cp /etc/resolv.conf /etc/resolv.conf.backup
  fi

  # Remove existing file/symlink and create proper symlink
  sudo rm -f /etc/resolv.conf
  sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
fi

sudo tee /etc/NetworkManager/conf.d/dns.conf >/dev/null <<EOF
[main]
dns=systemd-resolved
EOF

sudo systemctl enable --now NetworkManager.service

# Remove any custom systemd-networkd-wait-online overrides since we're not using it anymore
if [[ -f /etc/systemd/system/systemd-networkd-wait-online.service.d/wait-for-only-one-interface.conf ]]; then
  echo "Removing systemd-networkd-wait-online override..."
  sudo rm -f /etc/systemd/system/systemd-networkd-wait-online.service.d/wait-for-only-one-interface.conf
  sudo rmdir /etc/systemd/system/systemd-networkd-wait-online.service.d/ 2>/dev/null || true
fi

# Reload systemd daemon
sudo systemctl daemon-reload

# Backup omarchy-menu command
cp -f $USER_HOME/.local/share/omarchy/bin/omarchy-menu $USER_HOME/.local/share/omarchy/bin/omarchy-menu.bak

# Backup omarchy waybar configuration
cp -f $USER_HOME/.config/waybar/config.jsonc $USER_HOME/.config/waybar/config.jsonc.bak

# Replace instances of Impala/impala with nmtui for omarchy-menu command
sed -i "s/Impala/nmtui/g" "$USER_HOME/.local/share/omarchy/bin/omarchy-menu"
sed -i "s/impala/nmtui/g" "$USER_HOME/.local/share/omarchy/bin/omarchy-menu"

# Replace instances of Impala/impala with nmtui for waybar configuration
sed -i "s/Impala/nmtui/g" "$USER_HOME/.config/waybar/config.jsonc"
sed -i "s/impala/nmtui/g" "$USER_HOME/.config/waybar/config.jsonc"
