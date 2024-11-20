import { App } from 'astal/gtk3'
import style from './styles/style.scss'
import { Bar } from './widgets/Bar/Bar'

App.start({
    css: style,
    main() {
        App.get_monitors().map(Bar)
    },
})
