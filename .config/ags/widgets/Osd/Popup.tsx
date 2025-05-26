import { bind, Variable } from 'astal'
import { App, Astal, Gdk } from 'astal/gtk3'
import Binding from 'astal/binding'

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
  className?: Binding<string> | string,
  anchor?: Astal.WindowAnchor
  margin?: number,
  marginTop?: number,
  marginBottom?: number,
  marginLeft?: number,
  marginRight?: number
  keyMode?: Astal.Keymode
  layer?: Astal.Layer
  setup?: (self: Astal.Window) => void,
  child?: JSX.Element | Binding<JSX.Element> | Binding<Array<JSX.Element>>
  children?: Array<JSX.Element> | Binding<Array<JSX.Element>>
}) {
  const parentClassName = typeof className === 'string' ? Variable(className) : className;
  return <window
    className={bind(parentClassName).as((value) => `osd-popup ${value}`)}
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
    setup={setup}
    gdkmonitor={gdkMonitor}
    exclusivity={Astal.Exclusivity.NORMAL}
    application={App}
  >
    <box className="osd-container">
      {child || children}
    </box>
  </window>
}
