import { App, Gdk, Gtk } from 'astal/gtk3'
import Hyprland from 'gi://AstalHyprland';
import GObject from 'astal/gobject'
import { execAsync } from 'astal'

const hyprland = Hyprland.get_default()

const monitors: Record<string, Record<string, { widget: GObject.Object, ws: Hyprland.Workspace }>> = {};

const workspacesById: Record<string, string[]> = {}

const addWorkspace = (ws: Hyprland.Workspace, parent: GObject.Object) => {
  const widget = Workspace({ ws });
  monitors[ws.monitor.id] ||= {};
  monitors[ws.monitor.id][ws.id] = {widget, ws};
  const position = findWorkspacePosition(ws);
  workspacesById[ws.monitor.id] ||= [];
  workspacesById[ws.monitor.id].splice(position, 0, ws.id)

  parent.add(widget);
  parent.reorder_child(widget, position)
  parent.notify('children');
  parent.show_all();
}

const findWorkspacePosition = (ws: Hyprland.Workspace) => {
  const monitorId = ws.monitor.id;
  let pos = 0;
  for (const i in workspacesById[monitorId]) {
    const currentWsId = workspacesById[monitorId][i]
    const currentWs = monitors[monitorId][currentWsId]
    if (ws.id > currentWs?.ws.id) {
      pos = parseInt(i) + 1
    }
  }
  return pos;
}

const removeWorkspace = (ws: Hyprland.Workspace, parent: any) => {
  const widget = monitors[ws.monitor.id][ws.id]?.widget;
  if (widget) {
    parent.remove(widget);
  }
  parent.notify('children');
  parent.show_all();
  delete monitors[ws.monitor.id][ws.id];
  const index = workspacesById[ws.monitor.id].findIndex(wsId => wsId === ws.id)
  workspacesById[ws.monitor.id].splice(index, 1)
}

const removeEmptyWorkspaces = (parent: any, monitor: Hyprland.Monitor) => {
  const workspaces = hyprland.get_workspaces();
  Object.values(monitors[monitor.id]).forEach(({ws}) => {
    const isGone = !workspaces.some(workspace => workspace.id === ws.id);

    if (isGone) {
      removeWorkspace(ws, parent);
    }
  })
}

export function Workspace({ ws }: { ws: Hyprland.Workspace }) {
  return <button
    vexpand={false}
    hexpand={false}
    valign={Gtk.Align.CENTER}
    tooltipText={`Workspace ${ws.name}`}
    onClicked={() => execAsync(`hyprctl dispatch workspace ${ws.id}`)}
    setup={self => self.hook(
      hyprland,
      'event',
      self => {
        self.toggleClassName('special', ws.name === 'special');
        self.toggleClassName('focused', hyprland.get_focused_workspace()?.id === ws.id);
        self.toggleClassName('active', ws.get_monitor().get_active_workspace()?.id === ws.id);
      },
    )}
  >
    <label
      label={ws.name}
    />
  </button>
}

export function Workspaces ({ gdkMonitor }: { gdkMonitor: Gdk.Monitor }) {
  // This way of identifying which Gdk.Monitor matches which Hyprland monitor
  // doesn't work always. If you have three monitors, unplug the second and plug it
  // back, the indexes will be different. But there's no other way AFAIK
  const monitorIndex = App.get_monitors().findIndex((mon: Gdk.Monitor) => mon === gdkMonitor)
  const monitor = hyprland.get_monitor(monitorIndex)

  const setWorkspaces = (box: GObject.Object) => {
    const workspaces = hyprland.get_workspaces();
    workspaces
      .filter(ws => ws.monitor?.id === monitor.id)
      .forEach(ws => {
        const isNew = !monitors[monitor.id]?.[ws.id];
        if (isNew) {
          addWorkspace(ws, box);
        }

        removeEmptyWorkspaces(box, monitor);
      });
  }

  return <box
    className="workspaces"
    setup={self => {
      setWorkspaces(self);
      self.hook(
        hyprland,
        'event',
        setWorkspaces
      );
    }}
  />
}
