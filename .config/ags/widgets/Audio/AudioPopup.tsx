import GObject from 'gi://GObject'
import { App, Astal, Gtk, Gdk, astalify, type ConstructProps } from 'astal/gtk3'
import { Popup } from '../Popup/Popup'

export function AudioPopup(gdkMonitor: Gdk.Monitor) {
  return <Popup
    name="audio-popup"
    className="audio-popup"
    gdkMonitor={gdkMonitor}
  >
    <box
      hpack="center"
      vpack="center"
      className="calendar-container"
    >
      <label label="probando" />
    </box>
  </Popup>
  return <window
    name="audio-popup"
    gdkmonitor={gdkMonitor}
    anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
    // margins=[0, 0],
    keymode={Astal.Keymode.ON_DEMAND}
    className="audio-popup"
    application={App}
    // layer="overlay",
    // hpack="fill",
    // vpack="fill",
    // setup={(self: Astal.Window) => self.connect('key-press-event', (_: any, event: Gdk.Event) => {
    //   if (event.get_keycode()[1] === 9) {
    //     self.destroy()
    //   }
    // })}
  >
  </window>
}
