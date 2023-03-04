#!/usr/bin/sh


fifo="/tmp/dwm-bar.fifo"

pamixer -i 5

printf 'V%s\n' " $(pamixer --get-volume-human) " > "$fifo"

