#!/bin/bash
# Unlink / link configs

########################
###### Variables #######
###     + setup      ###

USER_HOME=$(eval echo "~${SUDO_USER:-$USER}")

# Dotfiles
USER_DOTS="$USER_HOME/repos/omarchy-overrides"
HYPR_DOTS="$USER_DOTS/hypr"
HYPR_SCRIPTS="$USER_DOTS/scripts/hyprscripts"
chmod 755 $HYPR_SCRIPTS/*.sh # Ensure correct perm -vs

# Hyprland ~/.config files
HYPR_LOCAL="$USER_HOME/.config/hypr"
HYPR_LOCAL_SCRIPTS="$HYPR_LOCAL/scripts"
mkdir -p $HYPR_LOCAL_SCRIPTS # Ensure existence

# Tmux
TMUX_CFG="$USER_HOME/.config/tmux"
mkdir -p $TMUX_CFG

# fcitx5
FCITX5_CFG="$USER_HOME/.config/fcitx5/conf"
mkdir -p $FCITX5_CFG

# waybar
WAYBAR_CFG="$USER_HOME/.config/waybar"
mkdir -p $WAYBAR_CFG

###                  ###
###### Variables #######
########################

########################
###### Functions #######
###                  ###

backup() {
  # Check for existing backups. Exit if present.
  for f in $HYPR_LOCAL/*.conf; do
    if [[ "$f" == "*.bak" ]]; then
      echo -e "Backups already present.\Ending execution."
      exit 0
    fi
  done

  # Make backups for each file that corresponds
  # to a custom config.
  for f in $HYPR_DOTS/*.conf; do
    cp "$HYPR_LOCAL/${f}" "$HYPR_LOCAL/${f}.bak"
  done
}

restore {
  for f in $HYPR_DOTS/*.conf; do
    mv "$HYPR_LOCAL/${f}.bak" "$HYPR_LOCAL/${f}"
  done
}

link() {
  # sever, then relink
  sever;

  # Hyprland Configs
	ln -s -v $HYPR_DOTS/input.conf $HYPR_LOCAL/input.conf
	ln -s -v $HYPR_DOTS/bindings.conf $HYPR_LOCAL/bindings.conf
	ln -s -v $HYPR_DOTS/bindings-submap-vm-passthru.conf $HYPR_LOCAL/bindings-submap-vm-passthru.conf
	ln -s -v $HYPR_DOTS/layout-master.conf $HYPR_LOCAL/layout-master.conf
	ln -s -v $HYPR_DOTS/monitors.conf $HYPR_LOCAL/monitors.conf
	ln -s -v $HYPR_DOTS/windows.conf $HYPR_LOCAL/windows.conf
	ln -s -v $HYPR_DOTS/autostart.conf $HYPR_LOCAL/autostart.conf
	ln -s -v $HYPR_DOTS/envs.conf $HYPR_LOCAL/envs.conf
	ln -s -v $HYPR_DOTS/looknfeel.conf $HYPR_LOCAL/looknfeel.conf

  # Hyprland Scripts
	ln -s -v $HYPR_SCRIPTS/hyprgamemode.sh $HYPR_LOCAL_SCRIPTS/hyprgamemode.sh # Decorations Toggle
	ln -s -v $HYPR_SCRIPTS/delta-resize.sh $HYPR_LOCAL_SCRIPTS/delta-resize.sh # Calculates resize factor
	ln -s -v $HYPR_SCRIPTS/orientation-cycle.sh $HYPR_LOCAL_SCRIPTS/orientation-cycle.sh # Master Layout orientation cycle
	ln -s -v $HYPR_SCRIPTS/master-roll.sh $HYPR_LOCAL_SCRIPTS/master-roll.sh # Roll to next window with correct mfact for master center orientation
	ln -s -v $HYPR_SCRIPTS/center-mfact-daemon.sh $HYPR_LOCAL_SCRIPTS/center-mfact-daemon.sh # Daemon. Applies proper mfact in master-center layout orientation

  # tmux
	ln -s -v $USER_DOTS/tmux/tmux.conf $TMUX_CFG/tmux.conf

  # fcitx5
	ln -s -v $USER_DOTS/fcitx5/spell.conf $FCITX5_CFG/spell.conf

  # Waybar
	ln -s -v $USER_DOTS/waybar/config.jsonc $WAYBAR_CFG/config.jsonc
}

sever() {
  # Hyprland Configs
  rm -v $HYPR_LOCAL/input.conf
  rm -v $HYPR_LOCAL/bindings-submap-vm-passthru.conf
  rm -v $HYPR_LOCAL/layout-master.conf
  rm -v $HYPR_LOCAL/monitors.conf
  rm -v $HYPR_LOCAL/windows.conf
  rm -v $HYPR_LOCAL/autostart.conf
  rm -v $HYPR_LOCAL/envs.conf
  rm -v $HYPR_LOCAL/looknfeel.conf

  # Hyprland Scripts
  rm -v $HYPR_LOCAL_SCRIPTS/hyprgamemode.sh
  rm -v $HYPR_LOCAL_SCRIPTS/delta-resize.sh
  rm -v $HYPR_LOCAL_SCRIPTS/orientation-cycle.sh
  rm -v $HYPR_LOCAL_SCRIPTS/master-roll.sh
  rm -v $HYPR_LOCAL_SCRIPTS/center-mfact-daemon.sh

  # tmux
  rm -v $TMUX_CFG/tmux.conf

  # fcitx5
  rm -v $FCITX5_CFG/spell.conf

  # Waybar
  rm -v $USER_HOME/.config/waybar.jsonc
}

reload_env() {
  sleep 1
  hyprctl reload
  sleep 1
  killall waybar
  waybar > /dev/null 2>&1 &
}

###                  ###
###### Functions #######
########################

# Execution
if [[ "$1" == "backup" ]]; then
  echo -e "Backing up files in $HYPR_LOCAL..."
  backup;
  exit 0
elif [[ "$1" == "restore" ]]; then
  echo -e "Restoring files in $HYPR_LOCAL..."
  sever;
  restore;
  exit 0
elif [[ "$1" == "sever" ]]; then
  echo -e "Severing links.\nThe environment will not be reloaded.\n"
  sever;
  restore;
  exit 0
elif [[ "$1" == "link" ]]; then
  echo -e "Linking configs.\nThe environment will be reloaded.\n"
  sever;
  link;
else
  echo "No input specified.\nPlease enter 'sever', 'link', 'backup', or 'restore'.\n"
  exit 0
fi

reload_env;
echo -e "\nEnvironment Reloaded.\n"
exit 0

