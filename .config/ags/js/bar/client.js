import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

export const ClientTitle = () => Widget.Label({
  className: 'client-title',
  setup: self => self.bind('label', Hyprland.active.client, 'title')
});
