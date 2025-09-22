import { Astal, Gdk, Gtk } from 'ags/gtk4'
import App from 'ags/gtk4/app'
import { Workspaces } from './Workspaces'
import { Systray } from './Systray'
import { Clock } from './Clock'
import { LogoutButton } from './Logout'
import { BatteryIcon } from './Battery'
import { Audio } from './Audio';

export function startBars() {
  const bars = new Map<Gdk.Monitor, Gtk.Widget>()

  App.get_monitors().forEach((gdkMonitor: Gdk.Monitor) => {
    bars.set(gdkMonitor, TopBar(gdkMonitor))
  })

  App.connect('monitor-added', (_: any, gdkMonitor: Gdk.Monitor) => {
    bars.set(gdkMonitor, TopBar(gdkMonitor))
  })
  App.connect('monitor-removed', (_: any, gdkMonitor: Gdk.Monitor) => {
    bars.get(gdkMonitor)?.destroy()
    bars.delete(gdkMonitor)
  })
}

export function BarModule({ child, children }: {
  child?: JSX.Element
  children?: Array<JSX.Element>
}) {
  return <box class="bar-module">
    {child}
    {children}
  </box>
}

export function TopBar({ gdkMonitor }: {gdkMonitor: Gdk.Monitor}) {
  return <window
    visible
    name="bar"
    application={App}
    class="bar"
    gdkmonitor={gdkMonitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={Astal.WindowAnchor.TOP
      | Astal.WindowAnchor.LEFT
      | Astal.WindowAnchor.RIGHT}
  >
    <centerbox
      class="bar-container"
      startWidget={
        <box>
          <BarModule>
            <Workspaces
              gdkMonitor={gdkMonitor}
            />
          </BarModule>
        </box>
      }
      endWidget={
        <box halign={Gtk.Align.END}>
          <BarModule>
            <Audio gdkMonitor={gdkMonitor} />
          </BarModule>

          <BarModule>
            <BatteryIcon />
            <Systray />
          </BarModule>

          <BarModule>
            <Clock gdkMonitor={gdkMonitor} />
            <LogoutButton />
          </BarModule>
        </box>
      }
    />
  </window>
}
