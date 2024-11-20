import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { BatteryLabel } from './battery.js';
import { Volume } from './volume.js';

export const SysTray = (options) => Widget.Box({
  className: 'systray bar-module',
  setup: self => self.hook(
    SystemTray,
    self => {
      self.children = [
        Volume(options),
        BatteryLabel(options),
        ...SystemTray.items.map(item => Widget.Button({
          className: 'bar-button',
          vpack: 'center',
          child: Widget.Icon({
            setup: self => self.bind('icon', item, 'icon'),
          }),
          onPrimaryClick: (_, event) => item.activate(event),
          onSecondaryClick: (_, event) => item.openMenu(event),
          setup: self => self.bind('tooltip-markup', item, 'tooltip-markup'),
        }))
      ];
    }
  ),
});
