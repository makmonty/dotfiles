import { Astal, Gdk } from 'astal/gtk3'
import Tray from 'gi://AstalTray'
import { Variable } from 'astal'

const tray = Tray.get_default()

function SystrayItem({ item }: { item: Tray.TrayItem }) {
  const itemVar = Variable(item);
  itemVar.observe(item, 'changed', (item: Tray.TrayItem) => {
    console.log('item changed!', item)
    return item
  });

  return <button
      onDestroy={() => itemVar.drop()}
      onClick={(self: Astal.Button, event: Gdk.Event) => {
        if (event.button === Astal.MouseButton.PRIMARY) {
          item.activate(event.x, event.y)
        } else if (event.button === Astal.MouseButton.SECONDARY) {
          item.secondary_activate(event.x, event.y)
        }
      }}
      tooltipText={item.tooltipMarkup}
    >
      <icon gicon={item.gicon} pixBuf={item.iconPixbuf} />
    </button>
}

export function Systray() {
  return <box
    setup={(self: Astal.Box) => {
      const setItems = (self: Astal.Box) => {
        self.set_children(tray.get_items().map((item: Tray.TrayItem) => SystrayItem({item})));
        console.log(tray.get_items().map(it => `${it.id} ${it.title} ${it.itemId}`))
      };
      self.hook(tray, 'item-added', setItems);
      self.hook(tray, 'item-removed', setItems);
    }}
  >
    {tray.get_items().map((item: Tray.TrayItem) => SystrayItem({item}))}
  </box>;
}
