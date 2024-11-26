import { App, Astal, Gdk, Gtk } from 'astal/gtk3'
import Binding from 'astal/binding'
import { Workspaces } from './Workspaces'
import { Systray } from './Systray'
import { Clock } from './Clock'
import { LogoutButton } from './Logout'

export function BarModule({ child, children }: {
  child?: JSX.Element | Binding<JSX.Element> | Binding<Array<JSX.Element>>
  children?: Array<JSX.Element> | Binding<Array<JSX.Element>>
}) {
  return <box className="bar-module">
    {child}
    {children}
  </box>
}

export function TopBar(gdkMonitor: Gdk.Monitor, monitorIndex: number) {
  return <window
    name="bar"
    className="bar"
    gdkmonitor={gdkMonitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={Astal.WindowAnchor.TOP
      | Astal.WindowAnchor.LEFT
      | Astal.WindowAnchor.RIGHT}
    application={App}
  >
    <centerbox
      className="bar-container"
      startWidget={
        <box>
          <BarModule>
            <Workspaces
              gdkMonitor={gdkMonitor}
              monitorIndex={monitorIndex}
            />
          </BarModule>
        </box>
      }
      endWidget={
        <box halign={Gtk.Align.END}>
          <BarModule>
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
