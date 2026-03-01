#!/bin/bash
# Sets up firefox as the default browser.
# Firefox will be used PWAs in place of chromium.
# System-wide policy will automatically install
# ublock-origin and disable telemetry across all
# profiles.

USER_HOME=$(eval echo "~${SUDO_USER:-$USER}")
USER_DOTS=$USER_HOME/repos/omarchy-overrides
FFOX_DOTS="$USER_DOTS/firefox"
FFOX_CFG="$USER_HOME/.mozilla/firefox"
OMARCHY_BIN=$USER_HOME/.local/share/omarchy/bin

# Import policies .json (enforces ublock origin, disabled telemetry, etc. system-wide)
sudo mkdir -p /etc/firefox/policies
sudo cp -f $FFOX_DOTS/policies.json /etc/firefox/policies/policies.json
sudo chown root:root /etc/firefox/policies/policies.json
sudo chmod 644 /etc/firefox/policies/policies.json

# Install firefox if not present
yay -Sy --needed firefox

############################
##### Browser Profiles #####
###                      ###
echo -e "Setting up Firefox Browser Profiles"

# PWAs
PROFILE="WebApps"
echo -e "Setting up $PROFILE Profile...\n"
firefox -no-remote -CreateProfile "$PROFILE $FFOX_CFG/$PROFILE"
sleep 5
cp -RTf "$FFOX_DOTS/templates/$PROFILE/" "$FFOX_CFG/$PROFILE/"

# Personal
PROFILE="Personal"
echo -e "Setting up $PROFILE Profile...\n"
firefox -no-remote -CreateProfile "$PROFILE $FFOX_CFG/$PROFILE"
sleep 5
cp -RTf "$FFOX_DOTS/templates/$PROFILE/" "$FFOX_CFG/$PROFILE/"

# Work
PROFILE="Work"
echo -e "Setting up $PROFILE Profile...\n"
firefox -no-remote -CreateProfile "$PROFILE $FFOX_CFG/$PROFILE"
sleep 5
cp -RTf "$FFOX_DOTS/templates/$PROFILE/" "$FFOX_CFG/$PROFILE/"

###                      ###
##### Browser Profiles #####
############################

# Replace omarchy-launch-webapp with ours (symlink new, backup old)

# If backup not present, take a backup
if [[ ! -f $OMARCHY_BIN/omarchy-launch-webapp.bak ]]; then
  mv $OMARCHY_BIN/omarchy-launch-webapp $OMARCHY_BIN/omarchy-launch-webapp.bak
fi 


# Set firefox as default browser
xdg-settings set default-web-browser firefox.desktop

echo "fin"
