import App from 'resource:///com/github/Aylur/ags/app.js';
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import './js/globals.js';
import { volumePopup } from './js/volume/volume.js';
import { calendarPopup } from './js/calendar/calendar.js';
import { topBar } from './js/bar/topbar.js';
import { session } from './js/session/session.js';
import { getMonitors } from './js/utils.js';

const css = App.configDir + '/styles/style.css';

Hyprland.connect('monitor-added', (_, monitorName) => {
  const monitor = getMonitors().find(monitor => monitor.name === monitorName);
  App.addWindow(topBar({ monitor }));
});

Hyprland.connect('monitor-removed', (_, monitorName) => {
  App.removeWindow(`bar-${monitorName}`);
  // const monitor = Hyprland.monitors.find(monitor => monitor.name === newMonitorName);
  // App.addWindow(topBar({ monitor: monitor.id }));
});

const monitors = getMonitors();

App.config({
  closeWindowDelay: {
    // 'volume-popup': 500, // milliseconds
  },
  // notificationPopupTimeout: 5000, // milliseconds
  // cacheNotificationActions: false,
  maxStreamVolume: 1.0, // float
  style: css,
  windows: [
    // NOTE: the window will still render, if you don't pass it here
    // but if you don't, the window can't be toggled through ags.App or cli
    volumePopup,
    calendarPopup,
    session,
    ...(monitors.map(monitor => topBar({ monitor })))
  ],
});
