
xset s off -dpms

xset r rate 350 60

setxkbmap -option caps:swapescape

lxpolkit &

udiskie &

$HOME/.dwm/scripts/dwm-bar.sh &

feh --bg-fill $HOME/.dwm/Wallpapers/android.png &

picom --config $HOME/.dwm/picom/picom.conf &

mpd &

wmname LG3D

numlockx on &
