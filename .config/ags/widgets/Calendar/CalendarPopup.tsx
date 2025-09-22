import GObject from 'gi://GObject'
import { Astal, Gtk, Gdk, type ConstructProps } from 'ags/gtk4'
import App from 'ags/gtk4/app'

export function CalendarPopup(gdkMonitor: Gdk.Monitor) {
  return <window
    name="calendar-popup"
    gdkmonitor={gdkMonitor}
    anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
    // margins=[0, 0],
    keymode={Astal.Keymode.ON_DEMAND}
    class="calendar-popup"
    application={App}
    // layer="overlay",
    // hpack="fill",
    // vpack="fill",
    $={(self: Astal.Window) => self.connect('key-press-event', (_: any, event: Gdk.Event) => {
      if (event.get_keycode()[1] === 9) {
        self.destroy()
      }
    })}
  >
    <box
      hpack="center"
      vpack="center"
      class="calendar-container"
    >
      <Gtk.Calendar
        showDayNames={true}
        showHeading={true}
      />
    </box>
  </window>
}
