import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Gtk from 'gi://Gtk';

// const CalendarWidget = Widget.subclass(Gtk.Calendar);

export const calendarPopup = Widget.Window({
  name: 'calendar-popup',
  visible: false,
  anchor: ['top', 'right'],
  // margins: [0, 0],
  keymode: 'on-demand',
  className: 'calendar-popup',
  // layer: 'overlay',
  // hpack: 'fill',
  // vpack: 'fill',
  setup: self => self.keybind('Escape', () => App.closeWindow('calendar-popup')),
  child: Widget.Box({
    hpack: 'center',
    vpack: 'center',
    className: 'calendar-container',
    children: [
      // CalendarWidget({
      //   showDayNames: false,
      //   showHeading: true,
      //   // now you can set AGS props
      //   connections: [/* */],
      //   className: '',
      // }),
      new Gtk.Calendar({
        showDayNames: true,
        showHeading: true,
      }),
    ],
  }),
});
