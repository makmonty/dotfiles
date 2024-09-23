import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js';
import { getWorkspaces, getMonitors } from '../utils.js';

const monitors = {};

const addWorkspace = (ws, parent) => {
  const widget = Workspace(ws);
  parent.add(widget);
  parent.reorder_child(widget, ws.id - 1)
  parent.notify('children');
  parent.show_all();
  monitors[ws.monitorID] ||= {};
  monitors[ws.monitorID][ws.id] = {widget, ws};
}

const removeWorkspace = (ws, parent) => {
  const widget = monitors[ws.monitorID][ws.id].widget;
  parent.remove(widget);
  parent.notify('children');
  parent.show_all();
  delete monitors[ws.monitorID][ws.id];
}

const removeEmptyWorkspaces = (parent, monitor) => {
  const workspaces = getWorkspaces();
  Object.values(monitors[monitor.id]).forEach(({ws}) => {
    const isGone = !workspaces.some(workspace => workspace.id === ws.id);

    if (isGone) {
      removeWorkspace(ws, parent);
    }
  })
}

export const Workspace = ws => {
  const widget = Widget.Button({
    vpack: 'center',
    vexpand: false,
    hexpand: false,
    tooltipText: `Workspace ${ws.name}`,
    child: Widget.Label({
      vpack: 'center',
      hpack: 'center',
      label: ws.name
    }),
    onClicked: () => execAsync(`hyprctl dispatch workspace ${ws.id}`),
    setup: self => self.hook(
      Hyprland,
      self => {
        self.toggleClassName('special', ws.name === 'special');
        self.toggleClassName('focused', Hyprland.active.workspace.id === ws.id);
        self.toggleClassName('active', getMonitors().some(monitor => monitor.activeWorkspace.id === ws.id));
      },
    ),
  });
  return widget;
}

export const Workspaces = ({ monitor }) => {
  return Widget.Box({
    className: 'workspaces bar-module',
    // children: getWorkspaces()
    //     .filter(ws => ws.monitor === monitor.name)
    //     .map(Workspace),

    setup: self => self.hook(
      Hyprland,
      box => {
        const workspaces = getWorkspaces();
        workspaces
          .filter(ws => ws.monitorID === monitor.id)
          .forEach(ws => {
            const isNew = !monitors[monitor.id]?.[ws.id];
            if (isNew) {
              console.log(monitor.id, monitor.name, ws.monitorID)
              addWorkspace(ws, box);
            }

            removeEmptyWorkspaces(box, monitor);
          });
      }
    ),
  });
}
