return {
  "snacks.nvim",
  opts = {
    explorer = { enabled = false },
    dashboard = {
      width = 18,
      preset = {
        keys = {
          { icon = "", key = "f", desc = " ̲find file", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = "", key = "n", desc = " ̲new file", action = ":ene | startinsert" },
          { icon = "", key = "g", desc = " ̲grep text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = "", key = "r", desc = " ̲recent file", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = "",
            key = "c",
            desc = " ̲config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = "", key = "s", desc = " ̲session", section = "session" },
          { icon = "", key = "L", desc = " ̲Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = "", key = "q", desc = " ̲quit", action = ":qa" },
        },
        header = [[
                                                                   
      ████ ██████           █████      ██                 btw
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████
]],
      },
      formats = {
        key = { "" },
      },
    },
  },
  keys = {
    -- Disable explorer keymaps
    { "<leader>e", false },
    { "<leader>E", false },
    { "<leader>fe", false },
    { "<leader>fE", false },
  },
}
