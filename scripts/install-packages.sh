#!/bin/bash
# Installs a list of personally preferred packages to the system.

# Official Arch Repositories
packages=(
  "flatpak"
  "discord"
  "tmux"
)

sudo pacman -S --needed --noconfirm ${packages[@]}

# Flathub Flatpaks
flatpaks=(
  "app.grayjay.Grayjay"
)

flatpak install -y ${flatpaks[@]}
