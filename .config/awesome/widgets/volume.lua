local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local awesomebuttons = require("awesome-buttons.awesome-buttons")
--local timeout = require("helpers.timer").timeout

local w
local default_width = 200
local default_height = 200
local icons_path = os.getenv("HOME") .. '/.config/awesome/awesome-buttons/icons/'

local timer = nil

local function get_box(args)
    if w then
        return w
    end

    w = wibox {
        bg = beautiful.fg_normal,
        max_widget_size = 500,
        ontop = true,
        height = args.height or default_height,
        width = args.width or default_width,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 8)
        end,
    }
    w:set_bg('#ffffff33')
    return w
end


local function launch(args)
    if timer ~= nil then
        timer:stop()
    end
    local box = get_box(args)
    local seconds = args.seconds or 1

    box:setup {
        {
            wibox.widget{
                image = icons_path .. 'volume.svg',
                align  = 'center',
                valign = 'center',
                widget = wibox.widget.imagebox,
                forced_height = args.height or default_height,
            },
            align = 'center',
            layout = wibox.layout.align.vertical
        },
        align = 'center',
        layout = wibox.layout.align.vertical
    }
    box.visible = true
    timer = gears.timer.start_new(seconds, function()
        box.visible = false
        return false
    end)
    --timeout(function() box.visible = false end, seconds)
end

return {
    launch = launch,
}
