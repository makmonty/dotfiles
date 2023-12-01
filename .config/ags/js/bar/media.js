import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

import { ICONS_PATH } from '../constants.js';

export const Media = () => Widget.Box({
  className: 'media',
  connections: [[Mpris, self => {
    const mpris = Mpris.getPlayer('');
    // mpris player can be undefined
    if (mpris)
      self.className = self.className.replace('not-playing', '')
    else
      self.className += ' not-playing'
  }]],
  children: [
    Widget.Button({
      child: Widget.Icon({icon: ICONS_PATH + '/skip-back.svg'}),
    }),
    Widget.Button({
      child: Widget.Icon({
        icon: ICONS_PATH + '/play.svg',
        connections: [[Mpris, self => {
          const mpris = Mpris.getPlayer('');
          if (mpris) {
            if (mpris.playBackStatus === 'Playing')
              self.icon = ICONS_PATH + '/pause.svg';
            else
              self.icon = ICONS_PATH + '/play.svg';
          }
        }]],
      }),
      onPrimaryClick: () => Mpris.getPlayer('')?.playPause(),
    }),
    Widget.Button({
      child: Widget.Icon({icon: ICONS_PATH + '/skip-forward.svg'}),
    }),
  ]
})
// const Media = () => Widget.Button({
//   className: 'media',
//   onPrimaryClick: () => Mpris.getPlayer('')?.playPause(),
//   onScrollUp: () => Mpris.getPlayer('')?.next(),
//   onScrollDown: () => Mpris.getPlayer('')?.previous(),
//   child: Widget.Label({
//     connections: [[Mpris, self => {
//       const mpris = Mpris.getPlayer('');
//       // mpris player can be undefined
//       if (mpris)
//         self.label = `${mpris.trackArtists.join(', ')} - ${mpris.trackTitle}`;
//       else
//         self.label = 'Nothing is playing';
//     }]],
//   }),
// });

