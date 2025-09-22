import { App, Astal, Gdk, Gtk } from 'ags/gtk4'
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
  className?: string,
  keyMode?: Astal.Keymode
  layer?: Astal.Layer
  setup?: (self: Astal.Window) => void,
  items: Array<any>
  ItemComponent?: JSX.Element
}) {
  const parentClassName = className;
  const popup = <OsdPopup
    gdkMonitor={gdkMonitor}
    class={parentClassName}
    name={name}
    keyMode={keyMode}
    anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
    layer={layer}
    $={setup}
  >
    <box class="osd-dropdown-container" orientation={Gtk.Orientation.VERTICAL}>
      {items.map(item =>
        ItemComponent ?
          <ItemComponent item={item} /> :
          <button
            class="osd-dropdown-item"
            halign={Gtk.Align.START}
            hexpand={true}
            onClicked={() => {
              item.onClick?.();
            }}
          >
            {item.label}
          </button>
      )}
    </box>
  </OsdPopup>

  return popup
}
