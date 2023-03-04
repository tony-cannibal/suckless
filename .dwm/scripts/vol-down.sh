#!/usr/bin/sh


fifo="/tmp/dwm-bar.fifo"

pamixer -d 5

printf 'V%s\n' " $(pamixer --get-volume-human) " > "$fifo"

