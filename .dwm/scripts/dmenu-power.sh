#!/bin/bash

base=#377375
fg=#e6d4a3
bg=#1e1e1e
font="terminus-14"

# to specify the font use -fn

function powermenu {

    options="Shutdown\nReboot\nLogout\nCancel"

    selected=$(echo -e $options | dmenu -bw 3 -l 4 -z 132 -x 1787 -y 21 -p "Power Menu" -sb $base -sf $fg -nb $bg -nf $fg )

    if [[ $selected = "Shutdown" ]]; then
        # loginctl poweroff
        poweroff

    elif [[ $selected = "Reboot" ]]; then
        # loginctl reboot
        reboot
    
    elif [[ $selected = "Logout" ]]; then
        pkill dwm
        exit

    elif [[ $selected = "Cancel" ]]; then
        return
    
    fi

}

powermenu
