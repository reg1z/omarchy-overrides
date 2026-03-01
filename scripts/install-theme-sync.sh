#!/bin/bash
USER_HOME=$(eval echo "~${SUDO_USER:-$USER}")
USER_DOTS=$USER_HOME/repos/omarchy-overrides
OMARCHY_BIN=$USER_HOME/.local/share/omarchy/bin

cd $USER_HOME/repos

# Attempt cloning via ssh
git clone git@github.com:reg1z/omarchy-theme-sync.git

sleep 3

# Clone via https as a fallback
if [[ ! -d "omarchy-theme-sync" ]]; then
  echo -e "\nssh clone attempt failed. Using https..."
  git clone https://github.com/reg1z/omarchy-theme-sync
fi

cd omarchy-theme-sync

chmod 755 install.sh
chmod 755 omarchy-theme-sync

./install.sh
sleep 1

$USER_DOTS/scripts/link-theme-sync-config.sh

# Sync theme for first time
omarchy-theme-sync

echo -e "END: install-theme-sync.sh"
