#!/bin/bash

USER_HOME=$(eval echo "~${SUDO_USER:-$USER}")
HYPR_CONFIG="$USER_HOME/.config/hypr"

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

# scripts
mkdir -p ~/.scripts
cp -f scripts/hyprgamemode.sh ~/.scripts/hyprgamemode.sh
