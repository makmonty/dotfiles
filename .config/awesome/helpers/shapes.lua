local lgi = require("lgi")
local gcolor = require("gears.color")
local cairo = lgi.cairo
local math = math
local rad = math.rad

local function hex2rgb(color)
    return gcolor.parse_color(color)
end

local function rounded_rect(cr, args)
    local tl = args.tl or 0
    local bl = args.bl or 0
    local br = args.br or 0
    local tr = args.tr or 0
    local width = args.width
    local height = args.height
    local offset_x = args.offset_x or 0
    local offset_y = args.offset_y or 0

    -- Origin (0,0) is at the top left
    -- Angles go clockwise. 0 is pointing right
    cr:new_sub_path()
    cr:arc(width - tl + offset_x, tl + offset_y, tl, rad(-90), rad(0))
    cr:arc(width - bl + offset_x, height - bl + offset_y, bl, rad(0), rad(90))
    cr:arc(br + offset_x, height - br + offset_y, br, rad(90), rad(180))
    cr:arc(tr + offset_x, tr + offset_y, tr, rad(180), rad(270))
    cr:close_path()
end

-- Returns a circle of the specified size filled with the specified color
local function circle_filled(color, diameter, margins)
    color = color or "#fefefa"
    margins = margins or 0
    local surface = cairo.ImageSurface.create("ARGB32", diameter + margins*2, diameter + margins*2)
    local cr = cairo.Context.create(surface)
    cr:arc(diameter / 2 + margins, diameter / 2 + margins, diameter / 2, rad(0), rad(360))
    cr:set_source_rgba(hex2rgb(color))
    cr.antialias = cairo.Antialias.BEST
    cr:fill()

    return surface
end

local function pill(color, height, width, border_width, border_color)
    color = color or "#fefefa"
    -- margins = margins or 0
    border_width = border_width or 0
    border_color = border_color or "#000000"
    local radius = height/2

    local surface = cairo.ImageSurface.create("ARGB32", width, height)
    local cr = cairo.Context.create(surface)
    cr.antialias = cairo.Antialias.BEST

    -- The fill
    rounded_rect(cr, {
        tl = radius, tr = radius, bl = radius, br = radius,
        height = height,
        width = width,
    })
    cr:set_source_rgba(hex2rgb(color))
    cr.antialias = cairo.Antialias.BEST
    cr:fill_preserve()

    -- The stroke
    if border_width > 0 then
        local border_radius = radius - border_width/2
        rounded_rect(cr, {
            tl = border_radius, tr = border_radius, bl = radius, br = radius,
            height = height - border_width,
            width = width - border_width,
            offset_x = border_width/2,
            offset_y = border_width/2,
        })
        cr:set_source_rgba(hex2rgb(border_color))
        cr:set_line_width(border_width)
        cr:stroke()
    end

    return surface
end

local function circle_empty(diameter, margins, borderWidth, borderColor)
    margins = margins or 0
    borderWidth = borderWidth or 0
    borderColor = borderColor or "#ffffff"
    local surface = cairo.ImageSurface.create("ARGB32", diameter + margins*2, diameter + margins*2)
    local cr = cairo.Context.create(surface)
    cr:set_line_width(borderWidth)
    cr:arc(diameter / 2 + margins, diameter / 2 + margins, diameter / 2, rad(0), rad(360))
    cr:set_source_rgba(hex2rgb(borderColor))
    cr.antialias = cairo.Antialias.BEST
    cr:stroke()
    return surface
end

return {
    rounded_rect = rounded_rect,
    circle_filled = circle_filled,
    circle_empty = circle_empty,
    pill = pill,
}
