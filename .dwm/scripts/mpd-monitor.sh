#!/bin/bash

mpdstate () {
    lines=$(mpc 2>&1 | wc -l)
    if [[ $lines -eq 3 ]] ; then
        song=$(mpc 2>&1 | head -n 1 | sed 's/\(.\{24\}\).*/\1.../')
        state=$(mpc 2>&1 |  sed -n '2 p' | awk '{print $1}' | tr -d "[]")
        if [[ $state = "playing" ]] ; then
            mpdstate="MP$song"
        else
            mpdstate="Mp$song"
        fi
    else
        mpdstate="Ms--stop--"
    fi
    echo -e $mpdstate
}

# FIFO=$1

err="MPD error: Connection refused"

while true ; do
    res=$(mpc 2>&1 | head -n 1)
    if [[ $res = $err ]] ; then
        echo -e "MsConnecting"
    else
        mpdstate
        mpc idleloop player 2>&1 | while read -r line ; do
            mpdstate
        done
    fi
    sleep 2
done # > $FIFO




