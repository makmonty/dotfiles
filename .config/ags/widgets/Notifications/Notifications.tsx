import { App, Astal, Gtk, Gdk, astalify, type ConstructProps } from 'astal/gtk3'
import Notifd from 'gi://AstalNotifd'

const notifd = Notifd.get_default()

notifd.connect('notified', (_, id) => {
    const n = notifd.get_notification(id)
    print(n.summary, n.body)
})

export function Notifications(gdkMonitor: Gdk.Monitor) {
  return <window
    name="notifications"
    class_name="notifications"
    gdkMonitor={gdkMonitor}
    application={App}
    anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
  >
  </window>
}
