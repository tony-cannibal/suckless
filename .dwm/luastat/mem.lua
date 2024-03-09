-- package.path = package.path .. ";/home/luis/.dwm/luastat/?.lua"
local lib = require("lib")

local function capture(cmd, raw)
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
        local prefix = lib.colorize("Mem", color)
        local d = capture("free -h | sed -n '2p' | awk '{print $3 \"/\"$2}' | sed 's/i//g'")
        -- local text = string.format(' %s, %d %s, %02d:%02d ', days[d.wday], d.day, months[d.month], d.hour, d.min)
        return "[" .. prefix .. ":" .. d .. "]"
    end
}
