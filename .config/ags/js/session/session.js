import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js';

const sessionButtons = [
  {
    icon: '\udb80\udf3e',
    label: 'Bloquear',
    command: 'swaylock',
  },
  // {
  //   icon: '\udb81\udcb2',
  //   label: 'Hibernar',
  //   command: 'systemctl hibernate',
  // },
  {
    icon: '\udb80\udf43',
    label: 'Salir',
    command: 'loginctl terminate-user $USER',
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
    vertical: true,
    className: 'session-container',
    children: [
      Widget.Box({
        children: [
          ...sessionButtons.map(button =>
            Widget.Button({
              className: 'session-button',
              cursor: 'pointer',
              onClicked: () =>
                execAsync(['bash', '-c', button.command]),
              onHover: (self) => {
                const label = self.parent.parent.children[1];
                label.label = button.label;
              },
              child: Widget.Label({
                label: button.icon,
              }),
            })
          ),
        ]
      }),
      Widget.Label({
        className: 'session-label',
        label: ''
      })
    ]
  })
});
