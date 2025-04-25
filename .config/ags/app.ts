import { App, Astal } from 'astal/gtk3'
import css from './styles/style.scss'
import { startBars } from './widgets/TopBar/TopBar'
import { showVolumePopup } from './widgets/Volume/VolumePopup'
import { showBrightnessPopup } from './widgets/Brightness/BrightnessPopup'
import { showLauncherPopup } from './widgets/Launcher/Launcher'
import { Session } from './widgets/Session/Session'
import { Notifications, connectNotifications } from './widgets/Notifications/Notifications'

App.start({
  css,
  requestHandler(request, response) {
    if (request === 'volume') {
      showVolumePopup()
    }
    if (request === 'brightness') {
      showBrightnessPopup()
    }
    if (request === 'session') {
      App.get_monitors().map(Session)
    }
    if (request === 'launcher') {
      showLauncherPopup()
    }

    response(request)
  },
  main() {
    startBars();
    App.get_monitors().map(Notifications);
    connectNotifications()
  },
})
