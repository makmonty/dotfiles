import App from 'ags/gtk4/app'
import Apps from 'gi://AstalApps';
import Hyprland from 'gi://AstalHyprland';
import { createState, For, With } from 'ags';
import { Astal, Gdk, Gtk } from 'ags/gtk4';
import { OsdPopup } from '../Osd/Popup';

const MAX_LIST_SIZE = 10;

let launcherPopup: Astal.Window | null = null;

const hyprland = Hyprland.get_default()

export const showLauncherPopup = () => {
  if (!App.get_windows().some((w: Gtk.Window) => w.name === 'launcher-popup')) {
    const focusedMonitor = hyprland.get_focused_monitor()
    LauncherPopup(App.get_monitors()[focusedMonitor.id]);
  }
};

const closeLauncher = () => {
  App.get_windows().forEach((w: Gtk.Window) => w.name === 'launcher-popup' ? w.destroy() : null);
}


export function LauncherPopup(gdkMonitor: Gdk.Monitor) {
  const apps = new Apps.Apps({
      nameMultiplier: 2,
      entryMultiplier: 0,
      executableMultiplier: 2,
  });

  const [filteredApplications, setFilteredApplications] = createState<Array<Apps.Application>>([]);
  const [selected, setSelected] = createState(0);

  const resetSelected = () => {
    setSelected(0)
  }

  const search = (apps: Apps.Apps, query: string) => {
    resetSelected();

    const result: Array<Apps.Application> = [];
    if (query) {
      for (const app of apps.fuzzy_query(query)) {
        result.push(app);
      }
    }
    setFilteredApplications(result.slice(0, MAX_LIST_SIZE));
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

    setSelected(newSelected);
  }

  return <OsdPopup
    name="launcher-popup"
    gdkMonitor={gdkMonitor}
    keyMode={Astal.Keymode.EXCLUSIVE}
    // keyMode={Astal.Keymode.ON_DEMAND}
    anchor={Astal.WindowAnchor.TOP}
    marginTop={400}
    className={`launcher-popup ${!filteredApplications.length ? 'empty' : ''}`}
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
      orientation={Gtk.Orientation.VERTICAL}
      class="launcher-container"
      hexpand={true}
    >
      <entry
        onChanged={(self: Gtk.Entry) => search(apps, self.text)}
        onActivate={() => launchSelectedApp()}
        hexpand={true}
      />
      <box
        orientation={Gtk.Orientation.VERTICAL}
        class="launcher-app-list"
        hexpand={true}
      >
        {filteredApplications.get().map((app, index) =>
                <box
                  class={`launcher-app-item ${index === selected ? 'selected' : ''}`}
                  halign={Gtk.Align.LEFT}
                  hexpand={true}
                >
                  <icon icon={app.iconName} />
                  <label label={app.name} halign={Gtk.Align.RIGHT} />
                </box>

        )}
      </box>
    </box>
  </OsdPopup>
}
