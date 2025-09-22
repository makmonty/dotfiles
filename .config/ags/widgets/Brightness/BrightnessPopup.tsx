import { App, Astal, Gdk, Gtk } from 'ags/gtk4'
import { AstalIO, Variable } from 'astal'
import { exec } from "astal/process"
import { timeout } from 'astal/time'
import { OsdPopup } from '../Osd/Popup';
import { OsdLevelBar } from '../Osd/LevelBar';

const BRIGHTNESS_DISPLAY_TIME = 1000;

const ICON_BRIGHTNESS_HIGH = '\uD83D\uDD06'
const ICON_BRIGHTNESS_LOW = '\uD83D\uDD05'

const brightness = Variable(0);
let brightnessTimeout: AstalIO.Time | null;
let brightnessPopup: Astal.Window | null = null

export const getIconForBrightness = (brightness: number) => {
  if (brightness > 0.5) {
    return ICON_BRIGHTNESS_HIGH;
  }
  return ICON_BRIGHTNESS_LOW;
}

export const getBrightness = () => {
  const max = exec('brightnessctl max');
  const current = exec('brightnessctl get');
  return parseFloat(current) / parseFloat(max);
}

export const showBrightnessPopup = () => {
  brightnessTimeout?.cancel();

  brightness.set(getBrightness());

  if (!App.get_windows().some((w: Astal.Window) => w.name === 'brightness-popup')) {
    App.get_monitors().map(BrightnessPopup);
  }

  brightnessTimeout = timeout(BRIGHTNESS_DISPLAY_TIME, () => {
    App.get_windows().forEach(w => w.name === 'brightness-popup' ? w.destroy() : null);
    brightnessTimeout = null;
  });
};
export const BrightnessIcon = () =>
  <label
    label={brightness((value) => getIconForBrightness(value))}
    xalign={0}
    hpack="center"
    class="brightness-icon osd-icon"
  />

export function BrightnessPopup(gdkMonitor: Gdk.Monitor) {
  brightnessPopup = <OsdPopup
    gdkMonitor={gdkMonitor}
    name="brightness-popup"
    class="osd-popup-brightness"
  >
    <box
      class="volume-container"
      orientation={Gtk.Orientation.VERTICAL}
      halign={Gtk.Align.CENTER}
    >
      <BrightnessIcon />
      {brightness((value) => <OsdLevelBar value={value} />)}
    </box>
  </OsdPopup>

  return brightnessPopup;
}
