import { App, Astal, Gdk } from 'astal/gtk3'
import Binding from 'astal/binding'

export function OsdPopup({
  gdkMonitor,
  name,
  className = '',
  margin,
  marginTop,
  marginBottom = 200,
  marginLeft,
  marginRight,
  anchor = Astal.WindowAnchor.BOTTOM,
  child,
  children
}: {
  gdkMonitor: Gdk.Monitor,
  name: string,
  anchor?: Astal.WindowAnchor
  className?: string,
  margin?: number,
  marginTop?: number,
  marginBottom?: number,
  marginLeft?: number,
  marginRight?: number
  child?: JSX.Element | Binding<JSX.Element> | Binding<Array<JSX.Element>>
  children?: Array<JSX.Element> | Binding<Array<JSX.Element>>
}) {
  return <window
    className={`osd-popup ${className}`}
    namespace="osd"
    name={name}
    anchor={anchor}
    margin={margin}
    marginTop={marginTop}
    marginBottom={marginBottom}
    marginLeft={marginLeft}
    marginRight={marginRight}
    layer={Astal.Layer.OVERLAY}
    gdkmonitor={gdkMonitor}
    exclusivity={Astal.Exclusivity.NORMAL}
    application={App}
  >
  <box className="osd-container">
    {child || children}
  </box>
  </window>
}
