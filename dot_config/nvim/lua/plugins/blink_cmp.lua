return {
	-- https://cmp.saghen.dev/
	"saghen/blink.cmp",
	opts = {
		snippets = {
			expand = function(snippet, _)
				return LazyVim.cmp.expand(snippet)
			end,
		},
		appearance = {
			-- sets the fallback highlight groups to nvim-cmp's highlight groups
			-- useful for when your theme doesn't support blink.cmp
			use_nvim_cmp_as_default = false,
			-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},
		completion = {
			accept = {
				-- experimental auto-brackets support
				auto_brackets = {
					enabled = true,
				},
			},
			menu = {
				draw = {
					treesitter = { "lsp" },
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
			},
			ghost_text = {
				enabled = false,
			},
			list = {
				selection = {
					preselect = false,
					auto_insert = false,
				},
			},
		},

		sources = {
			-- adding any nvim-cmp sources here will enable them
			-- with blink.compat
			compat = {},
			default = { "lsp", "path", "snippets", "buffer" },
		},

		cmdline = {
			enabled = false,
		},

		keymap = {
			preset = "enter",
			["<C-y>"] = { "select_and_accept" },
		},
	},
}
