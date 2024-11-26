import { App } from 'astal/gtk3'
import css from './styles/style.scss'
import { TopBar } from './widgets/TopBar/TopBar'
import { showVolumePopup } from './widgets/Volume/VolumePopup'
import { Session } from './widgets/Session/Session'
import { CalendarPopup } from './widgets/Calendar/CalendarPopup'

App.start({
  css,
  requestHandler(request, response) {
    if (request === 'volume') {
      showVolumePopup()
    }

    if (request === 'session') {
      App.get_monitors().map(Session)
    }
    response(request)
  },
  main() {
    App.get_monitors().map(TopBar);
  },
})
