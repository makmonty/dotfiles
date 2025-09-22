import App from 'ags/gtk4/app'
import { Astal } from "ags/gtk4"
import css from './styles/style.scss'
import { createPoll } from "ags/time"
import { TopBar } from './widgets/TopBar/TopBar'
import { showVolumePopup } from './widgets/Volume/VolumePopup'
import { showLauncherPopup } from './widgets/Launcher/Launcher'
// import { Session } from './widgets/Session/Session'

App.start({
  css,
  requestHandler(request, response) {
    if (request === 'volume') {
      showVolumePopup()
    }

    if (request === 'session') {
      // App.get_monitors().map(Session)
    }

    if (request === 'launcher') {
      showLauncherPopup()
    }
    response(request)
  },
  main() {
    return App.get_monitors().map(mon => <TopBar gdkMonitor={mon}/>);
    // const { TOP, LEFT, RIGHT } = Astal.WindowAnchor
    // const clock = createPoll("", 1000, "date")
    // return (
    //   <window visible anchor={TOP | LEFT | RIGHT}>
    //     <label label={clock} />
    //   </window>
    // )
  },
})
