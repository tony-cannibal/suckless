-- package.path = package.path .. ";/home/luis/.dwm/luastat/?.lua"
local lib = require 'lib'

widget = {
    plugin = 'pulse',
    cb = function(t)
        local color = lib.iconColor
        local prefix = lib.colorize("Vol", color)
        if t.mute then
            return '[mute]'
        end
        local percent = (t.cur / t.norm) * 100
        return "[" .. prefix .. string.format(':%s%%', math.floor(0.5 + percent)) .. "]"
    end,
}
