-- package.path = package.path .. ";/home/luis/.dwm/luastat/?.lua"
local lib = require "lib"

function capture(cmd, raw)
    local handle = assert(io.popen(cmd, 'r'))
    local output = assert(handle:read('*a'))

    handle:close()

    if raw then
        return output
    end

    output = string.gsub(
        string.gsub(
            string.gsub(output, '^%s+', ''),
            '%s+$',
            ''
        ),
        '[\n\r]+',
        ' '
    )

    return output
end

widget = {
    plugin = 'timer',
    opts = { period = 2 },
    cb = function(t)
        local color = lib.iconColor
        local prefix = lib.colorize("Hdd", color)
        local d = capture("df -h /home/luis/.media | tail -n 1 | awk '{print $4}'")
        return "[" .. prefix .. ":" .. d .. "]"
    end
}
