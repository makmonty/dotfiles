--
-- WINDOW RULES
--

hl.window_rule({ float = true, match = { title = "wlogout" } })
hl.window_rule({ float = true, match = { class = "xdg-desktop-portal-*" } })
hl.window_rule({ rounding = false, match = { fullscreen = true } })

-- Flameshot
hl.window_rule({ no_anim = true, match = { class = "^(flameshot)$" } })
hl.window_rule({ float = true, match = { class = "^(flameshot)$" } })
hl.window_rule({ no_initial_focus = true, match = { class = "^(flameshot)$" } })
hl.window_rule({ move = { 0, 0 }, match = { class = "^(flameshot)$" } })
hl.window_rule({ suppress_event = "fullscreen", match = { class = "^(flameshot)$" } })
hl.window_rule({ stay_focused = true, match = { class = "^(flameshot)$" } })
hl.window_rule({ border_size = 0, match = { class = "^(flameshot)$" } })
hl.window_rule({ pin = true, match = { class = "^(flameshot)$" } })
hl.window_rule({ monitor = 0, match = { class = "^(flameshot)$" } })

--
-- LAYER RULES
--

hl.layer_rule({ blur = true, match = { namespace = "launcher" } })
hl.layer_rule({ blur = true, match = { namespace = "session-popup" } })
hl.layer_rule({ blur = true, match = { namespace = "notifications" } })
hl.layer_rule({ blur = true, match = { namespace = "osd" } })
hl.layer_rule({ blur = true, match = { namespace = "vicinae" } })
hl.layer_rule({ ignore_alpha = 0, match = { namespace = "vicinae" } })
hl.layer_rule({ animation = "windowsMove 0", match = { namespace = "osd" } })
hl.layer_rule({ no_anim = true, match = { namespace = "osd" } })
hl.layer_rule({ blur = true, match = { namespace = "gtk-layer-shell" } })
hl.layer_rule({ ignore_alpha = 0.5, match = { namespace = "osd" } })
hl.layer_rule({ ignore_alpha = 0.5, match = { namespace = "gtk-layer-shell" } })
