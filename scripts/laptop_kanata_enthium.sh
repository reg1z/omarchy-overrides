#!/bin/bash
# Installs my kanata keyboard layout.
# Clones into tmp and then cleans up files.

cd /tmp
yay -S --needed --no-confirm rust 
echo -e "\nCloning keyboard layout repo."
git clone https://github.com/reg1z/kanata-enthium.git
cd kanata-enthium
sudo ./install-kanata.sh
echo -e "\nInstallation complete. Removing keyboard repo."
rm -rf kanata-enthium

