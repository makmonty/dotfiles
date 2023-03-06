local double_click_event_handler = require("helpers.events").double_click_event_handler
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

-- Titlebar vars
local titlebar_height = 36 -- The titlebar is a padding-box
local titlebar_spacing = 6
local titlebar_margin_top = 6
local titlebar_margin_bottom = 6
local titlebar_margin_left = 6
local titlebar_margin_right = 6

return function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            --c.maximized_horizontal = false
            --c.maximized_vertical = false
            --c.maximized = false
            --c.fullscreen = false
            awful.mouse.client.move(c)

            -- Double click
            double_click_event_handler(function()
                c.floating = false
                c.maximized = not c.maximized
                --c.maximized_horizontal = true
                --c.maximized_vertical = true
            end)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            c.maximized_horizontal = false
            c.maximized_vertical = false
            c.maximized = false
            c.fullscreen = false
            awful.mouse.client.resize(c)
        end)
    )

    local titlebar = awful.titlebar(c, {
	    size = titlebar_height
    })

    titlebar:setup {
        {
            { -- Left
                -- awful.titlebar.widget.iconwidget(c),
                awful.titlebar.widget.floatingbutton(c),
                awful.titlebar.widget.stickybutton(c),
                awful.titlebar.widget.ontopbutton(c),
                layout = wibox.layout.fixed.horizontal,
                spacing = titlebar_spacing,
            },
            { -- Middle
                { -- Title
                    align = "center",
                    widget = awful.titlebar.widget.titlewidget(c)
                },
                buttons = buttons,
                layout = wibox.layout.flex.horizontal,
            },
            { -- Right
                awful.titlebar.widget.minimizebutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.closebutton(c),
                layout = wibox.layout.fixed.horizontal,
                spacing = titlebar_spacing,
            },
            layout = wibox.layout.align.horizontal,
        },
        left = titlebar_margin_left,
        right = titlebar_margin_right,
        top = titlebar_margin_top,
        bottom = titlebar_margin_bottom,
        widget = wibox.container.margin
    }
end
