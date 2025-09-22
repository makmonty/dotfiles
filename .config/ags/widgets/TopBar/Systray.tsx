import { Astal, Gtk, Gdk, Gio } from 'ags/gtk4'
import Tray from 'gi://AstalTray'
import { createBinding, createComputed, For } from 'ags'

const createMenu = (menuModel: Gio.MenuModel, actionGroup: Gio.ActionGroup | null): Gtk.Menu => {
    const menu = Gtk.Menu.new_from_model(menuModel);
    menu.insert_action_group('dbusmenu', actionGroup);

    return menu;
};

const isPrimaryClick = (event: MouseEvent) => {
  return true//event.button === 1;
}

const isSecondaryClick = (event: MouseEvent) => {
  return false//event.button === 3;
}

export function Systray() {
  const tray = Tray.get_default()

  const trayItems = createBinding(tray, 'items')

  return (
    <box>
      <For each={trayItems}>
        {(item: Tray.TrayItem) => {
          let menu: Gtk.Menu;

          // const entryBinding = Variable.derive(
          //     [bind(item, 'menuModel'), bind(item, 'actionGroup')],
          //     (menuModel, actionGroup) => {
          //         if (!menuModel) {
          //             return console.error(`Menu Model not found for ${item.id}`);
          //         }
          //         if (!actionGroup) {
          //             return console.error(`Action Group not found for ${item.id}`);
          //         }
          //
          //         menu = createMenu(menuModel, actionGroup);
          //     },
          // );

          return <button
            onClicked={(self, event) => {
                // if (isPrimaryClick(event)) {
                    item.activate(0, 0);
                // }

                // if (isSecondaryClick(event)) {
                //     menu?.popup_at_widget(self, Gdk.Gravity.NORTH, Gdk.Gravity.SOUTH, null);
                // }
            }}
          >
            <image gicon={item.gicon} />
          </button>
        }}
      </For>
    </box>
  )
}
