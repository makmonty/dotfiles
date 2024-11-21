import { App } from 'astal/gtk3'
import css from './styles/style.scss'
import { Bar } from './widgets/Bar/Bar'

App.start({
    css,
    main() {
        App.get_monitors().map(Bar)
    },
})
