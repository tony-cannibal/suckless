#!/bin/bash

fifo="/tmp/dwm-bar.fifo"

pamixer -t

printf 'V%s\n' " $(pamixer --get-volume-human) " > "$fifo"
