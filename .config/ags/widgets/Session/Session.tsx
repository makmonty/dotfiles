import { Astal, Gdk, Gtk } from 'ags/gtk4'
import App from 'ags/gtk4/app'
import { execAsync } from 'ags/process'
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
    class="session-popup"
    layer={Astal.Layer.OVERLAY}
    valign={Gtk.Align.FILL}
    // exclusivity={Astal.Exclusivity.IGNORE}
    halign={Gtk.Align.FILL}
    marginTop={-48} // Hack to cover the top bar
    application={App}
    // $={(self: Astal.Window) => self.connect('key-press-event', (_: any, event: Gdk.Event) => {
    //   if (event.get_keycode()[1] === 9) {
    //     closeAllSessionWindows()
    //   }
    // })}
  >
    <box
      orientation={Gtk.Orientation.VERTICAL}
      class="session-container"
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
            class="session-button"
            cursor={Gdk.Cursor.POINTER}
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
            // onHover={setLabel}
          >
            <label
              class="session-button-label"
              label={button.icon}
            />
          </button>
        })}
      </box>
      <label class="session-label" label="" />
    </box>
  </window>

  return sessionWindow
}
