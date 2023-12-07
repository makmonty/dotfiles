return {
  -- Editorconfig integration
  { 'editorconfig/editorconfig-vim' },
  -- Show css colors inline
  { 'ap/vim-css-color' },
  -- Underlines the current word and its appearances
  { 'itchyny/vim-cursorword' },
  -- Change easily the surrounding characters
  { 'tpope/vim-surround' },
  -- Autoclosing brackets
  { 'jiangmiao/auto-pairs' },
  -- Make multiline changes
  { 'mg979/vim-visual-multi' },
  -- Comment easily
  {
    'numToStr/Comment.nvim',
    config = function()
      require'Comment'.setup{
        toggler = {
          line = '<Leader>cl',
          block = '<Leader>cb',
        },
        opleader = {
          line = '<Leader>cl',
          block = '<Leader>cb',
        },
        mappings = {
          basic = true,
          extra = false,
        },
      }
    end
  },
  -- Bracket colorization
  { 'junegunn/rainbow_parentheses.vim' },
  -- Indent lines
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      require'ibl'.setup{}
    end
  },
}
