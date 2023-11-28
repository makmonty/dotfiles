-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
map("n", "<C-S-7>", ":term", { desc = "Open terminal" })
-- map({ "n", "<C-S-7>", ":term", { desc = "Open terminal" } })
-- map({ "t", "<C-S-7>", "<C-/>", { desc = "Close terminal" } })
