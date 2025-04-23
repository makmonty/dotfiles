export function OsdLevelBar({ disabled, value }: {
  disabled: boolean,
  value: number
}) {
  return <levelbar
    className={`osd-level-bar ${disabled ? 'disabled' : ''}`}
    value={value}
  />
}
