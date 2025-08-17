return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = { "echasnovski/mini.icons" },
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle Pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete Buffers to the Right" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete Buffers to the Left" },
    { "<leader>bt", "<Cmd>BufferLinePick<CR>",                 desc = "Buffer picker" },
    { "<leader>bb", "<C-^>",                                   desc = "Switch to Last Buffer" },
    { "<leader>bd", "<cmd>bdelete<cr>",                        desc = "Delete Buffer" },
    { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
    { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
    { "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
    { "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
    { "[B",         "<cmd>BufferLineMovePrev<cr>",             desc = "Move buffer prev" },
    { "]B",         "<cmd>BufferLineMoveNext<cr>",             desc = "Move buffer next" },
  },
  opts = {
    options = {
      close_command = function(n)
        vim.cmd("bdelete " .. n)
      end,
      right_mouse_command = function(n)
        vim.cmd("bdelete " .. n)
      end,
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      diagnostics_indicator = function(_, _, diag)
        local icons = {
          Error = " ",
          Warn = " ",
          Hint = " ",
          Info = " ",
        }
        local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
        return vim.trim(ret)
      end,
      pick = {
        alphabet = "abcdefghijklmnopqrstuvwxyz",
      },
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
      -- Use mini.icons for file type icons
      get_element_icon = function(element)
        local icon, hl, is_default = require("mini.icons").get("filetype", element.filetype)
        return icon, hl
      end,
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)

    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
      callback = function()
        vim.schedule(function()
          vim.cmd("redrawtabline")
        end)
      end,
    })
  end,
}
