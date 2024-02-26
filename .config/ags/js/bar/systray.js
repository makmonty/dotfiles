import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

export const SysTray = () => Widget.Box({
  className: 'systray bar-module',
  setup: self => self.hook(
    SystemTray,
    self => {
      self.children = SystemTray.items.map(item => Widget.Button({
        vpack: 'center',
        child: Widget.Icon({
          setup: self => self.bind('icon', item, 'icon'),
        }),
        onPrimaryClick: (_, event) => item.activate(event),
        onSecondaryClick: (_, event) => item.openMenu(event),
        setup: self => self.bind('tooltip-markup', item, 'tooltip-markup'),
      }));
    }
  ),
});

