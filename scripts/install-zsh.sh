#!/usr/bin/env bash
set -euo pipefail

# Install zsh + Oh My Zsh on Arch Linux with vi-mode plugin
# Run as your normal user (uses sudo for pacman/chsh)

echo "==> Installing zsh..."
sudo pacman -S --needed --noconfirm zsh

echo "==> Setting zsh as default shell..."
sudo chsh -s "$(command -v zsh)" "$USER"

echo "==> Installing Oh My Zsh..."
# RUNZSH=no  — don't launch zsh immediately after install
# KEEP_ZSHRC=no — let oh-my-zsh generate a fresh .zshrc if none exists
RUNZSH=no KEEP_ZSHRC=no sh -c \
  "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "==> Enabling vi-mode plugin..."
# Replace the plugins=(...) line in .zshrc to include vi-mode
if grep -q '^plugins=' ~/.zshrc; then
  sed -i 's/^plugins=(\(.*\))/plugins=(\1 vi-mode)/' ~/.zshrc
  # Clean up in case git was already the only plugin (avoid duplicate spaces)
  sed -i 's/  */ /g' ~/.zshrc
else
  echo 'plugins=(git vi-mode)' >> ~/.zshrc
fi

echo "==> Done! Log out and back in (or run 'zsh') to start using your new shell."
