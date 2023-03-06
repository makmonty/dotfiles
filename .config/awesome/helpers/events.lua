local gears = require('gears')

local double_click_timer = nil
local double_click_timeout = 0.20

local function double_click_event_handler(double_click_event)
    if double_click_timer then
        double_click_timer:stop()
        double_click_timer = nil

        double_click_event()

        return
    end

    double_click_timer = gears.timer.start_new(double_click_timeout, function()
        double_click_timer = nil
        return false
    end)
end

return {
    double_click_event_handler = double_click_event_handler,
}
