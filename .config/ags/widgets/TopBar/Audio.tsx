import { App, Astal, Gdk, Gtk } from 'astal/gtk3'
import { Variable } from 'astal'
import { AudioPopup } from '../Audio/AudioPopup'

export function Audio({ gdkMonitor }: { gdkMonitor: Gdk.Monitor }) {
  let popup: Gtk.Widget | null = null
  return <button
    className="audio"
    onClick={(_, event: Gdk.Event) => {
      if (event.button === Astal.MouseButton.PRIMARY) {
        if (popup) {
          popup.destroy()
          popup = null
        } else {
          popup = AudioPopup(gdkMonitor)
        }
      }
    }}
  >
    <label label="audio" />
  </button>
}
