import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import Variable from 'resource:///com/github/Aylur/ags/variable.js';

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

const volume = Variable('0', {});
const isMuted = Variable(false, {});
let volumeTimeout;

Audio.connect('speaker-changed', () => {
  isMuted.setValue(Audio.speaker.stream.isMuted);
  volume.setValue(Audio.speaker.volume.toString());
});

export const volumeIcon = () => Widget.Label({
  label: ICON_VOLUME_HIGH,
  xalign: 0,
  className: 'volume-icon',
  setup: self => self.hook(volume,  icon =>
    icon.label = getIconForVolume(volume.value, isMuted.value)
  ),
});

export const volumePopup = Widget.Window({
  name: 'volume-popup',
  visible: false,
  className: 'volume-popup',
  layer: 'overlay',
  anchor: ['bottom'],
  margins: [0, 0, 128, 0],
  child: Widget.Box({
    className: 'volume-container',
    vertical: true,
    children: [
      volumeIcon(),
      Widget.ProgressBar({
        className: 'volume-bar',
        setup: self => self.hook(volume, widget => {
          widget.toggleClassName('muted', !!isMuted.value)
          widget.value = parseFloat(volume.value);
        }),
      }),
    ],
  }),
});

export const getIconForVolume = (volume, isMuted) => {
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

export const triggerVolumePopup = () => {
  if (volumeTimeout) {
    volumeTimeout.destroy();
  }

  App.openWindow('volume-popup');

  volumeTimeout = setTimeout(() => {
    App.closeWindow('volume-popup');
    volumeTimeout = null;
  }, VOLUME_DISPLAY_TIME);
};
