import { App, Astal, Gdk } from 'astal/gtk3'
import Binding from 'astal/binding'

export function Popup({ gdkMonitor, name, className = '', anchor = Astal.WindowAnchor.NONE, child, children }: {
  gdkMonitor: Gdk.Monitor,
  name: string,
  anchor?: Astal.WindowAnchor
  className?: string,
  child?: JSX.Element | Binding<JSX.Element> | Binding<Array<JSX.Element>>
  children?: Array<JSX.Element> | Binding<Array<JSX.Element>>
}) {
  return <window
    className={`osd-popup ${className}`}
    namespace="osd"
    name={name}
    anchor={anchor}
    layer={Astal.Layer.OVERLAY}
    gdkmonitor={gdkMonitor}
    exclusivity={Astal.Exclusivity.NORMAL}
    application={App}
  >
    {child}
    {children}
  </window>
}
