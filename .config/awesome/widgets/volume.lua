local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local spawn = require("awful.spawn")
local awesomebuttons = require("awesome-buttons.awesome-buttons")
--local timeout = require("helpers.timer").timeout

local w
local default_width = 200
local default_height = 200
local icons_path = os.getenv("HOME") .. '/.config/awesome/awesome-buttons/icons/'

local timer = nil

local default_device = 'pulse' --args.device or 'pulse'

local function get_volume_cmd(device) return 'amixer -D ' .. device .. ' sget Master' end

local function get_volume_from_cmd_output(stdout)
    local status = string.match(stdout, "%[(o%D%D?)%]")   -- \[(o\D\D?)\] - [on] or [off]
    if status == 'off' then return nil end -- Muted

    local volume_level = string.match(stdout, "(%d?%d?%d)%%") -- (\d?\d?\d)\%)
    return string.format("% 3d", volume_level)
end

local function get_volume_async(device, callback)
    device = device or default_device
    spawn.easy_async(get_volume_cmd(device), function(stdout)
        callback(get_volume_from_cmd_output(stdout))
    end)
end

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

    get_volume_async(default_device, function(volume)
        local volume_str
        local volume_icon
        if volume == nil then
            volume_str = 'Mute'
            volume_icon = 'volume.svg'
        else
            volume_str = tostring(volume)
            volume_icon = 'volume.svg'
        end
        box:setup {
            wibox.widget{
                image = icons_path .. volume_icon,
                align  = 'center',
                valign = 'center',
                widget = wibox.widget.imagebox,
                forced_height = args.height or default_height,
                bg = '#ff0000'
            },
            wibox.widget{
                text = tostring(volume_str),
                align = "center",
                widget = wibox.widget.textbox,
            },
            layout = wibox.layout.flex.vertical
        }
        box.visible = true
        timer = gears.timer.start_new(seconds, function()
            box.visible = false
            return false
        end)
        --timeout(function() box.visible = false end, seconds)
    end)
end

return {
    launch = launch,
}
