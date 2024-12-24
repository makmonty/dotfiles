import { App } from 'astal/gtk3'
import css from './styles/style.scss'
import { TopBar } from './widgets/TopBar/TopBar'
import { showVolumePopup } from './widgets/Volume/VolumePopup'
import { showBrightnessPopup } from './widgets/Brightness/BrightnessPopup'
import { Session } from './widgets/Session/Session'
import { CalendarPopup } from './widgets/Calendar/CalendarPopup'
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
    response(request)
  },
  main() {
    App.get_monitors().map(TopBar);
    App.get_monitors().map(Notifications);
    connectNotifications()
  },
})
