local awful = require("awful")

-- Themes define colours, icons, font and wallpapers.
local theme_path = "/home/angel/.config/awesome/theme.lua"

-- This is used later as the default terminal and editor to run.
local terminal = "kitty" --"xfce4-terminal"
local editor = "nvim" -- os.getenv("EDITOR") or "nano"
local terminal_cmd = terminal .. " -e "
local editor_cmd = terminal_cmd .. editor
local file_explorer = terminal_cmd .. "nnn" -- "thunar"
local music_player = terminal_cmd .. "ncmpcpp"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
local modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

local colors = {
    red = "#f92672",
    green = "#a6e22e",
    yellow = "#e6db74",
    pink = "#ae81ff"
}

return {
    theme_path = theme_path,
    terminal = terminal,
    terminal_cmd = terminal_cmd,
    editor = editor,
    editor_cmd = editor_cmd,
    file_explorer = file_explorer,
    music_player = music_player,
    modkey = modkey,
    layouts = layouts,
    colors = colors
}
