import { Astal, Gtk, Gdk } from 'astal/gtk3'
import { bind, Variable, Gio } from 'astal'
import Tray from 'gi://AstalTray'

const createMenu = (menuModel: Gio.MenuModel, actionGroup: Gio.ActionGroup | null): Gtk.Menu => {
    const menu = Gtk.Menu.new_from_model(menuModel);
    menu.insert_action_group('dbusmenu', actionGroup);

    return menu;
};

const isPrimaryClick = (event: MouseEvent) => {
  return event.button === 1;
}

const isSecondaryClick = (event: MouseEvent) => {
  return event.button === 3;
}

export function Systray() {
  const tray = Tray.get_default()

  return (
    <box>
      {bind(tray, 'items').as((items) =>
        items.map((item: Tray.TrayItem) => {
          let menu: Gtk.Menu;

          const entryBinding = Variable.derive(
              [bind(item, 'menuModel'), bind(item, 'actionGroup')],
              (menuModel, actionGroup) => {
                  if (!menuModel) {
                      return console.error(`Menu Model not found for ${item.id}`);
                  }
                  if (!actionGroup) {
                      return console.error(`Action Group not found for ${item.id}`);
                  }

                  menu = createMenu(menuModel, actionGroup);
              },
          );

          return (

        <button
            onClick={(self, event) => {
                if (isPrimaryClick(event)) {
                    item.activate(0, 0);
                }

                if (isSecondaryClick(event)) {
                    menu?.popup_at_widget(self, Gdk.Gravity.NORTH, Gdk.Gravity.SOUTH, null);
                }
            }}
            onDestroy={() => {
                menu?.destroy();
                entryBinding.drop();
            }}
        >
              <icon gIcon={bind(item, 'gicon')} />
            </button>
          )
        }),
      )}
    </box>
  )
}
