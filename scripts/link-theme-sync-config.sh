#!/bin/bash
# Link omarchy-theme-sync configs

USER_HOME=$(eval echo "~${SUDO_USER:-$USER}")

# Dotfiles
USER_DOTS="$USER_HOME/repos/omarchy-overrides"

# omarchy-theme-sync
THEMESYNC_CFG="$USER_HOME/.config/omarchy-theme-sync"
mkdir -p $THEMESYNC_CFG

for d in "$USER_DOTS/omarchy-theme-sync"/*/; do
  echo -e "\nLinking $d theme-sync configs..."
  folder=$(basename "$d")
  for f in "$d"/*; do
    file=$(basename "$f")
    if [ "$file" == "dir" ] || [ "$file" == "profignore" ]; then
      echo "Linking $file..."
      rm -v "$THEMESYNC_CFG"/"$folder"/"$file"
      ln -s -v "$d"/"$file" "$THEMESYNC_CFG"/"$folder"/"$file"
    fi
  done
done

echo -e "END: link-theme-sync-config.sh"
