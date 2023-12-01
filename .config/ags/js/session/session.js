import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js';
import { ICONS_PATH } from '../constants.js';

const sessionButtons = [
  {
    icon: 'lock.svg',
    label: 'Bloquear',
    command: 'swaylock',
  },
  // {
  //   icon: 'moon.svg',
  //   label: 'Hibernar',
  //   command: 'systemctl hibernate',
  // },
  {
    icon: 'log-out.svg',
    label: 'Salir',
    command: 'loginctl terminate-user $USER',
  },
  {
    icon: 'power.svg',
    label: 'Apagar',
    command: 'systemctl poweroff',
  },
  {
    icon: 'moon.svg',
    label: 'Suspender',
    command: 'systemctl suspend',
  },
  {
    icon: 'refresh-cw.svg',
    label: 'Reiniciar',
    command: 'systemctl reboot',
  },
];

export const session = Widget.Window({
  name: 'session-popup',
  popup: true,
  visible: false,
  anchor: ['top', 'bottom', 'left', 'right'],
  margins: [0, 0],
  focusable: true,
  className: 'session-popup',
  layer: 'overlay',
  hpack: 'fill',
  vpack: 'fill',
  child: Widget.Box({
    hpack: 'center',
    vpack: 'center',
    className: 'session-container',
    children: sessionButtons.map(button =>
      Widget.Button({
        className: 'session-button',
        cursor: 'pointer',
        onPrimaryClick: () => {execAsync(button.command)},
        child: Widget.Icon({
          icon: ICONS_PATH + '/' + button.icon,
        }),
      })
    )
  }),
});
