#!/usr/bin/env sh
HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$HYPRGAMEMODE" = 1 ] ; then
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword animation borderangle,0; \
        keyword decoration:shadow:enabled 0;\
        keyword decoration:blur:enabled 0;\
        keyword decoration:blur:special false;\
	      keyword decoration:fullscreen_opacity 1.0;\
	      keyword decoration:inactive_opacity 1.0;\
	      keyword decoration:active_opacity 1.0;\
	      keyword decoration:opacity ;\
        keyword general:gaps_in 3;\
        keyword general:gaps_out 6;\
        keyword general:border_size 1;\
        keyword decoration:rounding 0;\
        keyword decoration:dim_special 1"
    
    hyprctl keyword 'windowrule[opaque]:enable true'
    hyprctl keyword 'windowrule[clear]:enable false'
    hyprctl notify 1 5000 "rgb(40a02b)" "Gamemode [ON]"
    exit
else
    hyprctl notify 1 5000 "rgb(d20f39)" "Gamemode [OFF]"
    hyprctl reload
    # hyprctl keyword 'windowrule[opaque]:enable false'
    # hyprctl keyword 'windowrule[clear]:enable true'
    exit 0
fi
exit 1
