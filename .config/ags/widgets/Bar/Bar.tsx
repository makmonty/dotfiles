import { App, Astal, Gtk, Gdk } from 'astal/gtk3'
import css from './Bar.scss'
import { Workspaces } from './Workspaces'

export function Bar(gdkmonitor: Gdk.Monitor, monitorIndex: number) {
  return <window
    className="Bar"
    css={css}
    gdkmonitor={gdkmonitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={Astal.WindowAnchor.TOP
      | Astal.WindowAnchor.LEFT
      | Astal.WindowAnchor.RIGHT}
    application={App}>
    <centerbox>
      <Workspaces
        gdkMonitor={gdkmonitor}
        monitorIndex={monitorIndex}
      />
    </centerbox>
  </window>
}
