vim.cmd('let g:dashboard_default_executive="fzf"')
local dashboard = require'dashboard'
dashboard.custom_center = {
  {
    icon = '  ',
    desc = 'Restore last session                    ',
    shortcut = 'SPC s l',
    action ='RestoreSession'
  },
  {
    icon = '  ',
    desc = 'Recent sessions                         ',
    action =  'Autosession search',
    shortcut = 'SPC f h'
  },
  {
    icon = '  ',
    desc = 'Find File                               ',
    action = 'Telescope find_files find_command=rg,--hidden,--files',
    shortcut = 'SPC f f'
  },
  {
    icon = '  ',
    desc ='File Browser                            ',
    action =  'Telescope file_browser',
    shortcut = 'SPC f b'
  },
  {
    icon = '  ',
    desc = 'Find word                               ',
    action = 'Telescope live_grep',
    shortcut = 'SPC f w'
  },
}