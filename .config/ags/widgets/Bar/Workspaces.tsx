import { Gdk, Gtk } from "astal/gtk3"
import Hyprland from "gi://AstalHyprland";
import GObject from 'astal/gobject'
import { execAsync } from 'astal'

const hyprland = Hyprland.get_default()

const monitors: Record<string, Record<string, { widget: GObject.Object, ws: Hyprland.Workspace }>> = {};

const addWorkspace = (ws: Hyprland.Workspace, parent: any) => {
  const widget = Workspace({ ws });
  parent.add(widget);
  parent.reorder_child(widget, ws.id - 1)
  parent.notify('children');
  parent.show_all();
  monitors[ws.monitor.id] ||= {};
  monitors[ws.monitor.id][ws.id] = {widget, ws};
}

const removeWorkspace = (ws: Hyprland.Workspace, parent: any) => {
  const widget = monitors[ws.monitor.id][ws.id].widget;
  parent.remove(widget);
  parent.notify('children');
  parent.show_all();
  delete monitors[ws.monitor.id][ws.id];
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
        self.toggleClassName('focused', hyprland.get_focused_workspace().id === ws.id);
        // TODO: ws.get_monitor().get_active_workspace() is returning always the same workspace
        // Use the second implementation when it's fixed
        self.toggleClassName('active', hyprland.get_focused_workspace().id === ws.id);
        // self.toggleClassName('active', ws.get_monitor().get_active_workspace().id === ws.id);
      },
    )}
  >
    <label
      label={ws.name}
    />
  </button>
}

export function Workspaces ({ monitorIndex }: { gdkMonitor: Gdk.Monitor, monitorIndex: number }) {
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
