// https://github.com/Aylur/ags/tree/main/example/simple-bar
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

import { Media } from './media.js';
import { Workspaces } from './workspaces.js';
import { ClientTitle } from './client.js';
import { Clock } from './clock.js';
import { Volume } from './volume.js';
import { SysTray } from './systray.js';
import { Logout } from './logout.js';

// layout of the bar
const Left = () => Widget.Box({
  children: [
    Workspaces(),
  ],
});

const Center = () => Widget.Box({
  children: [
    ClientTitle(),
    // Notification(),
  ],
});

const Right = () => Widget.Box({
  className: 'bar-right',
  hpack: 'end',
  children: [
    Media(),
    Volume(),
    // BatteryLabel(),
    SysTray(),
    Clock(),
    Logout(),
  ],
});

export const topBar = ({ monitor } = {}) => Widget.Window({
  name: `bar-${monitor || 'default'}`, // name has to be unique
  className: 'bar',
  monitor,
  anchor: ['top', 'left', 'right'],
  exclusivity: 'exclusive',
  child: Widget.CenterBox({
    className: 'bar-container',
    startWidget: Left(),
    centerWidget: Center(),
    endWidget: Right(),
  }),
})
