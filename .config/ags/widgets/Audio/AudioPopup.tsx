import {  Astal, Gdk } from 'astal/gtk3'
import { OsdPopup } from '../Osd/Popup'

export function AudioPopup(gdkMonitor: Gdk.Monitor) {
  return <OsdPopup
    name="audio-popup"
    className="audio-popup"
    gdkMonitor={gdkMonitor}
    anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
  >
    <box
      hpack="center"
      vpack="center"
      className="calendar-container"
    >
      <label label="probando" />
    </box>
  </OsdPopup>
}
