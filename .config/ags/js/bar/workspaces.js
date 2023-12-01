import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js';

export const Workspaces = () => Widget.Box({
  className: 'workspaces',
  connections: [[Hyprland.active.workspace, self => {
    const arr = Hyprland.workspaces;
    self.children = arr.map(ws => Widget.Button({
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
      className: Hyprland.active.workspace.id == ws.id ? 'focused' : '',
    }));
  }]],
});

