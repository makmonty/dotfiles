import { App, Astal, Gdk, Gtk } from 'astal/gtk3'
import { Variable } from 'astal'
import { timeout } from 'astal/time'
import Notifd from 'gi://AstalNotifd'

const NOTIFICATION_DISPLAY_TIMEOUT = 2000

const notifd = Notifd.get_default()

const notifications = Variable<Notifd.Notification[]>([])

export function connectNotifications() {
  notifd.connect('notified', (_: any, id: string) => {
    const n: Notifd.Notification = notifd.get_notification(id);
    // console.log('app name', n.appName)
    // console.log('app icon', n.appIcon)
    // console.log('image', n.image)
    const items = [...notifications.get(), n];
    notifications.set(items);
    timeout(NOTIFICATION_DISPLAY_TIMEOUT, () => {
      const newItems = [...notifications.get()];
      const index = newItems.findIndex(item => item.id === n.id);
      newItems.splice(index, 1);
      notifications.set(newItems);
    });
  })
}

export function NotificationBox({notification}: {notification: Notifd.Notification}) {
  return <box className="osd-popup notification">
    {notification.icon && <icon gIcon={notification.icon} />}
    {notification.image && <Gtk.Image gIcon={notification.image} />}
    <box vertical>
      <label label={notification.summary} />
      <label label={notification.body} />
    </box>
  </box>
}

export function Notifications(gdkMonitor: Gdk.Monitor) {
  return <window
    name="notifications"
    className="notifications"
    gdkmonitor={gdkMonitor}
    application={App}
    anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
  >
    <box vertical>
      {notifications(items => items.map(item =>
          <NotificationBox notification={item} />
        )
      )}
    </box>
  </window>
}
