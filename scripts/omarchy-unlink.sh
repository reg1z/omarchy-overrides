#!/bin/bash
# Remove / sever links to all potential
# conflicts with the main omarchy repo
#   (~/.local/share/omarchy)
# into the the system directories.

USER_HOME=$(eval echo "~${SUDO_USER:-$USER}")
USER_DOTS="$USER_HOME/repos/omarchy-overrides"
OMARCHY_BIN="$USER_HOME/.local/share/omarchy/bin"

# Remove Real Conflicting Files
$USER_DOTS/scripts/import-backgrounds.sh remove # Remove imported backgrounds
mv -v $OMARCHY_BIN/omarchy-theme-sync /tmp/omarchy-theme-sync # Move omarchy-theme-sync bin to tmp

# Sever Symbolic Links
$USER_DOTS/scripts/link-webapp-firefox.sh sever # Sever link to omarchy-launch-webapp + restore backup
$USER_DOTS/scripts/link-configs.sh sever # Sever links to core configs + restore backups

echo -e "Finished. Waiting a moment to let system settle..."
sleep 3
echo -e "END: omarchy-unlink.sh"
