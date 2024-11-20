import { Gdk } from "astal/gtk3"
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
    tooltipText={`Workspace ${ws.name}`}
    onClicked={() => execAsync(`hyprctl dispatch workspace ${ws.id}`)}
    setup={self => self.hook(
      hyprland,
      'event',
      self => {
        self.toggleClassName('special', ws.name === 'special');
        self.toggleClassName('focused', hyprland.get_focused_workspace().id === ws.id);
        self.toggleClassName('active', hyprland.get_monitors().some(monitor => monitor.activeWorkspace.id === ws.id));
      },
    )}
  >
    <label
      label={ws.name}
    />
  </button>
}

export const Workspaces = ({ monitorIndex }: { gdkMonitor: Gdk.Monitor, monitorIndex: number }) => {
  const monitor = hyprland.get_monitor(monitorIndex)

  return <box
    className="workspaces bar-module"
    // children: getWorkspaces()
    //     .filter(ws => ws.monitor === monitor.name)
    //     .map(Workspace),

    setup={self => self.hook(
      hyprland,
      'event',
      box => {
        const workspaces = hyprland.get_workspaces();
        console.log(workspaces)
        workspaces
          .filter(ws => ws.monitor.id === monitor.id)
          .forEach(ws => {
            const isNew = !monitors[monitor.id]?.[ws.id];
            if (isNew) {
              console.log(monitor.id, monitor.name, ws.monitor.id)
              addWorkspace(ws, box);
            }

            removeEmptyWorkspaces(box, monitor);
          });
      }
    )}
  />
}
