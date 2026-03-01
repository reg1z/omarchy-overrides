#!/bin/bash
USER_HOME=$(eval echo "~${SUDO_USER:-$USER}")
USER_DOTS=$USER_HOME/repos/omarchy-overrides
OMARCHY_BIN=$USER_HOME/.local/share/omarchy/bin
FFOX_DOTS="$USER_DOTS/firefox"
FFOX_CFG="$USER_HOME/.mozilla/firefox"

if [[ ! -f $OMARCHY_BIN/omarchy-launch-webapp.bak ]]; then
  echo -e "\nBacking up native binary and symlinking our custom one..."
  mv -v $OMARCHY_BIN/omarchy-launch-webapp $OMARCHY_BIN/omarchy-launch-webapp.bak
  chmod 755 $USER_HOME/repos/omarchy-overrides/firefox/omarchy-launch-webapp
  ln -s -v $FFOX_DOTS/omarchy-launch-webapp $OMARCHY_BIN/omarchy-launch-webapp
  echo -e "Custom binary linked!\n"
elif [[ "$1" == "restore" ]]; then
  echo -e "\nRestoring omarchy-launch-webapp..."
  rm -v $OMARCHY_BIN/omarchy-launch-webapp
  mv -v $OMARCHY_BIN/omarchy-launch-webapp.bak $OMARCHY_BIN/omarchy-launch-webapp
  echo -e "Native omarchy bin restored!\n"
else
  echo -e "\nBackup already present. No link necessary."
fi

# Ensure webapp profile has the correct styling
cp -v -RTf "$FFOX_DOTS/templates/WebApps/" "$FFOX_CFG/WebApps/"
exit 0
