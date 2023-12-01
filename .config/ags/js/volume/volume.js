import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import Variable from 'resource:///com/github/Aylur/ags/variable.js';
import Service from 'resource:///com/github/Aylur/ags/service.js';

const VOLUME_DISPLAY_TIME = 1000;

const ICON_VOLUME_HIGH = 'volume-level-high-panel';
const ICON_VOLUME_MEDIUM = 'volume-level-medium-panel';
const ICON_VOLUME_LOW = 'volume-level-low-panel';
const ICON_VOLUME_MUTED = 'volume-level-muted-panel';

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

export const volumePopup = Widget.Window({
  name: 'volume-popup',
  popup: true,
  visible: false,
  className: 'volume-popup',
  layer: 'overlay',
  anchor: ['bottom'],
  margins: [0, 0, 128, 0],
  child: Widget.Box({
    className: 'volume-container',
    vertical: true,
    children: [
      // Widget.Label({
      //   label: '🔊',
      //   className: 'label'
      // }),
      Widget.Icon({
        icon: 'volume-level-high-panel',
        className: 'volume-label',
        connections: [
          [volume, icon => {
            icon.icon = getIconForVolume(volume.value, isMuted.value);
          }]
        ],
      }),
      Widget.ProgressBar({
        className: 'volume-bar',
        connections: [
          [volume, widget => {
            if (isMuted.value) {
              widget.className += ' muted';
            } else {
              widget.className = widget.className.replace('muted', '');
            }
            widget.value = parseFloat(volume.value);
          }]
        ],
      }),
    ]
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


