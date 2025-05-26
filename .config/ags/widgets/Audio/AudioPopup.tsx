import { Gdk } from 'astal/gtk3'
import Wp from "gi://AstalWp"
import { OsdDropdownList } from '../Osd/DropdownList'
import { execAsync } from 'astal'

const audio = Wp.get_default()!.audio

export function AudioPopup(gdkMonitor: Gdk.Monitor) {
  // audio.get_devices().forEach(device => {
  //   console.log('Device -',device.get_id(),'-', device.get_device_type(),'-', device.get_description())
  //   console.log('Current profile -', device.get_active_profile())
  //   device.get_profiles().forEach(profile => {
  //     console.log('Profile -', profile.get_index(), profile.get_description())
  //   })
  // })
  // audio.get_speakers().forEach(speaker => {
  //   console.log('Speaker -', speaker.get_name(), '-', speaker.get_description(), '-', speaker.get_id())
  // })

  const items = audio.get_speakers()!.map((endpoint: Wp.Endpoint) => {
    return {
      onClick: () => endpoint.set_is_default(true),
      label: (audio.get_default_speaker()?.id === endpoint.id ? '✓ ' : '') + endpoint.get_description()
    }
  })

  items.push({
    onClick: () => execAsync('pavucontrol'),
    label: 'Gestionar audio...'
  })
  return <OsdDropdownList
    gdkMonitor={gdkMonitor}
    name="audio-popup"
    items={items}
  />
}
