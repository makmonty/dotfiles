local autorunCommands =
{
	"xrandr --output HDMI-0 --left-of DP-3",
	"xsettingsd",
	"lxpolkit",
    "picom --experimental-backends --backend glx -b",
    "plank",
    "blueman-applet",
    "nextcloud",
    "dropbox",
    "xfce4-clipman"
}
local useNice = true

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
require("main.error-handling")
-- }}}

-- {{{ Variable definitions
RC = {}
RC.vars = require("main.user-variables")
-- Themes define colours, icons, font and wallpapers.
local theme = require("theme")
beautiful.init(RC.vars.theme_path)

-- Clients titlebar and decoration
if useNice then
    local nice = require("nice")
    nice {
        titlebar_items = {
            left = {"sticky", "ontop", "floating"},
            middle = "title",
            right = {"minimize", "maximize", "close"},
        },
        titlebar_font = theme.font,
        close_color = "#f92672",
        maximize_color = "#a6e22e",
        minimize_color = "#e6db74",
        ontop_color = "#ae81ff",
        sticky_color = "#ae81ff",
        floating_color = "#ae81ff"
    }
else
    client.connect_signal("request::titlebars", require('main.titlebar'))
end

-- This is used later as the default terminal and editor to run.
terminal = RC.vars.terminal
editor = RC.vars.editor
editor_cmd = RC.vars.editor_cmd

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = RC.vars.modkey

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = RC.vars.layouts
-- }}}

-- {{{ Menu
RC.menu = require("main.menu")

-- Create a launcher widget and a main menu
myawesomemenu = RC.menu.myawesomemenu
mymainmenu = RC.menu.mymainmenu
mylauncher = RC.menu.mylauncher
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
require('main.wibar')
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
require("bindings.globalkeys")
local clientbuttons = require("bindings.clientbuttons")
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA",  -- Firefox addon DownThemAll.
                "copyq",  -- Includes session name in class.
                "pinentry",
            },
            class = {
              "Arandr",
              "Blueman-manager",
              "Gpick",
              "Kruler",
              "MessageWin",  -- kalarm.
              "Sxiv",
              "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
              "Wpa_gui",
              "veromix",
              "xtightvncviewer"},

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
              "Event Tester",  -- xev.
            },
            role = {
              "AlarmWindow",  -- Thunderbird's calendar.
              "ConfigManager",  -- Thunderbird's about:config.
              "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    },

    -- Add titlebars to normal clients and dialogs
    {
        rule_any = {
            type = { "normal", "dialog" }
        },
        properties = { titlebars_enabled = true }
    },

    -- Plank
    {
        rule = { class = "Plank" },
        properties = {
            border_width = 0,
            ontop = true
        }
    },

    -- Nextcloud
    {
        rule = { class = "Nextcloud" },
        properties = {
            titlebars_enabled = false
        }
    }

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
--client.connect_signal("mouse::enter", function(c)
    --c:emit_signal("request::activate", "mouse_enter", {raise = false})
--end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

for comm = 1, #autorunCommands do
	awful.util.spawn(autorunCommands[comm])
end
