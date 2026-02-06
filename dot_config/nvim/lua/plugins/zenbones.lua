return {
  "zenbones-theme/zenbones.nvim",
  dependencies = { "rktjmp/lush.nvim" },
  lazy = false,
  priority = 1000,
  config = function()
    -- Will look in colors/earthsong.lua
    vim.cmd.colorscheme("earthbones")
  end,
}
