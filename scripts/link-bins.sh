#!/bin/bash

USER_HOME=$(eval echo "~${SUDO_USER:-$USER}")
USER_DOTS="$USER_HOME/repos/omarchy-overrides"
USER_BINS="$USER_DOTS/scripts/bin"
LOCAL_BIN="$USER_HOME/.local/bin"

chmod 755 $USER_BINS/*
mkdir -p "$LOCAL_BIN"

for f in "$USER_BINS"/*; do
  file=$(basename "$f")
  echo "Linking $file..."
  rm -v "$LOCAL_BIN"/"$file"
  ln -s -v "$USER_BINS"/"$file" "$LOCAL_BIN"/"$file"
done

echo "END: import-bins.sh"
