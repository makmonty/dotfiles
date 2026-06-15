hl.config({
  animations = {
    enabled = true,
  },
})

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("easeInOutSine", { type = "bezier", points = { { 0.37, 0 }, { 0.63, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 3, curve = "default" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, curve = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, curve = " default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, curve = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, curve = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, curve = "default" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 7, curve = "default", style = "slidevert" })
