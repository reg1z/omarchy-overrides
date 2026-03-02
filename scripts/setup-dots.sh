#!/bin/bash
# Install the whole shebang

USER_HOME=$(eval echo "~${SUDO_USER:-$USER}")
USER_DOTS="$USER_HOME/repos/omarchy-overrides"
SCRIPTS="$USER_DOTS/scripts"
USER_BINS="$USER_DOTS/scripts/bin"
LOCAL_BIN="$USER_HOME/.local/bin"

if gum confirm "Wanna install these dotfiles? They're pretty cool 😎"; then
  echo "hell ye"
else
  echo "nws fam"
  exit 1
fi

gum spin --spinner dot --title "lets goooooo !" -- sleep 3
echo "let's gooooo"


gum choose --no-limit
# Provide list of optional choices user can opt-in to
#     (gum choose)
# - QEMU
# - Migrate to NetworkManager. This will install gazelle TUI
#   - also provides support for software requiring nm
# - Install omarchy-theme-sync
# - terminal
#   - bash, zsh, fish
# - Shell (Your terminal only. bash will remain the system shell)
# - zsh
# - kanata with enthium
# - Default browser
#   - default chromium
#   - firefox
#     - firefox webapp support
#   - librewolf
#   - waterfox
#   - zen
#   - qutebrowser
# - WebApp browser?
# - 


# Install packages
# ...
yay -Syy --noconfirm


# THEN

migrate_to_nm() {
  $SCRIPTS/migrations/networkmanager-migrate.sh
  if gum confirm "Would you like to install Gazelle, a TUI for NetworkManager?"; then
    echo "cool"
    echo "Installing Gazelle TUI..."
    yay -Syu --noconfirm gazelle-tui
  else
    echo "aight"
    continue
  fi
}

install_qemu() {
  $SCRIPTS/install-qemu.sh
}

install_firefox() {
  if gum confirm "Would you like to use firefox for WebApps?"; then
    echo "cool"
    $SCRIPTS/
}

install_themesync() {
  $SCRIPTS/install-theme-sync.sh
}

choose_shell() {
}



