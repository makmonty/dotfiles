import { Astal, Gdk } from 'astal/gtk3'
import Tray from 'gi://AstalTray'
// import { Variable } from 'astal'

const tray = Tray.get_default()

// const items = Variable([])
// items.bind(tray.get_items)

function SystrayItem({ item }: { item: Tray.TrayItem }) {
  // console.log(item.title, item.icon_name, item.gicon)
  return <button
    onClick={(_, event: Gdk.Event) => {
      if (event.button === Astal.MouseButton.PRIMARY) {
        item.activate(event.x, event.y)
      } else if (event.button === Astal.MouseButton.SECONDARY) {
        item.secondary_activate(event.x, event.y)
      }
    }}
    setup={self => item.bind_property('tooltip-markup', self, 'tooltip-markup', null)}
  >
    <icon
      gicon={item.gicon}
      setup={self => {
        item.bind_property('gicon', self, 'gicon', null);
      }}
    />
  </button>
}

export function Systray() {
  return <box
    setup={self => {
      const setItems = () => self.set_children(tray.get_items().map(item => SystrayItem({item})));
      self.hook(tray, 'item-added', setItems);
      self.hook(tray, 'item-removed', setItems);
    }}
  >
  </box>;
}
