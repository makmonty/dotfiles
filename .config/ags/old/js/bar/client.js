import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

export const ClientTitle = () => Widget.Label({
  className: 'client-title bar-module',
  setup: self => {
    self.hook(Hyprland.active.client, () => {
      const client = Hyprland.clients.find(client => client.address === Hyprland.active.client.address);
      self.label = client?.initialTitle || '';
      self.visible = !!self.label;
    })
  }
});
