import { Astal, Gdk } from 'astal/gtk3'
import { bind } from 'astal'
import Tray from 'gi://AstalTray'

export function Systray() {
  const tray = Tray.get_default()

  return (
    <box>
      {bind(tray, 'items').as((items) =>
        items.map((item: Tray.TrayItem) => {
          const menu = item.create_menu()

          return (
            <button
              tooltipMarkup={bind(item, 'tooltipMarkup')}
              onDestroy={() => menu?.destroy()}
              onClickRelease={(self: Astal.Button) => {
                menu?.popup_at_widget(
                  self,
                  Gdk.Gravity.SOUTH,
                  Gdk.Gravity.NORTH,
                  null,
                )
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
