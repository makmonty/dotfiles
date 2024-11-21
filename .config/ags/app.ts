import { App } from 'astal/gtk3'
import css from './styles/style.scss'
import { Bar } from './widgets/Bar/Bar'
import { showVolumePopup } from './widgets/Volume/VolumePopup'

App.start({
  css,
  requestHandler(request, response) {
    if (request === 'volume') {
      showVolumePopup()
    }
    response(request)
  },
  main() {
    App.get_monitors().map(Bar);
  },
})
