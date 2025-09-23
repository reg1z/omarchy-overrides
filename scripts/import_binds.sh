#!/bin/bash

USER_HOME=$(eval echo "~${SUDO_USER:-$USER}")
HYPR_CONFIG="$USER_HOME/.config/hypr"

cd ..

cp -f bindings-overrides.conf $HYPR_CONFIG/bindings-overrides.conf
cp -f bindings-submap-vm-passthru.conf $HYPR_CONFIG/bindings-submap-vm-passthru.conf
cp -f input.conf $HYPR_CONFIG/input.conf
cp -f master-layout.conf $HYPR_CONFIG/master-layout.conf
cp -f monitors.conf $HYPR_CONFIG/monitors.conf
cp -f bindings-speechnote.conf $HYPR_CONFIG/bindings-speechnote.conf
