import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import Variable from 'resource:///com/github/Aylur/ags/variable.js';
import Service from 'resource:///com/github/Aylur/ags/service.js';

const VOLUME_DISPLAY_TIME = 1000;

const volume = Variable('0', {});
let volumeTimeout;

Audio.connect('speaker-changed', () => {
  volume.setValue(Audio.speaker.volume.toString());
});

export const volumePopup = Widget.Window({
  name: 'volume-popup',
  popup: true,
  visible: false,
  className: 'volume-popup',
  child: Widget.Box({
    className: 'volume-container',
    vertical: true,
    children: [
      Widget.Label({
        label: '🔊',
        className: 'label'
      }),
      Widget.ProgressBar({
        connections: [
          [volume, progress => {
            // console.log(progress);
            progress.value = parseFloat(volume.value);
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


