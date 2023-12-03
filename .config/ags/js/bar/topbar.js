// https://github.com/Aylur/ags/tree/main/example/simple-bar
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

import { Media } from './media.js';
import { Workspaces } from './workspaces.js';
import { ClientTitle } from './client.js';
import { Clock } from './clock.js';
import { Volume } from './volume.js';
import { SysTray } from './systray.js';
import { Logout } from './logout.js';
import { BatteryLabel } from './battery.js';

// layout of the bar
const Left = (options) => Widget.Box({
  children: [
    Workspaces(options),
  ],
});

const Center = (options) => Widget.Box({
  children: [
    ClientTitle(options),
    // Notification(options),
  ],
});

const Right = (options) => Widget.Box({
  className: 'bar-right',
  hpack: 'end',
  children: [
    Media(options),
    Volume(options),
    BatteryLabel(options),
    SysTray(options),
    Clock(options),
    Logout(options),
  ],
});

export const topBar = (options = {}) => {
  const { monitor } = options;
  return Widget.Window({
    name: `bar-${monitor.name || 'default'}`, // name has to be unique
    className: 'bar',
    monitor,
    anchor: ['top', 'left', 'right'],
    exclusivity: 'exclusive',
    child: Widget.CenterBox({
      className: 'bar-container',
      startWidget: Left(options),
      centerWidget: Center(options),
      endWidget: Right(options),
    }),
  });
}
