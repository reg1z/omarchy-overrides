#!/bin/bash
# Installs a list of personally preferred packages to the system.

# Official Arch Repositories
packages=(
  "flatpak"
  "discord"
  "bitwarden"
  "proton-vpn-gtk-app"
  "proton-vpn-cli"
  "bc"
  "rust"
)

yay -Syy --noconfirm
yay -S --needed --noconfirm ${packages[@]}

# Flathub Flatpaks
flatpaks=(
  "app.grayjay.Grayjay"
)

flatpak install -y ${flatpaks[@]}

echo -e "END: install-packages.sh"
