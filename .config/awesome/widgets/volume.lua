local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local theme = require("theme")
local beautiful = require("beautiful")
local shapes = require("helpers.shapes")
local maths = require("helpers.maths")
local spawn = awful.spawn
local prc2pix = maths.prc2pix
--local timeout = require("helpers.timer").timeout

local w = nil
local icons_path = os.getenv("HOME") .. '/.config/awesome/awesome-buttons/icons/'

local timer = nil
local last_known_volume = 0

local default_device = 'pulse'
local default_width = 200
local default_height = 200

local function get_volume_cmd(device) return 'amixer -D ' .. device .. ' sget Master' end

local function get_volume_from_cmd_output(stdout)
    local status = string.match(stdout, "%[(o%D%D?)%]")   -- \[(o\D\D?)\] - [on] or [off]
    if status == 'off' then return nil end -- Muted

    local volume_level = string.match(stdout, "(%d?%d?%d)%%") -- (\d?\d?\d)\%)
    return tonumber(string.format("% 3d", volume_level))
end

local function get_volume_async(device, callback)
    device = device or default_device
    spawn.easy_async(get_volume_cmd(device), function(stdout)
        callback(get_volume_from_cmd_output(stdout))
    end)
end

local function get_box(args)
    if w == nil then
        w = wibox {}
    end
    local box_width = args.width or default_width
    local box_height = args.height or default_height

    w.bg = theme.bg_systray .. '99'
    w.fg = '#ffffff'
    w.max_widget_size = 500
    w.ontop = true
    w.type = 'notification'

    w.height = box_height
    w.width = box_width
    w.x = args.x
    w.y = args.y
    w.shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 8)
    end
    -- w:set_bg('#66666633')
    return w
end

local function stop_timer()
    if timer ~= nil then
        timer:stop()
    end
end

local function hide()
    stop_timer()
    w.visible = false
end

local function get_volume_icon(volume)
    if volume == nil then
        return 'volume-x.svg'
    elseif volume < 25 then
        return 'volume.svg'
    elseif volume < 50 then
        return 'volume-1.svg'
    else
        return 'volume-2.svg'
    end
end

local function launch(args)
    stop_timer()

    local screen = awful.screen.focused()
    local screen_width = screen.geometry.width
    local screen_height = screen.geometry.height

    local box_size = prc2pix(11, { screen = screen })
    args.width = args.width or box_size
    args.height = args.height or box_size
    args.x = args.x or screen_width / 2 - args.width / 2
    args.y = args.y or screen_height / 1.3 - args.height / 2

    local box = get_box(args)

    local seconds = args.seconds or 1

    get_volume_async(default_device, function(volume)
        if (volume ~= nil) then
            last_known_volume = volume
        end

        local volume_icon = get_volume_icon(volume)

        local box_margin = prc2pix(1.2, { screen = screen })

        local function get_volume_bar(vol, color)
            local height = prc2pix(0.6, { screen = screen })
            local width = (box.width - box_margin * 2) * (vol or 0)/100
            return shapes.pill(color, height, width)
        end

        box:setup {
            {
                -- Icon
                first = wibox.widget{
                    widget = wibox.widget.imagebox,
                    image = icons_path .. volume_icon,
                    halign  = 'center',
                    bg = beautiful.bg_normal,
                    upscale = true,
                    downscale = true,
                    forced_height = prc2pix(6.5, { screen = screen }),
                    stylesheet = 'svg { stroke: '.. beautiful.fg_normal ..'; }',
                },
                -- Volume bar
                third = wibox.widget{
                    widget = wibox.widget.imagebox,
                    image = volume ~= nil and
                        get_volume_bar(volume, beautiful.primary_light) or
                        get_volume_bar(last_known_volume, beautiful.primary_light..'33'),
                    halign = 'left',
                    resize = false,
                },
                align = 'center',
                layout = wibox.layout.align.vertical
            },
            top = box_margin,
            left = box_margin,
            right = box_margin,
            bottom = box_margin,
            widget = wibox.container.margin
        }
        box.visible = true
        timer = gears.timer.start_new(seconds, function()
            hide()
            return false
        end)
    end)
end


return {
    launch = launch,
    hide = hide,
}
