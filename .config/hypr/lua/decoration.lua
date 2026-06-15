local theme = require("lua.theme")

hl.config({
  decoration = {
    -- See https://wiki.hyprland.org/Configuring/Variables/ for more

    rounding = 6,
    -- dim_inactive = true
    -- dim_strength = 0.3

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = "rgb(" .. theme.gray .. ")",
    },

    blur = {
      enabled = true,
      size = 6,
      passes = 3,
      special = true,
      new_optimizations = true,
      popups = true,
    },
  },
})
