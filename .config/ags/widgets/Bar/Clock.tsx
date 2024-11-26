import { App, Astal, Gdk, Gtk } from 'astal/gtk3'
import { Variable } from 'astal'
import { CalendarPopup } from '../Calendar/CalendarPopup'

const time = Variable('').poll(1000, ['date', '+%a %e %b, %H:%M:%S'])

export function Clock({ gdkMonitor }: { gdkMonitor: Gdk.Monitor }) {
  return <button
    className="clock"
    onClick={(_, event: Gdk.Event) => {
      if (event.button === Astal.MouseButton.PRIMARY) {
        CalendarPopup(gdkMonitor)
      }
    }}
    // onPrimaryClick={() => App.toggleWindow('calendar-popup')}
  >
    {time((value) =>
      <label
        className="clock-label"
        halign={Gtk.Align.CENTER}
        maxWidthChars="24"
        label={value}
      />
    )}
  </button>
}
