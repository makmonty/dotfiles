import { Gdk, Gtk } from 'ags/gtk4'
import { AudioPopup } from '../Audio/AudioPopup'

export function Audio({ gdkMonitor }: { gdkMonitor: Gdk.Monitor }) {
  let popup: Gtk.Widget | null = null
  return <button
    class="audio"
    onClicked={() => {
      if (popup) {
        popup.destroy()
        popup = null
      } else {
        popup = AudioPopup(gdkMonitor)
      }
    }}
    label="audio"
  />
}
