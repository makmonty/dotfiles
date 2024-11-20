import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

export const Logout = () => Widget.Box({
  className: 'logout bar-module',
  children: [
    Widget.Button({
      child: Widget.Label({
        label: '\udb81\udc25'
      }),
      onPrimaryClick: () => App.toggleWindow('session-popup'),
    })
  ]
})
