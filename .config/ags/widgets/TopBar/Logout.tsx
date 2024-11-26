import { App } from 'astal/gtk3'
import { Session } from '../Session/Session';

export function LogoutButton() {
  return <button
    onClick={() => App.get_monitors().map(Session)}
  >
    <label label="⏻" />
  </button>
}
