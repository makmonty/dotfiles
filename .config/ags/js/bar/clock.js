import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import App from 'resource:///com/github/Aylur/ags/app.js';
import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js';

export const Clock = () => Widget.Button({
  className: 'clock bar-module',
  onPrimaryClick: () => App.toggleWindow('calendar-popup'),
  child: Widget.Label({
    className: 'clock-label',
    hpack: 'start',
    setup: self => self.poll(
      1000,
      () => execAsync(['date', '+%a %e %b, %H:%M:%S'])
        .then(date => self.label = date)
        .catch(console.error)
    ),
  })
});

