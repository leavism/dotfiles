--[[
Keymaps are automatically loaded on the VeryLazy event
Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
The following custom keymaps are made for Colemak, but you should try to maintain the default nvim keymaps
even if it's slighty strange for Colemak.
--]]

-- Focus navigation (n,e,i,o instead of h,j,k,l)
vim.keymap.set("n", "<C-w>n", "<C-w>h", { desc = "Move to the left window" })
vim.keymap.set("n", "<C-w>e", "<C-w>j", { desc = "Move to the window below" })
vim.keymap.set("n", "<C-w>i", "<C-w>k", { desc = "Move to the window above" })
vim.keymap.set("n", "<C-w>o", "<C-w>l", { desc = "Move to the right window" })

-- Swap Alt-j and Alt-k for moving lines up and down.
-- Alt-j to move up (default down)
vim.keymap.set("n", "<A-j>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("i", "<A-j>", "<Esc><cmd>m .-2<CR>==gi", { desc = "Move line up" })
-- Alt-k to move down (default up)
vim.keymap.set("n", "<A-k>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("v", "<A-k>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("i", "<A-k>", "<Esc><cmd>m .+1<CR>==gi", { desc = "Move line down" })

-- Bufferline Pick
vim.keymap.set("n", "<leader>bg", ":BufferLinePick<CR>", { desc = "Switch to a tab" })
vim.keymap.set("v", "<leader>bg", "<ESC>:BufferLinePick<CR>", { desc = "Switch to a tab" })
