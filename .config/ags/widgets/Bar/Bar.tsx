import { App, Astal, Gdk, Gtk } from 'astal/gtk3'
import Binding from "astal/binding"
import { Workspaces } from './Workspaces'
import { Systray } from './Systray'

export function BarModule({ child, children }: {
  child?: JSX.Element | Binding<JSX.Element> | Binding<Array<JSX.Element>>
  children?: Array<JSX.Element> | Binding<Array<JSX.Element>>
}) {
  return <box className="bar-module">
    {child}
    {children}
  </box>
}

export function Bar(gdkmonitor: Gdk.Monitor, monitorIndex: number) {
  return <window
    className="bar"
    gdkmonitor={gdkmonitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={Astal.WindowAnchor.TOP
      | Astal.WindowAnchor.LEFT
      | Astal.WindowAnchor.RIGHT}
    application={App}>
    <centerbox
      className="bar-container"
      startWidget={
        <box>
          <BarModule>
            <Workspaces
              gdkMonitor={gdkmonitor}
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
        </box>
      }
    />
  </window>
}
