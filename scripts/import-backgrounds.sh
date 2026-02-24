#!/bin/sh
# Import custom backgrounds into
# omarchy's default themes.

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
)

for theme in "${themes[@]}"; do
  for i in 00 01 02 03 04 05 06 07 08 09; do
    cp -f ../backgrounds/$i-$theme.png ~/.local/share/omarchy/themes/$theme/backgrounds/$i-$theme.png
  done
done
