-- you need to install 'utf8' module (e.g. with luarocks) if using Lua <=5.2.
-- package.path = package.path .. ";/home/luis/.dwm/luastat/?.lua"
local utf8 = require 'utf8'
local lib = require('lib')


local titlewidth = 40

widget = {
    plugin = 'mpd',
    cb = function(t)
        if t.what == 'update' then
            local title
            local color = lib.iconColor
            local play = lib.colorize("▶", color)
            -- local pause = lib.colorize("‖", color)
            local pause = lib.colorize("󰏤", color)
            local stop = lib.colorize("■", color)

            if t.song.Title then
                title = t.song.Title
                if t.song.Artist then
                    title = t.song.Artist .. ': ' .. title
                end
            else
                title = t.song.file or ''
            end
            title = (utf8.len(title) <= titlewidth)
                and title
                or utf8.sub(title, 1, titlewidth - 1) .. '…'

            return string.format('[%s %s]',
                ({ play = play, pause = pause, stop = stop })[t.status.state],
                title
            )
        else
            -- 'connecting' or 'error'
            return t.what
        end
    end
}
