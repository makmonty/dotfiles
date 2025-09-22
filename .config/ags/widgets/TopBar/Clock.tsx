import { Astal, Gdk, Gtk } from 'ags/gtk4'
import { createPoll } from 'ags/time'
import { CalendarPopup } from '../Calendar/CalendarPopup'

const systemDate = createPoll(0, 1000, 'date "+%a %e %b, %H:%M:%S"')

export function Clock({ gdkMonitor }: { gdkMonitor: Gdk.Monitor }) {
  let popup: Gtk.Widget | null = null
  return <button
    class="clock"
    onClicked={() => {
        popup = CalendarPopup(gdkMonitor)
      }
    }
  >
      <label
        class="clock-label"
        halign={Gtk.Align.START}
        maxWidthChars="24"
        label={systemDate(value => value.toString())}
      />
  </button>
}
