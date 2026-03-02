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

gum spin --spinner dot --title "lets goooooo !" -- sleep 1
echo "let's gooooo"

# Update repos
yay -Syy --noconfirm

##############################
######### Functions ##########
###                        ###

migrate_to_nm() {
  $SCRIPTS/migrations/networkmanager-migrate.sh
  if gum confirm "Would you like to install Gazelle, a TUI for NetworkManager?"; then
    echo "cool"
    echo "Installing Gazelle TUI..."
    yay -Syu --noconfirm gazelle-tui
  else
    echo "aight"
  fi
}

install_qemu() {
  $SCRIPTS/install-qemu.sh
}

install_firefox() {
  # Install it
  gum spin --spinner dot --title "Setting up Firefox..." -- $SCRIPTS/setup-firefox.sh
  echo "rad"

  # Prompt for webapp support
  if gum confirm "Would you like to use firefox for WebApps?"; then
    echo "cool"
    gum spin --spinner dot --title "Configuring omarchy-webapp-launcher..." -- $SCRIPTS/link-webapp-firefox.sh
  else
    echo "aight"
  fi
  return 0
}

install_themesync() {
  gum spin --spinner dot --title "Installing omarchy-theme-sync..." -- $SCRIPTS/install-theme-sync.sh
  gum spin --spinner dot --title "Symlinking theme-sync configs..." -- $SCRIPTS/link-theme-sync-config.sh
}

install_kanata() {
  $SCRIPTS/laptop_kanata_enthium.sh
  if gum confirm "Are you SURE you want to install the enthium layout? It might break you."; then
    echo "cool"
    gum spin --spinner dot --title "Installing Kanata & Enthium..." -- $SCRIPTS/laptop_kanata_enthium.sh
  else
    echo "aight"
  fi
}

choose_shell() {
  GHOSTTY_CFG="$USER_HOME/.config/ghostty"
  # Keep default config backed up
  if [[ ! -f "$GHOSTTY_CFG/config.bak" ]]; then
    echo "Backing up ghostty config."
    mv -v "$GHOSTTY_CFG/config" "$GHOSTTY_CFG/config.bak"
  fi

  if gum confirm "Wanna use zsh, NERD?"; then
    echo "cool"
    gum spin --spinner dot --title "Installing zsh and symlinking ghostty config" -- yay -S --noconfirm --needed zsh
    rm "$GHOSTTY_CFG/config"
    ln -s "$USER_DOTS/ghostty/zsh/config" "$GHOSTTY_CFG/config"
    echo "Shell SET."
  else
    echo "aight"
    echo "jus gon go w/ bash, ya feel"
    rm "$GHOSTTY_CFG/config"
    ln -s "$USER_DOTS/ghostty/bash/config" "$GHOSTTY_CFG/config"
  fi
}

###                        ###
######### Functions ##########
##############################

# THEN

# Provide list of optional choices user can opt-in to
#     (gum choose)
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

# Ask for selection

items=$(gum choose --no-limit --header "Wadya want?" \
  'migrate-to-networkmanager' \
  'QEMU' \
  'Firefox' \
  'omarchy-theme-sync' \
  'kanata-enthium' \
  'Alternative-Shell')

while IFS= read -r item <&3 ; do
  case $item in
    'migrate-to-networkmanager')
      echo -e "\nMigrating to NetworkManager..."
      migrate_to_nm
      ;;
    'QEMU')
      echo -e "\nInstalling QEMU..."
      install_qemu
      ;;
    'Firefox')
      echo -e "\nInstalling Firefox..."
      install_firefox
      ;;
    'omarchy-theme-sync')
      echo -e "\nInstalling omarchy-theme-sync..."
      install_themesync
      gum spin --spinner dot --title "Syncing Themes..." -- omarchy-theme-sync
      ;;
    'kanata-enthium')
      echo -e "\nInstalling kanata keyboard daemon with enthium glove80-style layout"
      install_kanata
      ;;
    'Alternative-Shell')
      echo -e "\nLet's pick ur sh3ll"
      choose_shell
      ;;
  esac
done 3<<< "$items"

echo "Importing system configs..."
gum spin --spinner dot --title "Please don't touch anything..." -- $SCRIPTS/link-configs.sh link


