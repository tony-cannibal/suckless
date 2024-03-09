local M = {}

function M.colorize(text, color)
    text = "^c" .. color .. "^" .. text .. "^d^" or text
    return text
end

M.iconColor = "#377375"

return M
