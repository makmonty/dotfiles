import GObject from 'gi://GObject'
import { App, Astal, Gtk, Gdk, astalify, type ConstructProps } from 'astal/gtk3'

class GtkCalendar extends astalify(Gtk.Calendar) {
  static { GObject.registerClass(this) }

  constructor(props: ConstructProps<
    GtkCalendar,
    Gtk.Calendar.ConstructorProps
  >) {
    super(props as any)
  }
}

export function CalendarPopup(gdkMonitor: Gdk.Monitor) {
  return <window
    name="calendar-popup"
    gdkmonitor={gdkMonitor}
    anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
    // margins=[0, 0],
    keymode={Astal.Keymode.ON_DEMAND}
    className="calendar-popup"
    application={App}
    // layer="overlay",
    // hpack="fill",
    // vpack="fill",
    setup={(self: Astal.Window) => self.connect('key-press-event', (_: any, event: Gdk.Event) => {
      if (event.get_keycode()[1] === 9) {
        self.destroy()
      }
    })}
  >
    <box
      hpack="center"
      vpack="center"
      className="calendar-container"
    >
      <GtkCalendar
        showDayNames={true}
        showHeading={true}
      />
    </box>
  </window>
}
