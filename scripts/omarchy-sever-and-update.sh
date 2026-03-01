#!/bin/bash
# Sever symlinks & remove
# conflicting files
# +
# Restore system defaults in
# ~/.local/share/omarchy
#  (the omarchy git repo)
# +
# Update omarchy
# (`omarchy-update`)
# +
# Reestablish symlinks & reimport files

USER_HOME=$(eval echo "~${SUDO_USER:-$USER}")
USER_DOTS="$USER_HOME/repos/omarchy-overrides"

# Unlink
$USER_DOTS/scripts/omarchy-unlink.sh;

# Update
omarchy-update;
echo -e "\n omarchy-update finished. Waiting a moment to let system settle..."
sleep 3;

# Relink
$USER_DOTS/scripts/omarchy-relink.sh;
