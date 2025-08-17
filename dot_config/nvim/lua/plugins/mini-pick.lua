return {
  'echasnovski/mini.pick',
  version = '*',
  dependencies = { 'echasnovski/mini.extra' },
  keys = {
    -- READMEs for more detail on mini.pick and mini.extra
    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-extra.md
    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-pick.md
    -- 
    -- You can also read the help docs with :h MiniPick and :h MiniExtra

    -- File pickers
    { "<leader><space>", function() require('mini.pick').builtin.files() end, desc = "Search for Files" },
    
    -- Grep
    { "<leader>/", function() require('mini.pick').builtin.grep_live() end, desc = "Live Grep" },
    { "<leader>sw", function() 
      require('mini.pick').builtin.grep({ pattern = vim.fn.expand('<cword>') }) 
    end, desc = "Grep Word" },
    
    -- Search
    { "<leader>s/", function() require('mini.extra').pickers.history({ scope = 'search' }) end, desc = "Search History" },
    { "<leader>sb", function() require('mini.pick').builtin.buffers() end, desc = "Buffers" },
    { "<leader>sc", function() require('mini.extra').pickers.commands() end, desc = "Commands" },
    { "<leader>sC", function() require('mini.extra').pickers.history({ scope = 'cmd' }) end, desc = "Command History" },
    { "<leader>sd", function() require('mini.extra').pickers.diagnostic() end, desc = "Diagnostics" },
    { "<leader>sf", function() require('mini.extra').pickers.oldfiles() end, desc = "Recent Files" },
    { "<leader>sg", function() require('mini.extra').pickers.git_files() end, desc = "Git Tracked Files" },
    { "<leader>sh", function() require('mini.pick').builtin.help() end, desc = "Help Tags" },
    { "<leader>sj", function() require('mini.extra').pickers.list({ scope = 'jump' }) end, desc = "Jump List" },
    { "<leader>sk", function() require('mini.extra').pickers.keymaps() end, desc = "Keymaps" },
    { "<leader>sl", function() require('mini.extra').pickers.list({ scope = 'location' }) end, desc = "Location List" },
    { "<leader>sm", function() require('mini.extra').pickers.marks() end, desc = "Marks" },
    { "<leader>sq", function() require('mini.extra').pickers.list({ scope = 'quickfix' }) end, desc = "Quickfix List" },
    { "<leader>sr", function() require('mini.extra').pickers.registers() end, desc = "Registers" },
    { "<leader>sR", function() require('mini.pick').builtin.resume() end, desc = "Resume Last Picker" },
    
    -- LSP
    { "<leader>sls", function() 
      require('mini.extra').pickers.lsp({ scope = 'document_symbol' }) 
    end, desc = "Document Symbols" },
    { "<leader>slS", function() 
      require('mini.extra').pickers.lsp({ scope = 'workspace_symbol' }) 
    end, desc = "Workspace Symbols" },
    { "<leader>slr", function() 
      require('mini.extra').pickers.lsp({ scope = 'references' }) 
    end, desc = "LSP References" },
    { "<leader>sld", function() 
      require('mini.extra').pickers.lsp({ scope = 'definition' }) 
    end, desc = "LSP Definition" },

    -- nvim overrides
    { "q/", function() require('mini.extra').pickers.history({ scope = 'search' }) end, desc = "Search History" },
    { "q:", function() require('mini.extra').pickers.history({ scope = 'cmd' }) end, desc = "Command History" },
  },
  config = function()
    require('mini.pick').setup({
      -- Delay between start of typing and next match update
      delay = {
        -- Delay between start of typing and next match update
        async = 10,
        -- Delay between start of typing and next match update
        busy = 50,
      },
      
      -- Keys for performing actions. See `:h MiniPick-actions`.
      mappings = {
        caret_left  = '<Left>',
        caret_right = '<Right>',
        
        choose            = '<CR>',
        choose_in_split   = '<C-s>',
        choose_in_tabpage = '<C-t>',
        choose_in_vsplit  = '<C-v>',
        choose_marked     = '<M-CR>',
        
        delete_char      = '<BS>',
        delete_char_right = '<Del>',
        delete_left      = '<C-u>',
        delete_word      = '<C-w>',
        
        mark     = '<C-x>',
        mark_all = '<C-a>',
        
        move_down  = '<C-n>',
        move_start = '<C-g>',
        move_up    = '<C-p>',
        
        paste           = '<C-r>',
        refine          = '<C-Space>',
        scroll_down     = '<C-f>',
        scroll_left     = '<C-h>',
        scroll_right    = '<C-l>',
        scroll_up       = '<C-b>',
        stop            = '<Esc>',
        toggle_info     = '<S-Tab>',
        toggle_preview  = '<Tab>',
      },
      
      -- General options
      options = {
        -- Whether to show content from bottom to top
        content_from_bottom = false,
        
        -- Whether to cache matches (more speed and memory on repeated prompts)
        use_cache = false,
      },
      
      -- Source definition. See `:h MiniPick-source`
      source = {
        items = nil,
        name  = nil,
        cwd   = nil,
        
        show    = nil,
        preview = nil,
        choose  = nil,
        choose_marked = nil,
      },
      
      -- Window related options
      window = {
        -- Float window config (table or callable returning it)
        config = nil,
        
        -- String to use as cursor character in prompt
        prompt_caret = '▏',
        
        -- String to use as prefix in prompt
        prompt_prefix = '> ',
      },
    })
  end,
}
