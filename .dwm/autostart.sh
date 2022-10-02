#!/usr/bin/bash


# Disable Screen Sleep
xset s off -dpms

# Swap Capslock With Escape
setxkbmap -option caps:swapescape

# Status Bar
dwmblocks &

feh --bg-fill ~/Pictures/Wallpapers/Gruvbox/plate-dark.jpg &

# Polkit Agent
lxpolkit &

# Automount Utility
udiskie &

# Compositor
picom & 

# Music Server
mpd &

