import Gdk from 'gi://Gdk';
import { exec } from 'resource:///com/github/Aylur/ags/utils.js'

export function range(start, end) {
    return Array.from({ length: end - start + 1 }, (_, i) => i + start);
}

export function getNumOfMonitors() {
  return Gdk.Display.get_default()?.get_n_monitors() || 1;
}

export function getMonitors() {
  return JSON.parse(exec('hyprctl monitors -j'));
}
