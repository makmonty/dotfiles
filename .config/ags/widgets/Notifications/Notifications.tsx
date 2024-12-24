import { App, Astal, Gtk, Gdk, astalify, type ConstructProps } from 'astal/gtk3'
import { Variable } from 'astal'
import Notifd from 'gi://AstalNotifd'

const notifd = Notifd.get_default()

const notifications = Variable<Notification[]>([])

export function connectNotifications() {
  notifd.connect('notified', (_, id) => {
    const n: Notification = notifd.get_notification(id)
    const items = notifications.get()
    items.push(n)
    notifications.set(items)
  })
}

export function NotificationBox({notification}: {notification: Notification}) {
  return <box className="osd-popup notification">
    <label label={notification.title} />
    <label label={notification.body} />
  </box>
}

export function Notifications(gdkMonitor: Gdk.Monitor) {
  return <window
    name="notifications"
    className="notifications"
    gdkMonitor={gdkMonitor}
    application={App}
    anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
  >
    {notifications(items =>
      items.map(item =>
        <NotificationBox notification={item} />
      )
    )}
  </window>
}
