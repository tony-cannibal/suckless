#!/usr/bin/sh

amixer set Master 5%+ > /dev/null 
pkill -RTMIN+10 dwmblocks
