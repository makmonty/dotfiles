import App from 'ags/gtk4/app'
import { Session } from '../Session/Session';

export function LogoutButton() {
  return <button
    onClicked={() => App.get_monitors().map(Session)}
  >
    <label label="⏻" />
  </button>
}
