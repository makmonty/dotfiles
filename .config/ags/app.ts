import App from 'astal/gtk4/app'
import css from './styles/style.scss'
import { Bar } from './widgets/TopBar/TopBar'
import { showVolumePopup } from './widgets/Volume/VolumePopup'
import { Session } from './widgets/Session/Session'

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
    App.get_monitors().map(Bar);
  },
})
