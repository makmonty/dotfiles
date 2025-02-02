import Battery from 'gi://AstalBattery'
import { bind } from 'astal'
import { Variable } from 'astal'

const battery = Battery.get_default()

export function BatteryIcon() {
  return <box
    className="battery bar-button"
    visible={battery.get_is_present()}
  >
    {bind(battery, 'percentage').as(percentage => {
      return <icon
        className=""
        icon={battery.batteryIconName}
        // setup={self => {
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
    })}
  </box>
}
