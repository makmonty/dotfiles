import { Astal, Gdk, Gtk } from 'ags/gtk4'
import App from 'ags/gtk4/app'
import { createState, createComputed, With } from 'ags'
import Wp from 'gi://AstalWp'
import { timeout, Time } from 'ags/time'
import { OsdPopup } from '../Osd/Popup';
import { OsdLevelBar } from '../Osd/LevelBar';

const wp = Wp.get_default()
const audio = wp?.audio
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

const [volume, setVolume] = createState(0);
const [isMuted, setIsMuted] = createState(false);
const speaker = createComputed([volume, isMuted], (vol, muted) => muted ? null : vol)
let volumeTimeout: Time | null;

let volumePopup: Astal.Window | null = null

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

  setIsMuted(audio?.get_default_speaker()?.mute || false);
  setVolume(audio?.get_default_speaker()?.volume || 0);

  if (!App.get_windows().some((w: Gtk.Window) => w.name === 'volume-popup')) {
    App.get_monitors().map(VolumePopup);
  }

  volumeTimeout = timeout(VOLUME_DISPLAY_TIME, () => {
    App.get_windows().forEach((w: Gtk.Window) => w.name === 'volume-popup' ? w.destroy() : null);
    volumeTimeout = null;
  });

  // console.log('endpoints')
  // wp?.get_endpoints()?.forEach(ep => console.log(ep.name))
  // console.log('devices')
  // wp?.get_devices()?.forEach(d => console.log(d.get_device_type(), d.id, d.description))
  // console.log('audio.devices')
  // audio?.get_devices()?.forEach(d => console.log(d.get_device_type(), d.id, d.description))
  // console.log(Wp.DeviceType.AUDIO)
  // console.log(Wp.DeviceType.VIDEO)
};

export function VolumeIcon() {
  return <box class="volume-icon-container" halign={Gtk.Align.CENTER}>
    <With value={speaker}>
      {() => (
        <label
          class="volume-icon osd-icon"
          label={getIconForVolume(volume, isMuted)}
          halign={Gtk.Align.START}
        />
      )}
    </With>
  </box>
}

export function VolumePopup(gdkMonitor: Gdk.Monitor) {
  volumePopup = <OsdPopup
    gdkMonitor={gdkMonitor}
    name="volume-popup"
    className="volume-popup"
  >
    <box
      class="volume-container"
      orientation={Gtk.Orientation.VERTICAL}
      halign={Gtk.Align.CENTER}
    >
      <VolumeIcon />
    </box>
  </OsdPopup>

  return volumePopup;
}
