local theme = require("lua.theme")

-- See https://wiki.hyprland.org/Configuring/Variables/ for more
hl.config({
  general = {
    gaps_in = 4,
    gaps_out = { 0, 8, 8, 8 },
    border_size = 1,
    col = {
      active_border = "rgb(" .. theme.primary .. ")", -- rgb($green) 45deg
      inactive_border = "rgb(" .. theme.black .. ")",
    },
    resize_on_border = true,
    allow_tearing = true,

    layout = "dwindle",
  },
})
