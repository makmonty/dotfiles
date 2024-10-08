import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js';

const sessionButtons = [
  {
    icon: '\udb80\udf3e',
    label: 'Bloquear',
    command: 'loginctl lock-session',
  },
  // {
  //   icon: '\udb81\udcb2',
  //   label: 'Hibernar',
  //   command: 'systemctl hibernate',
  // },
  {
    icon: '\udb80\udf43',
    label: 'Salir',
    // command: 'loginctl terminate-user $USER',
    command: 'hyprctl dispatch exit'
  },
  {
    icon: '\udb81\udc25',
    label: 'Apagar',
    command: 'systemctl poweroff',
  },
  {
    icon: '\udb82\udd04',
    label: 'Suspender',
    command: 'systemctl suspend',
  },
  {
    icon: '\udb81\udf09',
    label: 'Reiniciar',
    command: 'systemctl reboot',
  },
];

export const session = Widget.Window({
  name: 'session-popup',
  visible: false,
  anchor: ['top', 'bottom', 'left', 'right'],
  margins: [0, 0],
  keymode: 'on-demand',
  className: 'session-popup',
  layer: 'overlay',
  hpack: 'fill',
  vpack: 'fill',
  setup: self => self.keybind('Escape', () => App.closeWindow('session-popup')),
  child: Widget.Box({
    hpack: 'center',
    vpack: 'center',
    vertical: true,
    className: 'session-container',
    children: [
      Widget.Box({
        children: [
          ...sessionButtons.map(button => {
            const setLabel = (self) => {
              const label = self.parent.parent.children[1];
              label.label = button.label;
            }
            return Widget.Button({
              className: 'session-button',
              cursor: 'pointer',
              onClicked: () =>
                execAsync(['bash', '-c', button.command]),
              onHover: setLabel,
              child: Widget.Label({
                className: 'session-button-label',
                hpack: 'center',
                label: button.icon,
              }),
              setup: self => self.on('focus', setLabel),
            });
          }),
        ]
      }),
      Widget.Label({
        className: 'session-label',
        label: ''
      })
    ]
  })
});
