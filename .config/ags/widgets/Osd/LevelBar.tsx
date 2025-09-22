export function OsdLevelBar({ disabled, value }: {
  disabled: boolean,
  value: number
}) {
  return <levelbar
    class={`osd-level-bar ${disabled ? 'disabled' : ''}`}
    value={value}
  />
}
