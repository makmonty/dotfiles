hl.bind(
  "SUPER + escape",
  hl.dsp.exec_cmd(
    "wlogout --buttons-per-row 6 -s --margin 140 --margin-top 430 --margin-bottom 430 --column-spacing 40"
  )
)

hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("kitty"))
-- hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("foot"))
-- hl.bind("ALT_L + SPACE", hl.dsp.exec_cmd("rofi -show drun"))
-- hl.bind("ALT_L + SPACE", hl.dsp.exec_cmd("ags request launcher"))
-- hl.bind("SUPER + R", hl.dsp.exec_cmd("rofi -show run"))
hl.bind("ALT + SPACE", hl.dsp.exec_cmd("vicinae toggle"))
-- hl.bind("ALT_L + SPACE", hl.dsp.exec_cmd("tofi-drun --drun-launch=true"))
-- hl.bind("SUPER + R", hl.dsp.exec_cmd("tofi-run | xargs hyprctl dispatch hl.dsp.exec_cmd("-"))
hl.bind("SUPER + Q", hl.dsp.window.close())
-- hl.bind("SUPER + M", exit,")
hl.bind("SUPER + F", hl.dsp.exec_cmd("thunar"))
hl.bind("SUPER + V", hl.dsp.window.float())
hl.bind("SUPER + P", hl.dsp.window.pseudo())
-- hl.bind("SUPER + J", togglesplit, # dwindle")
hl.bind("SUPER + B", hl.dsp.exec_cmd("pypr expose"))
-- workspace = special:exposed,gapsout:60,gapsin:30,bordersize:5,border:true,shadow:false

hl.bind("SUPER + l", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + h", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + k", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + j", hl.dsp.focus({ direction = "d" }))
hl.bind("SUPER + TAB", hl.dsp.window.cycle_next())
hl.bind("SUPER + SHIFT + TAB", hl.dsp.window.cycle_next({ next = "prev" }))

-- Maximize
hl.bind("ALT + RETURN", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

hl.bind("SUPER + 1", hl.dsp.focus({ workspace = "1" }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = "2" }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = "3" }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = "4" }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = "5" }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = "6" }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = "7" }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = "8" }))
hl.bind("SUPER + 9", hl.dsp.focus({ workspace = "9" }))
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = "10" }))
hl.bind("SUPER + s", hl.dsp.workspace.toggle_special())

hl.bind("SUPER + ALT + 1", hl.dsp.window.move({ workspace = "1" }))
hl.bind("SUPER + ALT + 2", hl.dsp.window.move({ workspace = "2" }))
hl.bind("SUPER + ALT + 3", hl.dsp.window.move({ workspace = "3" }))
hl.bind("SUPER + ALT + 4", hl.dsp.window.move({ workspace = "4" }))
hl.bind("SUPER + ALT + 5", hl.dsp.window.move({ workspace = "5" }))
hl.bind("SUPER + ALT + 6", hl.dsp.window.move({ workspace = "6" }))
hl.bind("SUPER + ALT + 7", hl.dsp.window.move({ workspace = "7" }))
hl.bind("SUPER + ALT + 8", hl.dsp.window.move({ workspace = "8" }))
hl.bind("SUPER + ALT + 9", hl.dsp.window.move({ workspace = "9" }))
hl.bind("SUPER + ALT + 0", hl.dsp.window.move({ workspace = "10" }))
hl.bind("SUPER + ALT + s", hl.dsp.window.move({ workspace = "special" }))

hl.bind("SUPER + ALT + right", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind("SUPER + ALT + left", hl.dsp.window.move({ workspace = "r-1" }))

-- Scroll through existing workspaces ith SUPER ++ scroll
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind("SUPER + right", hl.dsp.focus({ workspace = "r+1" }))
hl.bind("SUPER + left", hl.dsp.focus({ workspace = "r-1" }))
-- hl.bind("SUPER + up, overview:toggle")
-- hl.bind("SUPER + down, overview:toggle, all")

hl.bind("SUPER + mouse:272", hl.dsp.window.drag())
hl.bind("SUPER + mouse:273", hl.dsp.window.resize())

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })
hl.bind(
  "XF86AudioPlay",
  hl.dsp.exec_cmd("swayosd-client --playerctl play-pause -- playerctl play-pause"),
  { locked = true }
)
-- hl.bind(", XF86AudioMicMute, hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("amixer -D pulse sset Master toggle && ags request volume"))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("$HOME/.local/bin/screenshot"))
hl.bind("SUPER + code:60", hl.dsp.exec_cmd("emote"))

-- Brightness
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness raise"))

-- Lid close
-- bindl = ,switch:on:Lid Switch, hl.dsp.exec_cmd("systemctl suspend)

-- Game mode
hl.bind("SUPER + F1", hl.dsp.exec_cmd("~/.config/hypr/gamemode.sh"))

-- hycov

-- hl.bind("ALT,tab,hycov:toggleoverview")

-- hl.bind ("ey to toggle overview (force mode, not affected by `only_active_workspace` or `only_active_monitor`)")
-- hl.bind("ALT,grave,hycov:toggleoverview,forceall #grave key is the '~' key")

-- hl.bind ("ey to toggle overview (shows all windows in one monitor, not affected by `only_active_workspace` or `only_active_monitor`)")
-- hl.bind("ALT,g,hycov:toggleoverview,forceallinone")

-- The key binding for directional switch mode.
-- Calculate the window closest to the direction to switch focus.
-- This keybind is applicable not only to the overview, but also to the general layout.
-- hl.bind("ALT,left,hycov:movefocus,l")
-- hl.bind("ALT,right,hycov:movefocus,r")
-- hl.bind("ALT,up,hycov:movefocus,u")
-- hl.bind("ALT,down,hycov:movefocus,d")

-- if you want that focusmove can cross monitor, use this
-- hl.bind("ALT,left,hycov:movefocus,leftcross")
-- hl.bind("ALT,right,hycov:movefocus,rightcross")
-- hl.bind("ALT,up,hycov:movefocus,upcross")
-- hl.bind("ALT,down,hycov:movefocus,downcross")
