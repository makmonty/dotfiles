import { Astal, Gdk } from 'astal/gtk3'
import Tray from 'gi://AstalTray'
import { Variable } from 'astal'

const tray = Tray.get_default()

function SystrayItem({ item }: { item: Tray.TrayItem }) {
  const itemVar = Variable(item)
  itemVar.observe(item, 'changed', (item: Tray.TrayItem) => item)

  return <button
    onDestroy={() => itemVar.drop()}
    onClick={(self: Astal.Button, event: Gdk.Event) => {
      if (event.button === Astal.MouseButton.PRIMARY) {
        item.activate(event.x, event.y)
      } else if (event.button === Astal.MouseButton.SECONDARY) {
        item.secondary_activate(event.x, event.y)
      }
    }}
    setup={(self: Astal.Button) => {
      item.bind_property('tooltip-markup', self, 'tooltip-markup', null)
    }}
  >
    {itemVar((value) => <icon gicon={value.gicon} />)}
  </button>
}

export function Systray() {
  return <box
    setup={(self: Astal.Box) => {
      const setItems = () => self.set_children(tray.get_items().map((item: Tray.TrayItem) => SystrayItem({item})));
      self.hook(tray, 'item-added', setItems);
      self.hook(tray, 'item-removed', setItems);
    }}
  >
  </box>;
}
