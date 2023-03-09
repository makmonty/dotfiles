local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local theme = require("theme")
local spawn = awful.spawn
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

local function launch(args)
    stop_timer()

    local box = get_box(args)
    local seconds = args.seconds or 1

    get_volume_async(default_device, function(volume)
        local volume_str
        local volume_icon
        if volume == nil then
            volume_str = 'Mute'
            volume_icon = 'volume-x.svg'
        else
            volume_str = tostring(volume)
            volume_icon = 'volume-2.svg'
            if volume == 0 then
                volume_icon = 'volume-x.svg'
            elseif volume < 33 then
                volume_icon = 'volume.svg'
            elseif volume < 66 then
                volume_icon = 'volume-1.svg'
            else
                volume_icon = 'volume-2.svg'
            end
        end
        local screen = awful.screen.focused()
        local screen_width = screen.geometry.width
        local screen_height = screen.geometry.height

        box.x = screen_width / 2 - box.width / 2
        box.y = screen_height / 1.5 - box.height / 2

        box:setup {
            {
                wibox.widget{
                    image = icons_path .. volume_icon,
                    halign  = 'center',
                    widget = wibox.widget.imagebox,
                    bg = '#ff0000'
                },
                wibox.widget{
                    text = tostring(volume_str),
                    align = "center",
                    font = theme.font_face .. " normal " .. "14",
                    widget = wibox.widget.textbox,
                },
                align = 'center',
                layout = wibox.layout.flex.vertical
            },
            top = 30,
            widget = wibox.container.margin
        }
        box.visible = true
        timer = gears.timer.start_new(seconds, function()
            hide()
            return false
        end)
        --timeout(function() box.visible = false end, seconds)
    end)
end


return {
    launch = launch,
    hide = hide,
}
