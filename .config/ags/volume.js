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
            if (isMuted.value) {
              icon.icon = ICON_VOLUME_MUTED;
            } else if (volume.value > 0.66) {
              icon.icon = ICON_VOLUME_HIGH;
            } else if(volume.value > 0.33) {
              icon.icon = ICON_VOLUME_MEDIUM;
            } else if(volume.value > 0) {
              icon.icon = ICON_VOLUME_LOW;
            } else {
              icon.icon = ICON_VOLUME_MUTED;
            }
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


