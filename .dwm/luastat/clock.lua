-- package.path = package.path .. ";/home/luis/.dwm/luastat/?.lua"

local days = {
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
}

local months = {
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'Dicember',
}

widget = {
    plugin = 'timer',
    opts = { period = 5 },
    cb = function(t)
        -- local d = os.date('%A, %I:%M %p')
        local d = os.date('%I:%M %p')
        -- local text = string.format(' %s, %d %s, %02d:%02d ', days[d.wday], d.day, months[d.month], d.hour, d.min)
        return "[" .. d .. "]"
    end
}
