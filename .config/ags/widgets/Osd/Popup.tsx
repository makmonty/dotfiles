import { Astal, Gdk } from 'ags/gtk4'
import App from 'ags/gtk4/app'

export function OsdPopup({
  gdkMonitor,
  name,
  className = '',
  anchor = Astal.WindowAnchor.BOTTOM,
  margin,
  marginTop,
  marginBottom = 200,
  marginLeft,
  marginRight,
  keyMode,
  layer = Astal.Layer.OVERLAY,
  setup,
  child,
  children,
}: {
  gdkMonitor: Gdk.Monitor,
  name: string,
  className?: string,
  anchor?: Astal.WindowAnchor
  margin?: number,
  marginTop?: number,
  marginBottom?: number,
  marginLeft?: number,
  marginRight?: number
  keyMode?: Astal.Keymode
  layer?: Astal.Layer
  setup?: (self: Astal.Window) => void,
  child?: JSX.Element | Array<JSX.Element>
  children?: Array<JSX.Element>
}) {
  const parentClassName = className;
  return <window
    visible
    class={`osd-popup ${parentClassName}`}
    namespace="osd"
    name={name}
    anchor={anchor}
    margin={margin}
    marginTop={marginTop}
    marginBottom={marginBottom}
    marginLeft={marginLeft}
    marginRight={marginRight}
    keymode={keyMode}
    layer={layer}
    $={setup}
    gdkmonitor={gdkMonitor}
    exclusivity={Astal.Exclusivity.NORMAL}
    application={App}
  >
    <box class="osd-container">
      {child || children}
    </box>
  </window>
}
