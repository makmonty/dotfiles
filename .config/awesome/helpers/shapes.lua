local lgi = require("lgi")
local gcolor = require("gears.color")
local cairo = lgi.cairo
local math = math
local rad = math.rad

local function hex2rgb(color)
    return gcolor.parse_color(color)
end

-- Returns a shape function for a rounded rectangle with independently configurable corner radii
local function rounded_rect(args)
    local r1 = args.tl or 0
    local r2 = args.bl or 0
    local r3 = args.br or 0
    local r4 = args.tr or 0
    return function(cr, width, height)
        cr:new_sub_path()
        cr:arc(width - r1, r1, r1, rad(-90), rad(0))
        cr:arc(width - r2, height - r2, r2, rad(0), rad(90))
        cr:arc(r3, height - r3, r3, rad(90), rad(180))
        cr:arc(r4, r4, r4, rad(180), rad(270))
        cr:close_path()
    end
end

-- Returns a circle of the specified size filled with the specified color
local function circle_filled(color, diameter, margins, borderWidth, borderColor)
    color = color or "#fefefa"
    margins = margins or 0
    borderWidth = borderWidth or 0
    borderColor = borderColor or "#000000"
    local surface = cairo.ImageSurface.create("ARGB32", diameter + margins*2, diameter + margins*2)
    local cr = cairo.Context.create(surface)
    if borderWidth then
        cr:arc(diameter / 2 + margins, diameter / 2 + margins, borderWidth + diameter / 2, rad(0), rad(360))
        cr:set_source_rgba(hex2rgb(borderColor))
        cr.antialias = cairo.Antialias.BEST
        cr:fill()
    end
    cr:arc(diameter / 2 + margins, diameter / 2 + margins, diameter / 2, rad(0), rad(360))
    cr:set_source_rgba(hex2rgb(color))
    cr.antialias = cairo.Antialias.BEST
    cr:fill()
    -- cr:arc(
    --     size / 2, size / 2, size / 2 - 0.5, rad(135), rad(270))
    -- cr:set_source_rgba(hex2rgb(darken(color, 25)))
    -- cr.line_width = 1
    -- cr:stroke()

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
}
