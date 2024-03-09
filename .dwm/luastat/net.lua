-- package.path = package.path .. ";/home/luis/.dwm/luastat/?.lua"

local lib = require("lib")

widget = {
    plugin = 'network-linux',
    timeout = 1,
    cb = function(t)
        local color = lib.iconColor
        local prefix = lib.colorize("Net", color)
        local r = {}
        for iface, params in pairs(t) do
            local addr = params.ipv6 or params.ipv4
            if addr then
                -- strip out "label" from the interface name
                iface = iface:gsub(':.*', '')
                -- strip out "zone index" from the address
                addr = addr:gsub('%%.*', '')

                if iface ~= 'lo' then
                    r[#r + 1] = "[" .. prefix .. string.format(':%s]', iface)
                end
            end
        end
        return r
    end,
}
