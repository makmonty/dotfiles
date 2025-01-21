import { App, Astal, Gdk, Gtk } from 'astal/gtk3'
import { execAsync } from 'astal'
import GObject from 'astal/gobject'

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

const closeAllSessionWindows = () => {
  App.get_windows().forEach(w => w.name === 'session-popup' ? w.destroy() : null);
}

export function Session(gdkMonitor: Gdk.Monitor) {
  const sessionWindow = <window
    name="session-popup"
    gdkmonitor={gdkMonitor}
    anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT}
    keymode={Astal.Keymode.ON_DEMAND}
    className="session-popup"
    layer={Astal.Layer.OVERLAY}
    valign={Gtk.Align.FILL}
    exclusivty={Astal.Exclusivity.IGNORE}
    halign={Gtk.Align.FILL}
    marginTop={-48} // Hack to cover the top bar
    application={App}
    fullscreen={true}
    setup={(self: Astal.Window) => self.connect('key-press-event', (_: any, event: Gdk.Event) => {
      if (event.get_keycode()[1] === 9) {
        closeAllSessionWindows()
      }
    })}
  >
    <box
      vertical={true}
      className="session-container"
      valign={Gtk.Align.CENTER}
      halign={Gtk.Align.CENTER}
    >
      <box>
        {sessionButtons.map(button => {
          const setLabel = (self: GObject.Object) => {
            const label = self.parent.parent.children[1];
            label.label = button.label;
          }
          return <button
            className="session-button"
            cursor="pointer"
            onClicked={() => {
              closeAllSessionWindows();
              switch(typeof button.command) {
                case 'string':
                  execAsync(['bash', '-c', button.command]);
                  break;
                case 'function':
                  button.command();
                  break;
              }
            }}
            onHover={setLabel}
          >
            <label
              className="session-button-label"
              label={button.icon}
            />
          </button>
        })}
      </box>
      <label className="session-label" label="" />
    </box>
  </window>

  return sessionWindow
}
