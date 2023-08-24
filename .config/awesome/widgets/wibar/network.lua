local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")
local strings = require("helpers.strings")
local spawn = awful.spawn

local icons_path = os.getenv("HOME") .. '/.config/awesome/awesome-buttons/icons/'
local wifi_icon = "wifi.svg"

local devices = {}
local ssids = {}

local popup = nil

local function get_devices_from_cmd_output(stdout)
    local lines = strings.split(stdout, "\r\n")
    local devs = {}

    for _, line in pairs(lines) do
        if line:find("Interface") then
            table.insert(devs, strings.trim(line):sub(10))
        end
    end
    return devs
end

local function get_ssids_from_cmd_output(stdout)
    local lines = strings.split(stdout, "\r\n")
    local ids = {}

    for _, line in pairs(lines) do
        if line:find("SSID:") then
            table.insert(ids, strings.trim(line):sub(6))
        end
    end

    return ids
end

local function get_devices(callback)
    local cmd = "iw dev"

    spawn.easy_async(cmd, function(stdout)
        callback(get_devices_from_cmd_output(stdout))
    end)
end

local function get_ssids(device, callback)
    local cmd = "sudo iw dev ".. device .." scan passive"

    spawn.easy_async(cmd, function(stdout)
        callback(get_ssids_from_cmd_output(stdout))
    end)
end

local function get_popup()
    local items = {}
    for _,ssid in pairs(ssids) do
        table.insert(items, {ssid, function() end, icons_path .. wifi_icon})
    end

    if popup == nil then
        popup = awful.menu({
            items = items,
            theme = {
                height = 30,
                width = 300
            }
        })
    end

    return popup
end

local function draw()
    local widget = wibox.widget{
        widget = wibox.widget.imagebox,
        image = icons_path .. wifi_icon,
        halign  = 'center',
        bg = beautiful.bg_normal,
        stylesheet = 'svg { stroke: '.. beautiful.fg_normal ..'; }',
    }

    get_devices(function(devs)
        devices = devs

        get_ssids(devices[1], function(ids)
            ssids = ids
        end)
    end)

    widget:connect_signal("button::press", function(_,_,_, button)
        if button == 1 then
            local menu = get_popup()
            menu:show()
        end
    end)
    return widget
end



return draw
