#!/bin/bash

cd $HOME/.config/suckless/.dwm/luastat/

luastatus -b dwm -B separator='' mpd.lua \
                                net.lua \
                                fs.lua \
                                mem.lua \
                                vol.lua \
                                clock.lua
