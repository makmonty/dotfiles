import { App, Astal, Gdk, Gtk } from 'astal/gtk3'
import { AstalIO, Variable } from 'astal'
import Wp from 'gi://AstalWp'
import { timeout } from 'astal/time'
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

const volume = Variable(0);
const isMuted = Variable(false);
const speaker = Variable.derive([volume, isMuted], (vol, muted) => muted ? null : vol)
let volumeTimeout: AstalIO.Time | null;

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

  isMuted.set(audio?.get_default_speaker()?.mute || false);
  volume.set(audio?.get_default_speaker()?.volume || 0);

  if (!App.get_windows().some((w: Astal.Window) => w.name === 'volume-popup')) {
    App.get_monitors().map(VolumePopup);
  }

  volumeTimeout = timeout(VOLUME_DISPLAY_TIME, () => {
    App.get_windows().forEach((w: Astal.Window) => w.name === 'volume-popup' ? w.destroy() : null);
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
  return <box className="volume-icon-container" halign={Gtk.Align.CENTER}>
    {speaker(() => [
      <label
        className="volume-icon osd-icon"
        label={getIconForVolume(volume.get(), isMuted.get())}
        halign={Gtk.Align.START}
      />
    ])}
  </box>
}

export function VolumePopup(gdkMonitor: Gdk.Monitor) {
  volumePopup = <OsdPopup
    gdkMonitor={gdkMonitor}
    name="volume-popup"
    className="volume-popup"
  >
    <box
      className="volume-container"
      vertical={true}
      halign={Gtk.Align.CENTER}
    >
      <VolumeIcon />
      {speaker(() =>
        <OsdLevelBar
          disabled={isMuted.get()}
          value={volume.get()}
        />
      )}
    </box>
  </OsdPopup>

  return volumePopup;
}
