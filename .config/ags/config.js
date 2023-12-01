import App from 'resource:///com/github/Aylur/ags/app.js';
import './js/globals.js';
import { volumePopup } from './js/volume/volume.js';
import { topBar } from './js/bar/topbar.js';
import { session } from './js/session/session.js';

const css = App.configDir + '/styles/style.css';

export default {
  closeWindowDelay: {
    // 'volume-popup': 500, // milliseconds
  },
  notificationPopupTimeout: 5000, // milliseconds
  cacheNotificationActions: false,
  maxStreamVolume: 1.0, // float
  style: css,
  windows: [
    // NOTE: the window will still render, if you don't pass it here
    // but if you don't, the window can't be toggled through ags.App or cli
    volumePopup,
    session,
    topBar(),
    // you can call it, for each monitor
    // topBar({ monitor: 0 }),
    // topBar({ monitor: 1 })
  ],
};
