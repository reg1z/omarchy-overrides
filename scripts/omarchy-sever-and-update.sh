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
echo "Preparing environment for update:"
gum spin --spinner monkey --title "Decoupling Overrides..." -- $USER_DOTS/scripts/omarchy-unlink.sh;
echo "Overrides Decoupled! Running omarchy-update"

# Update
omarchy-update;
echo "omarchy-update finished!"
gum spin --spinner monkey --title "Waiting a moment to let the system settle..." -- sleep 3;

# Relink

echo "Laying overrides..."
gum spin --spinner monkey --title "Recoupling..." -- $USER_DOTS/scripts/omarchy-relink.sh;

echo "Success!"
exit 0
