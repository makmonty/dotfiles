return {
  -- Fuzzy finder
  --{
  --  'junegunn/fzf',
  --  build = vim.fn['fzf#install']
  --},
  --{ 'junegunn/fzf.vim' },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        -- build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    config = function()
      local action_state = require("telescope.actions.state")
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          cache_picker = {
            num_pickers = -1,
            limit_entries = 50,
          },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
          },
        },
        pickers = {
          buffers = {
            mappings = {
              i = {
                ["<C-x>"] = function(prompt_bufnr)
                  local current_picker = action_state.get_current_picker(prompt_bufnr)
                  local selected_bufnr = action_state.get_selected_entry().bufnr
                  --- get buffers with lower number, with next highest ("bprevious") selected first
                  local replacement_buffers = {}
                  for entry in current_picker.manager:iter() do
                    if entry.bufnr < selected_bufnr then
                      table.insert(replacement_buffers, 1, entry.bufnr)
                    end
                  end
                  current_picker:delete_selection(function(selection)
                    local bufnr = selection.bufnr
                    -- get associated window(s)
                    local winids = vim.fn.win_findbuf(bufnr)
                    -- verify to only close windows with current buffer
                    local tabwins = vim.api.nvim_tabpage_list_wins(0)
                    -- fill winids with new empty buffers
                    for _, winid in ipairs(winids) do
                      if vim.tbl_contains(tabwins, winid) then
                        local new_buf = vim.F.if_nil(
                          table.remove(replacement_buffers),
                          -- if no alternative available, create unlisted scratch buffer
                          vim.api.nvim_create_buf(false, true)
                        )
                        vim.api.nvim_win_set_buf(winid, new_buf)
                      end
                    end
                    -- remove buffer at last
                    vim.api.nvim_buf_delete(bufnr, { force = true })
                  end)
                end,
              },
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
      })
    end,
  },
  -- {
  --   "ibhagwan/fzf-lua",
  --   -- optional for icon support
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  -- },
}
