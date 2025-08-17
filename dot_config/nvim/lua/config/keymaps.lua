-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Disable LazyVim keymaps
vim.keymap.del("n", "<leader>l") -- Lazy.nvim plugin manager
vim.keymap.del("n", "<leader>L") -- Lazy changelog
vim.keymap.del("n", "<leader>:") -- Command history picker
vim.keymap.del("n", "<leader>,") -- Buffer picker
vim.keymap.del("n", "<leader>`") -- Switch to other buffer

vim.keymap.set("n", "<leader>W", ":w", { desc = "Write buffer" })
