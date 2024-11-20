import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Variable from 'resource:///com/github/Aylur/ags/variable.js';

const BRIGHTNESS_DISPLAY_TIME = 1000;

const ICON_BRIGHTNESS_HIGH = '\uD83D\uDD06'
const ICON_BRIGHTNESS_LOW = '\uD83D\uDD05'

const brightness = Variable('0', {});
let brightnessTimeout;

export const brightnessIcon = () => Widget.Label({
  label: ICON_BRIGHTNESS_HIGH,
  xalign: 0,
  hpack: 'center',
  className: 'brightness-icon osd-icon',
  setup: self => self.hook(brightness,  icon =>
    icon.label = getIconForBrightness(brightness.value)
  ),
});

export const brightnessPopup = Widget.Window({
  name: 'osd-popup-brightness',
  visible: false,
  className: 'osd-popup-brightness osd-popup',
  layer: 'overlay',
  anchor: ['bottom'],
  margins: [0, 0, 128, 0],
  child: Widget.Box({
    className: 'brightness-container osd-container',
    vertical: true,
    children: [
      brightnessIcon(),
      Widget.ProgressBar({
        className: 'brightness-bar osd-bar',
        setup: self => self.hook(brightness, widget => {
          widget.value = parseFloat(brightness.value);
        }),
      }),
    ],
  }),
});

export const getIconForBrightness = (brightness) => {
  if (brightness > 0.5) {
    return ICON_BRIGHTNESS_HIGH;
  }
  return ICON_BRIGHTNESS_LOW;
}

export const getBrightness = () => {
  const max = Utils.exec('brightnessctl max');
  const current = Utils.exec('brightnessctl get');
  return parseFloat(current) / parseFloat(max);
}

export const triggerBrightnessPopup = () => {
  if (brightnessTimeout) {
    brightnessTimeout.destroy();
  }
  const currentBrightness = getBrightness();
  brightness.setValue(currentBrightness.toString());

  App.openWindow('osd-popup-brightness');

  brightnessTimeout = setTimeout(() => {
    App.closeWindow('osd-popup-brightness');
    brightnessTimeout = null;
  }, BRIGHTNESS_DISPLAY_TIME);
};
