-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- Show dashboard when opening a directory
-- Show dashboard when opening a directory
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- Check if we're entering with a directory argument
		local directory = vim.fn.argv(0)
		if vim.fn.isdirectory(directory) == 1 then
			-- If this is a directory, force display the dashboard
			vim.cmd("lua require('snacks.dashboard').open()")

			-- You can also show mini.files if needed
			-- vim.cmd("MiniFiles")
		end
	end,
})
