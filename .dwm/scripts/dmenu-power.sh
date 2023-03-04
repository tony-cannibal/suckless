#!/bin/bash

function powermenu {

    options="Shutdown\nReboot\nLogout\nCancel"

    selected=$(echo -e $options | dmenu -bw 3 -l 4 -z 120 -x 1240 -y 16 -p "Power Menu" -fn "terminus-14" -sb '#377375' -sf '#e6d4a3' -nb '#1e1e1e' -nf '#e6d4a3')

    if [[ $selected = "Shutdown" ]]; then
        loginctl poweroff

    elif [[ $selected = "Reboot" ]]; then
        loginctl reboot
    
    elif [[ $selected = "Logout" ]]; then
        pkill dwm
        exit

    elif [[ $selected = "Cancel" ]]; then
        return
    
    fi

}

powermenu
