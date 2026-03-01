#!/bin/bash
# Reestablishes symbolic links &
# reimports files.
#
# Intended to be used after unlinking
# & updating omarchy.

USER_HOME=$(eval echo "~${SUDO_USER:-$USER}")
USER_DOTS="$USER_HOME/repos/omarchy-overrides"
OMARCHY_BIN="$USER_HOME/.local/share/omarchy/bin"

# Reimport Real Files
$USER_DOTS/scripts/import-backgrounds.sh
mv -v /tmp/omarchy-theme-sync $OMARCHY_BIN/omarchy-theme-sync

# Reestablish Symbolic Links
$USER_DOTS/scripts/link-webapp-firefox.sh
$USER_DOTS/scripts/link-configs.sh link

echo -e "Finished. Waiting a moment to let system settle..."
sleep 3
echo -e "END: omarchy-relink.sh"
