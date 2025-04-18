return {
	{
		"echasnovski/mini.files",
		lazy = false,
		opts = {
			mappings = {
				close = "q",
				go_in = "<Right>", -- go into directory or open file
				go_in_plus = "<S-Right>",
				go_out = "<Left>",
				go_out_plus = "<S-Left>",
				mark_goto = "'",
				mark_set = "m",
				reset = "<BS>",
				reveal_cwd = "@",
				show_help = "g?",
				synchronize = "=",
				trim_left = "<",
				trim_right = ">",
			},
			options = {
				use_as_default_explorer = true,
			},
		},
	},
}
