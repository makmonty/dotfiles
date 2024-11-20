import Widget from 'resource:///com/github/Aylur/ags/widget.js';
const battery = await Service.import('battery');

export const BatteryLabel = () => Widget.Box({
  className: 'battery bar-button',
  setup: self => self.hook(
    battery,
    self => {
      self.visible = battery.available;
    }
  ),
  children: [
    Widget.Icon({
      className: '',
      setup: self => self.hook(
        battery,
        self => {
          if (battery.available) {
            let icon = 'battery-level';
            if (battery.charged) {
              icon += '-100-charged';
            } else {
              icon += `-${Math.floor(battery.percent / 10) * 10}`;
            }

            if (battery.charging) {
              icon += '-charging';
            }

            self.icon = icon + '-symbolic';

            self.toggleClassName('battery-charged', battery.charged);
            self.toggleClassName('battery-charging', battery.charging);
            self.toggleClassName('battery-danger', battery.percent <= 20);
          }
        }
      )
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
