import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import App from 'resource:///com/github/Aylur/ags/app.js';
import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js';

export const Clock = () => Widget.Button({
  className: 'clock',
  onPrimaryClick: () => App.toggleWindow('calendar-popup'),
  child: Widget.Label({
    className: 'clock-label',
    hpack: 'start',
    connections: [
      // this is bad practice, since exec() will block the main event loop
      // in the case of a simple date its not really a problem
      // [1000, self => self.label = exec('date "+%H:%M:%S %b %e."')],

      // this is what you should do
      [1000, self => execAsync(['date', '+%a %e %b, %H:%M:%S'])
        .then(date => self.label = date).catch(console.error)],
    ],
  })
});

