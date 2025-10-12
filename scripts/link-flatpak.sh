#!/bin/bash

ln -s ~/.local/share/flatpak/exports/share/applications/*.desktop ~/.local/share/applications/
update-desktop-database ~/.local/share/applications/
