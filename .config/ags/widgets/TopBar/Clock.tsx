import { Astal, Gdk, Gtk } from 'astal/gtk3'
import { Variable } from 'astal'
import { CalendarPopup } from '../Calendar/CalendarPopup'

const systemDate = Variable('').poll(1000, ['date', '+%a %e %b, %H:%M:%S'])

export function Clock({ gdkMonitor }: { gdkMonitor: Gdk.Monitor }) {
  return <button
    className="clock"
    onClick={(_, event: Gdk.Event) => {
      if (event.button === Astal.MouseButton.PRIMARY) {
        CalendarPopup(gdkMonitor)
      }
    }}
  >
    {systemDate((value) =>
      <label
        className="clock-label"
        halign={Gtk.Align.START}
        maxWidthChars="24"
        label={value}
      />
    )}
  </button>
}
