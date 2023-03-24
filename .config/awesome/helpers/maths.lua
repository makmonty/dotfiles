local function prc2pix(percentage, options)
    local opts = {
        screen = options.screen or awful.screen.focused(),
        use_height = options.use_height or false,
        pixel_perfect = options.pixel_perfect == nil and true or options.pixel_perfect,
    }
    local reference = opts.use_height and opts.screen.geometry.height or opts.screen.geometry.width

    local pixels = reference * percentage/100
    return opts.pixel_perfect and math.floor(pixels + 0.5) or pixels
end

return {
    prc2pix = prc2pix,
}
