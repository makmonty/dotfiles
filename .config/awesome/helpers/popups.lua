local awful = require("awful")
local gears = require("gears")

local function createPopup(widget)
    return awful.popup {
        widget = widget,
        shape = gears.shape.rounded_rect,
    }
end

return {
    createPopup = createPopup,
}
