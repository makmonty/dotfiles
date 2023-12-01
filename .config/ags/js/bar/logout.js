import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

import { ICONS_PATH } from '../constants.js';

export const Logout = () => Widget.Box({
  className: 'logout',
  children: [
    Widget.Button({
      child: Widget.Icon({
        icon: ICONS_PATH + '/power.svg'
      }),
      onPrimaryClick: () => App.toggleWindow('session-popup'),
    })
  ]
})
