#!/bin/bash

run() {
  if ! pgrep -f "$1" ;
  then
    "$@" &
  fi
}


xset s off -dpms

xset r rate 350 60

setxkbmap -option caps:swapescape

# mpd &
run "mpd"

# $HOME/.dwm/scripts/dwm-bar.sh &
$HOME/.config/suckless/.dwm/lstat.sh &

feh --bg-fill $HOME/.dwm/Wallpapers/android.png &

picom --config $HOME/.dwm/picom/picom.conf &


# lxpolkit &
run "lxpolkit"

# udiskie &
run "udiskie"

wmname LG3D

# numlockx on &
run "numlockx on"

