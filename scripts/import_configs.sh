#!/bin/bash

USER_HOME=$(eval echo "~${SUDO_USER:-$USER}")
HYPR_CONFIG="$USER_HOME/.config/hypr"
HYPR_SCRIPTS="$HYPR_CONFIG/scripts"

cd ..

cp -f input.conf $HYPR_CONFIG/input.conf

# cp -f bindings.conf $HYPR_CONFIG/bindings.conf
cp -f bindings-overrides.conf $HYPR_CONFIG/bindings-overrides.conf
cp -f bindings-submap-vm-passthru.conf $HYPR_CONFIG/bindings-submap-vm-passthru.conf
cp -f bindings-speechnote.conf $HYPR_CONFIG/bindings-speechnote.conf

cp -f master-layout.conf $HYPR_CONFIG/master-layout.conf

cp -f monitors.conf $HYPR_CONFIG/monitors.conf

cp -f windows.conf $HYPR_CONFIG/windows.conf
cp -f windowrules-overrides.conf $HYPR_CONFIG/windowrules-overrides.conf
cp -f autostart.conf $HYPR_CONFIG/autostart.conf
cp -f envs.conf $HYPR_CONFIG/envs.conf
cp -f looknfeel.conf $HYPR_CONFIG/looknfeel.conf

# scripts
mkdir -p $HYPR_SCRIPTS
cp -f scripts/hyprscripts/hyprgamemode.sh $HYPR_SCRIPTS/hyprgamemode.sh
cp -f scripts/hyprscripts/delta-resize.sh $HYPR_SCRIPTS/delta-resize.sh
cp -f scripts/hyprscripts/orientation-cycle.sh $HYPR_SCRIPTS/orientation-cycle.sh
cp -f scripts/hyprscripts/master-roll.sh $HYPR_SCRIPTS/master-roll.sh
cp -f scripts/hyprscripts/center-mfact-daemon.sh $HYPR_SCRIPTS/center-mfact-daemon.sh
chmod 755 $HYPR_SCRIPTS/*.sh
