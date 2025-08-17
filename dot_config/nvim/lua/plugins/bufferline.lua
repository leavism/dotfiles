return {
  "akinsho/bufferline.nvim",
  -- HACK: New catppuccin introduces breaking change.
  -- Once Bufferline or Lazyvim fixes this, remove the init function
  init = function()
    local bufline = require("catppuccin.groups.integrations.bufferline")
    function bufline.get()
      return bufline.get_theme()
    end
  end,
}
