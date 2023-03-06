local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local volume_widget = require("awesome-wm-widgets.volume-widget.volume")
local session_widget = require("awesome-wm-widgets-makmonty.logout-popup-widget.logout-popup")
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")

local wibar_height = 30
local wibar_margin = 5
local wibar_spacing = 10

-- Create a textclock widget with calendar
local mytextclock = wibox.widget.textclock()
local calendar = calendar_widget({
    placement = 'top_right'
})
mytextclock:connect_signal(
    "button::press",
    function(_, _, _, button)
        if button == 1 then calendar.toggle() end
    end
)
beautiful.systray_icon_spacing = wibar_spacing

-- Custom session widget
local mysessionwidget = wibox.widget {
    widget = wibox.widget.textbox,
    markup = "<b></b>"
}
mysessionwidget:connect_signal(
    "button::press",
    function(_, _, _, button)
        if button == 1 then awful.util.spawn("/home/angel/.config/rofi/bin/powermenu") end
    end
)

-- Create a system tray widget
local mysystray = wibox.widget.systray()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
                              if client.focus then
                                  client.focus:move_to_tag(t)
                              end
                          end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
                              if client.focus then
                                  client.focus:toggle_tag(t)
                              end
                          end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({ }, 1, function (c)
                             if c == client.focus then
                                 c.minimized = true
                             else
                                 c:emit_signal(
                                     "request::activate",
                                     "tasklist",
                                     {raise = true}
                                 )
                             end
                         end),
    awful.button({ }, 3, function()
                             awful.menu.client_list({ theme = { width = 250 } })
                         end),
    awful.button({ }, 4, function ()
                             awful.client.focus.byidx(1)
                         end),
    awful.button({ }, 5, function ()
                             awful.client.focus.byidx(-1)
                         end)
)


local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({
        position = "top",
        height = wibar_height,
        screen = s
    })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        spacing = wibar_spacing,
        nil,
        wibox.container.margin({
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                spacing = wibar_spacing,
                --mylauncher,
                s.mytaglist,
                s.mypromptbox,
            },
            s.mytasklist, -- Middle widget
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                spacing = wibar_spacing,
                mysystray,
                --mykeyboardlayout,
                volume_widget(),
                wibox.widget.systray(),
                mytextclock,
                s.mylayoutbox,
                session_widget.widget{
                    bg_color = "#00000033",
                    width = 1920,
                    height = 1080,
                    icon_size = 64,
                    icon_margin = 32,
                    hide_phrase = true
                },
                --mysessionwidget
            },
        }, wibar_margin, wibar_margin, wibar_margin, wibar_margin)
    }
end)
