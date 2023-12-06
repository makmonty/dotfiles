import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Gtk from 'gi://Gtk';

// const CalendarWidget = Widget.subclass(Gtk.Calendar);

export const calendarPopup = Widget.Window({
  name: 'calendar-popup',
  popup: true,
  visible: false,
  anchor: ['top', 'right'],
  // margins: [0, 0],
  focusable: true,
  className: 'calendar-popup',
  // layer: 'overlay',
  // hpack: 'fill',
  // vpack: 'fill',
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
        showDayNames: false,
        showHeading: true,
      }),
    ],
  }),
});
