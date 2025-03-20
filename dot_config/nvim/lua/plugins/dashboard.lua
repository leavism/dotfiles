return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		dashboard = {
			width = 60,
			preset = {
				header = [[
██╗  ██╗███████╗██╗     ██╗      ██████╗   
██║  ██║██╔════╝██║     ██║     ██╔═══██╗  
███████║█████╗  ██║     ██║     ██║   ██║  
██╔══██║██╔══╝  ██║     ██║     ██║   ██║  
██║  ██║███████╗███████╗███████╗╚██████╔╝  
╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝ ╚═════╝   
██╗    ██╗ ██████╗ ██████╗ ██╗     ██████╗ 
██║    ██║██╔═══██╗██╔══██╗██║     ██╔══██╗
██║ █╗ ██║██║   ██║██████╔╝██║     ██║  ██║
██║███╗██║██║   ██║██╔══██╗██║     ██║  ██║
╚███╔███╔╝╚██████╔╝██║  ██║███████╗██████╔╝
 ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝ 
      ]],
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				function()
					local in_git = Snacks.git.get_root() ~= nil
					local has_remote = false

					if in_git then
						-- Check if the repo has any remotes
						local result = vim.fn.system("git remote")
						has_remote = result ~= nil and result ~= ""
					end

					if in_git and has_remote then
						return {
							pane = 2,
							icon = " ",
							desc = "Browse Remote",
							padding = 1,
							key = "b",
							action = function()
								Snacks.gitbrowse()
							end,
						}
					else
						return nil -- Don't show this section if conditions aren't met
					end
				end,
				function()
					local in_git = Snacks.git.get_root() ~= nil
					local cmds = {

						{
							title = "Notifications",
							cmd = "gh api notifications --template 'You have {{len .}} unread notification(s)'",
							action = function()
								vim.ui.open("https://github.com/notifications")
							end,
							key = "n",
							icon = " ",
							height = 2,
						},
						{
							title = "Open Issues",
							cmd = 'gh issue list --json number,title,updatedAt --template \'{{range .}}{{tablerow (printf "#%v" .number | autocolor "green") .title (timeago .updatedAt)}}{{end}}\'',
							key = "i",
							action = function()
								vim.fn.jobstart("gh issue list --web", { detach = true })
							end,
							icon = " ",
							height = 5,
						},
						{
							icon = " ",
							title = "Open PRs",
							cmd = "gh pr list -L 3",
							key = "P",
							action = function()
								vim.fn.jobstart("gh pr list --web", { detach = true })
							end,
							height = 7,
						},
						{
							icon = " ",
							title = "Git Status",
							cmd = "git --no-pager diff --stat -B -M -C",
							height = 10,
						},
					}
					return vim.tbl_map(function(cmd)
						return vim.tbl_extend("force", {
							pane = 2,
							section = "terminal",
							enabled = in_git,
							padding = 1,
							ttl = 5 * 60,
							indent = 3,
						}, cmd)
					end, cmds)
				end,
				{ section = "startup" },
			},
		},
	},
}
