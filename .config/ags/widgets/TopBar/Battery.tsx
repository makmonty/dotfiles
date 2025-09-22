import { Gtk } from 'ags/gtk4'
import Battery from 'gi://AstalBattery'
import { createBinding, With } from 'ags'

const battery = Battery.get_default()

export function BatteryIcon() {
  const percentage = createBinding(battery, 'percentage');

  return <box
    class="battery bar-button"
    visible={battery.get_is_present()}
  >
    <With value={percentage}>
      {(percentage) => {
        return <image
          class=""
          iconName={battery.batteryIconName}
          // $={self => {
          //   if (battery.available) {
          //     let icon = 'battery-level';
          //     if (battery.charged) {
          //       icon += '-100-charged';
          //     } else {
          //       icon += `-${Math.floor(battery.percent / 10) * 10}`;
          //     }
          //
          //     if (battery.charging) {
          //       icon += '-charging';
          //     }
          //
          //     self.icon = icon + '-symbolic';
          //
          //     self.toggleClassName('battery-charged', battery.charged);
          //     self.toggleClassName('battery-charging', battery.charging);
          //     self.toggleClassName('battery-danger', battery.percent <= 20);
          //   }
          // }}
        />
      }}
    </With>
  </box>
}
