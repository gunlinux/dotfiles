#!/bin/bash
WALLPAPER="~/wall_b.jpg" 
wal -i "$WALLPAPER"
# If you use swaybg directly, also run:
# swaybg -i "$WALLPAPER" -m fill &
swaybg -m fill -i ~/wall_b.jpg &




WAL_CACHE="$HOME/.cache/wal/colors"
HYPR_CONF="$HOME/.config/hypr/hyprland.conf"

if [[ -f "$WAL_CACHE" ]]; then
    # Read colors from Pywal cache
    colors=()
    while IFS= read -r line; do
        colors+=("$line")
    done < "$WAL_CACHE"
    
    # Convert to Hyprland format (remove # and add ff for alpha)
    background="${colors[0]:1}ff"
    color1="${colors[1]:1}ff"
    color2="${colors[2]:1}ff"
    color3="${colors[3]:1}ff"
    color4="${colors[4]:1}ff"
    color5="${colors[5]:1}ff"
    color6="${colors[6]:1}ff"
    foreground="${colors[7]:1}ff"
    
    # Apply colors to Hyprland in real-time
    hyprctl keyword general:col.active_border "0xff$color5 0xff$color6 0xff$color1 45deg"
    hyprctl keyword decoration:shadow:color "0xff$background"
    
    echo "Pywal colors applied to Hyprland"
    echo "Active border: $color5 -> $color6 -> $color1"
else
    echo "Pywal colors cache not found, run 'wal -i' first"
fi
