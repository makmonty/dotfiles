import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';

const VOLUME_DISPLAY_TIME = 1000;

const volume = ags.Variable('0', {});
let volumeTimeout;

Audio.instance.connect('speaker-changed', () => {
  const { instance } = ags.Service.Audio;
  volume.setValue(instance.speaker.volume.toString());
});

export const volumePopup = Widget.Window({
  name: 'volume-popup',
  popup: true,
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

const triggerVolumePopup = () => {
  if (volumeTimeout) {
    volumeTimeout.destroy();
  }

  App.openWindow('volume-popup');

  volumeTimeout = setTimeout(() => {
    App.closeWindow('volume-popup');
    volumeTimeout = null;
  }, VOLUME_DISPLAY_TIME);
};

export const volumeTrigger = Widget.Window({
  name: 'volume-trigger',
  popup: true,
  className: 'volume-trigger',
  connections: [
    [App, (self, windowName, visible) => {
      if (windowName === 'volume-trigger' && visible) {
        App.closeWindow('volume-trigger');
        triggerVolumePopup();
      }
    }],
  ],
})

