-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- These keymaps are made for Colemak
-- Focus navigation (n,e,i,o instead of h,j,k,l)
vim.keymap.set("n", "<C-w>n", "<C-w>h", { desc = "Move to the left window" })
vim.keymap.set("n", "<C-w>e", "<C-w>j", { desc = "Move to the window below" })
vim.keymap.set("n", "<C-w>i", "<C-w>k", { desc = "Move to the window above" })
vim.keymap.set("n", "<C-w>o", "<C-w>l", { desc = "Move to the right window" })

-- Move selected lines up and and down
-- macOS: Check that C-Up and C-Down aren't current bound to system keyboard shortcut.
vim.keymap.set("n", "<C-Up>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("n", "<C-Down>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("i", "<C-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
vim.keymap.set("i", "<C-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
vim.keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

-- Reload keymaps
vim.keymap.set("n", "<leader>rr", function()
	package.loaded["config.keymaps"] = nil
	require("config.keymaps")
	vim.notify("Keymaps reloaded!", vim.log.levels.INFO)
end, { desc = "Reload keymaps" })
