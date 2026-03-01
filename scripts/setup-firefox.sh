#!/bin/bash
# Sets up firefox as the default browser.
# Firefox will be used PWAs in place of chromium.
# System-wide policy will automatically install
# ublock-origin and disable telemetry across all
# profiles.

USER_HOME=$(eval echo "~${SUDO_USER:-$USER}")
FFOX_CFG="$USER_HOME/.mozilla/firefox"
FFOX_DOTS="../firefox"

# Import policies .json (enforces ublock origin, disabled telemetry, etc. system-wide)
sudo mkdir -p /etc/firefox/policies
sudo cp -f $FFOX_DOTS/policies.json /etc/firefox/policies/policies.json
sudo chown root:root /etc/firefox/policies/policies.json
sudo chmod 644 /etc/firefox/policies/policies.json

# Install firefox if not present
yay -Sy --needed firefox

#########################
### Browser Profiles: ###


# PWAs
PROFILE="WebApps"
echo "Setting up $PROFILE Profile...\n"
firefox -no-remote -CreateProfile "$PROFILE $FFOX_CFG/$PROFILE"
sleep 5
cp -RTf "$FFOX_DOTS/templates/$PROFILE/" "$FFOX_CFG/$PROFILE/"

# Personal
PROFILE="Personal"
echo "Setting up $PROFILE Profile...\n"
firefox -no-remote -CreateProfile "$PROFILE $FFOX_CFG/$PROFILE"
sleep 5
cp -RTf "$FFOX_DOTS/templates/$PROFILE/" "$FFOX_CFG/$PROFILE/"

# Work
PROFILE="Work"
echo "Setting up $PROFILE Profile...\n"
firefox -no-remote -CreateProfile "$PROFILE $FFOX_CFG/$PROFILE"
sleep 5
cp -RTf "$FFOX_DOTS/templates/$PROFILE/" "$FFOX_CFG/$PROFILE/"

###                   ###
#########################


# Replace omarchy-launch-webapp with ours (backing up the old)
mv ~/.local/share/omarchy/bin/omarchy-launch-webapp ~/.local/share/omarchy/bin/omarchy-launch-webapp.bak
cp -f $FFOX_DOTS/omarchy-launch-webapp.sh ~/.local/share/omarchy/bin/omarchy-launch-webapp
sudo chmod 755 ~/.local/share/omarchy/bin/omarchy-launch-webapp

# Set firefox as default browser
xdg-settings set default-web-browser firefox.desktop

echo "fin"
