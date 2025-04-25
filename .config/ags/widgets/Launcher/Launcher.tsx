import { bind, Variable } from 'astal'
import Apps from 'gi://AstalApps';
import Hyprland from 'gi://AstalHyprland';
import { App, Astal, Gdk, Gtk } from 'astal/gtk3';
import { OsdPopup } from '../Osd/Popup';

const MAX_LIST_SIZE = 10;

let launcherPopup: Astal.Window | null = null;

const filteredApplications = Variable<Array<Apps.Application>>([]);
const selected = Variable(0);

const hyprland = Hyprland.get_default()

export const showLauncherPopup = () => {
  resetSelected();

  if (!App.get_windows().some((w: Gtk.Window) => w.name === 'launcher-popup')) {
    const focusedMonitor = hyprland.get_focused_monitor()
    LauncherPopup(App.get_monitors()[focusedMonitor.id]);
  }
};

const closeLauncher = () => {
  App.get_windows().forEach((w: Gtk.Window) => w.name === 'launcher-popup' ? w.destroy() : null);
}

const search = (apps: Apps.Apps, query: string) => {
  resetSelected();

  const result: Array<Apps.Application> = [];
  if (query) {
    for (const app of apps.fuzzy_query(query)) {
      result.push(app);
    }
  }
  filteredApplications.set(result.slice(0, MAX_LIST_SIZE));
}

const launchSelectedApp = () => {
  launchApp(filteredApplications.get()[selected.get()]);
}

const launchApp = (app: Apps.Application) => {
  app.launch();
  closeLauncher();
}

const moveSelected = (amount: number) => {
  const current = selected.get();
  let newSelected = current + amount;
  const length = filteredApplications.get().length

  if (newSelected < 0) {
    newSelected = length + newSelected;
  }

  if (newSelected >= length) {
    newSelected = newSelected - length;
  }

  selected.set(newSelected);
}

const resetSelected = () => {
  selected.set(0)
}

export function LauncherPopup(gdkMonitor: Gdk.Monitor) {
  const apps = new Apps.Apps({
      nameMultiplier: 2,
      entryMultiplier: 0,
      executableMultiplier: 2,
  });

  launcherPopup = <OsdPopup
    name="launcher-popup"
    gdkMonitor={gdkMonitor}
    keyMode={Astal.Keymode.EXCLUSIVE}
    // keyMode={Astal.Keymode.ON_DEMAND}
    anchor={Astal.WindowAnchor.TOP}
    marginTop={400}
    className={bind(filteredApplications).as((value) => `launcher-popup ${!value.length ? 'empty' : ''}`)}
    setup={(self: Astal.Window) => self.connect('key-press-event', (_: any, event: Gdk.Event) => {
      const keyCode = event.get_keycode()[1]
      // Escape
      if (keyCode === 9) {
        closeLauncher()
      }
      // Up arrow
      if (keyCode === 111) {
        moveSelected(-1)
      }
      // Down arrow
      if (keyCode === 116) {
        moveSelected(1)
      }
    })}
  >
    <box
      vertical={true}
      className="launcher-container"
      hexpand={true}
    >
      <entry
        onChanged={(self: Gtk.Entry) => search(apps, self.text)}
        onActivate={() => launchSelectedApp()}
        hexpand={true}
      />
      <box
        vertical={true}
        className="launcher-app-list"
        hexpand={true}
      >
        {filteredApplications((apps) => apps.map((app, index) =>
          <box
            className={bind(selected).as((value: number) => `launcher-app-item ${index === value ? 'selected' : ''}`)}
            halign={Gtk.Align.LEFT}
            hexpand={true}
          >
            <icon icon={app.iconName} />
            <label label={app.name} halign={Gtk.Align.RIGHT} />
          </box>
        ))}
      </box>
    </box>
  </OsdPopup>

  return launcherPopup;
}
