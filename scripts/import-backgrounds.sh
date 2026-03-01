#!/bin/sh
# Import custom backgrounds into
# omarchy's default themes.

USER_HOME=$(eval echo "~${SUDO_USER:-$USER}")
USER_DOTS=$USER_HOME/repos/omarchy-overrides
OMARCHY=$USER_HOME/.local/share/omarchy

themes=(
  "catppuccin"
  "catppuccin-latte"
  "ethereal"
  "everforest"
  "flexoki-light"
  "gruvbox"
  "hackerman"
  "kanagawa"
  "matte-black"
  "nord"
  "osaka-jade"
  "ristretto"
  "rose-pine"
  "tokyo-night"
  "vantablack"
  "white"
  "miasma"
)

BACKGROUNDS=$USER_DOTS/backgrounds

# If adding "sever" as the first argument,
# unlink backgrounds.
if [[ "$1" == "sever"  ]]; then

  for theme in "${themes[@]}"; do
    for i in 00 01 02 03 04 05 06 07 08 09; do
      if [[ -f $BACKGROUNDS/$i-$theme.png ]]; then
        rm -v "$OMARCHY/themes/$theme/backgrounds/$i-$theme.png"
      fi
    done
  done

# Else, link them.
else

  for theme in "${themes[@]}"; do
    for i in 00 01 02 03 04 05 06 07 08 09; do
      if [[ -f $BACKGROUNDS/$i-$theme.png ]]; then
        cp -v "$USER_DOTS/backgrounds/$i-$theme.png" "$OMARCHY/themes/$theme/backgrounds/$i-$theme.png"
      fi
    done
  done

fi
