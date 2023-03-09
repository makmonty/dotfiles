---------------------------
-- Default awesome skin --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local shapes = require("helpers.shapes")

local theme_name = require("main.user-variables").theme
local theme = require("themes." .. theme_name)

local function titlebar_button(color)
    return shapes.circle_filled(color, dpi(128), dpi(32))
end

local function titlebar_button_hover(color)
    return shapes.circle_filled(color, dpi(192), dpi(24))
end

local function titlebar_button_active(color)
    --return shapes.circle_empty(dpi(72), dpi(32), dpi(32), color)
    return titlebar_button(color)
end

local titlebar_close_button = titlebar_button(theme.danger)
local titlebar_close_button_hover = titlebar_button_hover(theme.danger)
local titlebar_minimize_button = titlebar_button(theme.warning)
local titlebar_minimize_button_hover = titlebar_button_hover(theme.warning)
local titlebar_maximize_button_inactive = titlebar_button(theme.success)
local titlebar_maximize_button_active = titlebar_button_active(theme.success)
local titlebar_maximize_button_hover = titlebar_button_hover(theme.success)
local titlebar_extra_button_active = titlebar_button_active(theme.info)
local titlebar_extra_button_inactive = titlebar_button(theme.primary)
local titlebar_extra_button_hover = titlebar_button_hover(theme.primary)

local skin = {}

skin.font_face = "sans"
skin.font_size = "10"
skin.font          = skin.font_face .. " " .. skin.font_size

skin.bg_normal     = theme.bg
skin.bg_focus      = theme.bg
skin.bg_urgent     = theme.danger
skin.bg_minimize   = theme.bg
skin.bg_systray    = theme.bg

skin.fg_normal     = theme.fg
skin.fg_focus      = theme.fg
skin.fg_urgent     = theme.fg
skin.fg_minimize   = theme.fg_faded

skin.useless_gap   = dpi(0)
skin.border_width  = 0 --dpi(1)
skin.border_normal = "#000000"
--skin.border_focus  = "#535d6c"
skin.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--skin.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
skin.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, skin.fg_normal
)
skin.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, skin.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
skin.menu_submenu_icon = themes_path.."default/submenu.png"
skin.menu_height = dpi(15)
skin.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--skin.bg_widget = "#cc0000"

-- Define the image to load
skin.titlebar_close_button_normal = titlebar_close_button --themes_path.."default/titlebar/close_normal.png"
skin.titlebar_close_button_focus = titlebar_close_button --themes_path.."default/titlebar/close_focus.png"
skin.titlebar_close_button_normal_hover = titlebar_close_button_hover
skin.titlebar_close_button_focus_hover = titlebar_close_button_hover

skin.titlebar_minimize_button_normal = titlebar_minimize_button --themes_path.."default/titlebar/minimize_normal.png"
skin.titlebar_minimize_button_focus = titlebar_minimize_button --themes_path.."default/titlebar/minimize_focus.png"
skin.titlebar_minimize_button_normal_hover = titlebar_minimize_button_hover
skin.titlebar_minimize_button_focus_hover = titlebar_minimize_button_hover

skin.titlebar_maximized_button_normal_inactive = titlebar_maximize_button_inactive --themes_path.."default/titlebar/maximized_normal_inactive.png"
skin.titlebar_maximized_button_focus_inactive = titlebar_maximize_button_inactive --themes_path.."default/titlebar/maximized_focus_inactive.png"
skin.titlebar_maximized_button_normal_active = titlebar_maximize_button_active --themes_path.."default/titlebar/maximized_normal_active.png"
skin.titlebar_maximized_button_focus_active = titlebar_maximize_button_active --themes_path.."default/titlebar/maximized_focus_active.png"
skin.titlebar_maximized_button_normal_inactive_hover = titlebar_maximize_button_hover
skin.titlebar_maximized_button_focus_inactive_hover = titlebar_maximize_button_hover
skin.titlebar_maximized_button_normal_active_hover = titlebar_maximize_button_hover
skin.titlebar_maximized_button_focus_active_hover = titlebar_maximize_button_hover

skin.titlebar_ontop_button_normal_inactive = titlebar_extra_button_inactive --themes_path.."default/titlebar/ontop_normal_inactive.png"
skin.titlebar_ontop_button_focus_inactive = titlebar_extra_button_inactive --themes_path.."default/titlebar/ontop_focus_inactive.png"
skin.titlebar_ontop_button_normal_active = titlebar_extra_button_active --themes_path.."default/titlebar/ontop_normal_active.png"
skin.titlebar_ontop_button_focus_active = titlebar_extra_button_active --themes_path.."default/titlebar/ontop_focus_active.png"
skin.titlebar_ontop_button_normal_inactive_hover = titlebar_extra_button_hover
skin.titlebar_ontop_button_focus_inactive_hover = titlebar_extra_button_hover
skin.titlebar_ontop_button_normal_active_hover = titlebar_extra_button_hover
skin.titlebar_ontop_button_focus_active_hover = titlebar_extra_button_hover

skin.titlebar_sticky_button_normal_inactive = titlebar_extra_button_inactive --themes_path.."default/titlebar/sticky_normal_inactive.png"
skin.titlebar_sticky_button_focus_inactive  = titlebar_extra_button_inactive --themes_path.."default/titlebar/sticky_focus_inactive.png"
skin.titlebar_sticky_button_normal_active = titlebar_extra_button_active --themes_path.."default/titlebar/sticky_normal_active.png"
skin.titlebar_sticky_button_focus_active  = titlebar_extra_button_active --themes_path.."default/titlebar/sticky_focus_active.png"
skin.titlebar_sticky_button_normal_inactive_hover = titlebar_extra_button_hover
skin.titlebar_sticky_button_focus_inactive_hover = titlebar_extra_button_hover
skin.titlebar_sticky_button_normal_active_hover = titlebar_extra_button_hover
skin.titlebar_sticky_button_focus_active_hover = titlebar_extra_button_hover

skin.titlebar_floating_button_normal_inactive = titlebar_extra_button_inactive --themes_path.."default/titlebar/floating_normal_inactive.png"
skin.titlebar_floating_button_focus_inactive = titlebar_extra_button_inactive --themes_path.."default/titlebar/floating_focus_inactive.png"
skin.titlebar_floating_button_normal_active = titlebar_extra_button_active --themes_path.."default/titlebar/floating_normal_active.png"
skin.titlebar_floating_button_focus_active = titlebar_extra_button_active --themes_path.."default/titlebar/floating_focus_active.png"
skin.titlebar_floating_button_normal_inactive_hover = titlebar_extra_button_hover
skin.titlebar_floating_button_focus_inactive_hover = titlebar_extra_button_hover
skin.titlebar_floating_button_normal_active_hover = titlebar_extra_button_hover
skin.titlebar_floating_button_focus_active_hover = titlebar_extra_button_hover

skin.wallpaper = "/home/angel/Imágenes/Fondos/Paisajes/pexels-simon-berger-1323550.jpg"

-- You can use your own layout icons like this:
skin.layout_fairh = themes_path.."default/layouts/fairhw.png"
skin.layout_fairv = themes_path.."default/layouts/fairvw.png"
skin.layout_floating  = themes_path.."default/layouts/floatingw.png"
skin.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
skin.layout_max = themes_path.."default/layouts/maxw.png"
skin.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
skin.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
skin.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
skin.layout_tile = themes_path.."default/layouts/tilew.png"
skin.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
skin.layout_spiral  = themes_path.."default/layouts/spiralw.png"
skin.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
skin.layout_cornernw = themes_path.."default/layouts/cornernww.png"
skin.layout_cornerne = themes_path.."default/layouts/cornernew.png"
skin.layout_cornersw = themes_path.."default/layouts/cornersww.png"
skin.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
skin.awesome_icon = theme_assets.awesome_icon(
    skin.menu_height, skin.bg_focus, skin.fg_focus
)

-- Define the icon skin for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
skin.icon_theme = nil

return skin
