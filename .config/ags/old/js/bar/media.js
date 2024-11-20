import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

export const Media = () => Widget.Box({
  className: 'media bar-module',
  setup: self => self.hook(
    Mpris,
    self => {
      const mpris = Mpris.getPlayer('');
      // mpris player can be undefined
      self.toggleClassName('not-playing', !mpris)
    }
  ),
  children: [
    Widget.Button({
      child: Widget.Label({label: '\udb81\udcab'}),
    }),
    Widget.Button({
      child: Widget.Label({
        label: '\udb81\udc0a',
        setup: self => self.hook(
          Mpris,
          self => {
            const mpris = Mpris.getPlayer('');
            if (mpris) {
              if (mpris.playBackStatus === 'Playing')
                self.label = '\uf04c';
              else
                self.label = '\udb81\udc0a';
            }
          }
        )
      }),
      onPrimaryClick: () => Mpris.getPlayer('')?.playPause(),
    }),
    Widget.Button({
      child: Widget.Label({label: '\udb81\udcac'}),
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
