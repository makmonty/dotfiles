local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local theme = require("theme")
local beautiful = require("beautiful")
local shapes = require("helpers.shapes")
local spawn = awful.spawn
--local timeout = require("helpers.timer").timeout

local w
local default_width = 200
local default_height = 200
local icons_path = os.getenv("HOME") .. '/.config/awesome/awesome-buttons/icons/'

local timer = nil
local last_known_volume = 0

local default_device = 'pulse'

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
    if w then
        return w
    end
    local box_width = args.width or default_width
    local box_height = args.height or default_height

    w = wibox {
        bg = theme.bg_systray .. '99',
        fg = '#ffffff',
        max_widget_size = 500,
        ontop = true,
        type = 'notification',

        height = box_height,
        width = box_width,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 8)
        end,
    }
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
    elseif volume < 75 then
        return 'volume-1.svg'
    else
        return 'volume-2.svg'
    end
end

local function launch(args)
    stop_timer()

    local box = get_box(args)
    local seconds = args.seconds or 1

    get_volume_async(default_device, function(volume)
        if (volume ~= nil) then
            last_known_volume = volume
        end

        local volume_icon = get_volume_icon(volume)

        local screen = awful.screen.focused()
        local screen_width = screen.geometry.width
        local screen_height = screen.geometry.height

        box.x = screen_width / 2 - box.width / 2
        box.y = screen_height / 1.5 - box.height / 2

        local box_margin = 20
        local item_spacing = 40

        local function get_volume_bar(vol, color)
            return shapes.pill(color, 10, (box.width - box_margin * 2) * (vol or 0)/100)
        end

        box:setup {
            {
                wibox.widget{
                    widget = wibox.widget.imagebox,
                    image = icons_path .. volume_icon,
                    halign  = 'center',
                    bg = beautiful.bg_normal,
                    upscale = true,
                    downscale = true,
                    forced_height = 100,
                    stylesheet = 'svg { stroke: '.. beautiful.fg_normal ..'; }',
                },
                -- The volume as a bar
                wibox.widget{
                    widget = wibox.widget.imagebox,
                    image = volume ~= nil and
                        get_volume_bar(volume, beautiful.fg_normal) or
                        get_volume_bar(last_known_volume, beautiful.fg_normal ..'33'),
                    halign = 'left',
                    resize = false,
                },
                align = 'center',
                spacing = item_spacing,
                layout = wibox.layout.fixed.vertical
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
