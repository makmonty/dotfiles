import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js';
import { getIconForVolume, volumeIcon } from '../osd/volume.js';

export const Volume = () => Widget.Box({
  className: 'volume',
  // css: 'min-width: 180px',
  children: [
    Widget.Button({
      onPrimaryClick: () => execAsync('pavucontrol'),
      child: volumeIcon(),
      // Widget.Label({
      //   label: '',
      //   connections: [[Audio, self => {
      //     if (!Audio.speaker)
      //       return;
      //
      //     self.label = getIconForVolume(Audio.speaker.volume, Audio.speaker.stream.isMuted);
      //   }, 'speaker-changed']],
      // }),
    })
    // Widget.Slider({
    //   hexpand: true,
    //   drawValue: false,
    //   onChange: ({ value }) => Audio.speaker.volume = value,
    //   connections: [[Audio, self => {
    //     self.value = Audio.speaker?.volume || 0;
    //   }, 'speaker-changed']],
    // }),
  ],
});
