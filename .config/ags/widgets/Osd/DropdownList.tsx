import { bind, Variable } from 'astal'
import { App, Astal, Gdk, Gtk } from 'astal/gtk3'
import Binding from 'astal/binding'
import { OsdPopup } from './Popup'

export function OsdDropdownList({
  gdkMonitor,
  name,
  className = '',
  keyMode,
  layer = Astal.Layer.OVERLAY,
  setup,
  items,
  ItemComponent,
}: {
  gdkMonitor: Gdk.Monitor,
  name: string,
  className?: Binding<string> | string,
  keyMode?: Astal.KeyMode
  layer?: Astal.Layer
  setup?: (self: Astal.Window) => void,
  items: Array<any>
  ItemComponent?: JSX.Element
}) {
  const parentClassName = typeof className === 'string' ? Variable(className) : className;
  const popup = <OsdPopup
    gdkMonitor={gdkMonitor}
    className={bind(parentClassName).as((value) => `osd-dropdown ${value}`)}
    name={name}
    keyMode={keyMode}
    anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
    layer={layer}
    setup={setup}
  >
    <box className="osd-dropdown-container" vertical={true}>
      {items.map(item =>
        ItemComponent ?
          <ItemComponent item={item} /> :
          <button onClicked={() => {
            item.onClick?.();
          }}>{item.label}</button>
      )}
    </box>
  </OsdPopup>

  return popup
}
