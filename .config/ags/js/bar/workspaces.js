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
  monitors[ws.monitor] ||= {};
  monitors[ws.monitor][ws.id] = {widget, ws};
}

const removeWorkspace = (ws, parent) => {
  const widget = monitors[ws.monitor][ws.id].widget;
  parent.remove(widget);
  parent.notify('children');
  parent.show_all();
  delete monitors[ws.monitor][ws.id];
}

const removeEmptyWorkspaces = (parent, monitor) => {
  const workspaces = getWorkspaces();
  Object.values(monitors[monitor.name]).forEach(({ws}) => {
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
    connections: [
      [Hyprland, self => {
        const classes = [];
        if (Hyprland.active.workspace.id === ws.id) {
          classes.push('focused');
        }
        if (getMonitors().some(monitor => monitor.activeWorkspace.id === ws.id)) {
          classes.push('active');
        }
        self.className = classes.join(' ');
      }],
    ]
  });
  return widget;
}

export const Workspaces = ({ monitor }) => {
  return Widget.Box({
    className: 'workspaces',
    // children: getWorkspaces()
    //     .filter(ws => ws.monitor === monitor.name)
    //     .map(Workspace),

    connections: [[Hyprland, self => {
      const workspaces = getWorkspaces();
      workspaces
        .filter(ws => ws.monitor === monitor.name)
        .forEach(ws => {
          const isNew = !monitors[monitor.name]?.[ws.id];
          if (isNew) {
            addWorkspace(ws, self);
          }

          removeEmptyWorkspaces(self, monitor);
        });

    }]],
  });
}
