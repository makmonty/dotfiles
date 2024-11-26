import { App, Astal, Gdk, Gtk } from 'astal/gtk3'
import { AstalIO, Variable } from "astal"
import Wp from "gi://AstalWp"
import { timeout } from "astal/time"
import { Popup } from "../Popup/Popup";

const audio = Wp.get_default()?.audio

const VOLUME_DISPLAY_TIME = 1000;

const ICON_VOLUME_HIGH = '\udb81\udd7e';
const ICON_VOLUME_MEDIUM = '\udb81\udd80';
const ICON_VOLUME_LOW = '\udb81\udd7f';
const ICON_VOLUME_MUTED = '\udb81\udf5f';

// tuples of [string, Widget]
// ['101', Widget.Icon('audio-volume-overamplified-symbolic')],
// ['67', Widget.Icon('audio-volume-high-symbolic')],
// ['34', Widget.Icon('audio-volume-medium-symbolic')],
// ['1', Widget.Icon('audio-volume-low-symbolic')],
// ['0', Widget.Icon('audio-volume-muted-symbolic')],

const volume = Variable(0);
const isMuted = Variable(false);
let volumeTimeout: AstalIO.Time | null;

export const getIconForVolume = (volume: number, isMuted: boolean) => {
  if (isMuted) {
    return ICON_VOLUME_MUTED;
  } else if (volume > 0.66) {
    return ICON_VOLUME_HIGH;
  } else if(volume > 0.33) {
    return ICON_VOLUME_MEDIUM;
  } else if(volume > 0) {
    return ICON_VOLUME_LOW;
  }
  return ICON_VOLUME_MUTED;
}

export const showVolumePopup = () => {
  volumeTimeout?.cancel();

  isMuted.set(audio?.get_default_speaker()?.mute || false);
  volume.set(audio?.get_default_speaker()?.volume || 0);

  if (!App.get_window('volume-popup')) {
    App.get_monitors().map(VolumePopup);
  }

  volumeTimeout = timeout(VOLUME_DISPLAY_TIME, () => {
    // get_windows() is showing duplicated windows,
    // so I have to run through all of them to destroy the right one
    App.get_windows().forEach(w => w.name === 'volume-popup' ? w.destroy() : null);
    volumeTimeout = null;
  });
};

export function VolumeIcon() {
  return <box halign={Gtk.Align.CENTER}>
    {volume(vol =>
      <label
        className="volume-icon osd-icon"
        label={getIconForVolume(vol, isMuted.get())}
      />
    )}
  </box>
}

export function VolumePopup(gdkMonitor: Gdk.Monitor) {
  return <Popup
    gdkMonitor={gdkMonitor}
    name="volume-popup"
    className="osd-popup-volume"
  >
    <box
      className="volume-container osd-container"
      vertical={true}
      halign={Gtk.Align.CENTER}
    >
      <VolumeIcon />
      {volume(vol => <levelbar className="volume-bar osd-bar" value={vol} />)}
    </box>
  </Popup>
}


// export const volumePopup = Widget.Window({
//   name: 'osd-popup-volume',
//   visible: false,
//   className: 'osd-popup-volume osd-popup',
//   layer: 'overlay',
//   anchor: ['bottom'],
//   margins: [0, 0, 128, 0],
//   child: Widget.Box({
//     className: 'volume-container osd-container',
//     vertical: true,
//     children: [
//       volumeIcon(),
//       Widget.ProgressBar({
//         className: 'volume-bar osd-bar',
//         setup: self => self.hook(volume, widget => {
//           widget.toggleClassName('muted', !!isMuted.value)
//           widget.value = parseFloat(volume.value);
//         }),
//       }),
//     ],
//   }),
// });
