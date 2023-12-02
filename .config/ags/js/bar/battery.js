import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

export const BatteryLabel = () => Widget.Box({
  className: 'battery',
  connections: [[Battery, self => self.visible = Battery.available]],
  children: [
    Widget.Icon({
      connections: [[Battery, self => {
        if (Battery.available)
          self.icon = `battery-level-${Math.floor(Battery.percent / 10) * 10}-symbolic`;
      }]],
    }),
    // Widget.ProgressBar({
    //   vpack: 'center',
    //   connections: [[Battery, self => {
    //     if (Battery.percent < 0)
    //       return;
    //
    //     self.fraction = Battery.percent / 100;
    //   }]],
    // }),
  ],
});
