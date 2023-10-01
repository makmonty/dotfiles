const volume = ags.Variable('0', {});

ags.Service.Audio.instance.connect('speaker-changed', () => {
  const { instance } = ags.Service.Audio;
  volume.setValue(instance.speaker.volume.toString());
})

const volumePopup = ags.Widget.Window({
  name: 'volume-popup',
  // popup: true,
  className: 'volume-popup',
  child: ags.Widget.Box({
    className: 'volume-container',
    vertical: true,
    children: [
      ags.Widget.Label({
        label: '🔊',
        className: 'label'
      }),
      ags.Widget.ProgressBar({
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

export default {
    closeWindowDelay: {
        // 'volume-popup': 500, // milliseconds
    },
    notificationPopupTimeout: 5000, // milliseconds
    cacheNotificationActions: false,
    maxStreamVolume: 1.0, // float
    style: ags.App.configDir + '/style.css',
    windows: [
        // NOTE: the window will still render, if you don't pass it here
        // but if you don't, the window can't be toggled through ags.App or cli
        volumePopup,
    ],
};
