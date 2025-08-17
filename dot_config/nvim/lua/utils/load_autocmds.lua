local M = {}

function M.load_autocmds()
  local config_path = vim.fn.stdpath("config") .. "/lua"
  
  -- Directories to search for autocmd files
  local search_paths = {
    config_path .. "/config/autocmds.lua",
  }
  
  -- Load main autocmd files
  for _, path in ipairs(search_paths) do
    if vim.fn.filereadable(path) == 1 then
      local ok, err = pcall(dofile, path)
      if not ok then
        vim.notify("Error loading autocmds from " .. path .. ": " .. err, vim.log.levels.ERROR)
      end
    end
  end
  
  -- Load plugin-specific autocmds
  local plugin_dirs = vim.fn.glob(config_path .. "/plugins/*", false, true)
  for _, dir in ipairs(plugin_dirs) do
    local autocmd_file = dir .. "/autocmds.lua"
    if vim.fn.filereadable(autocmd_file) == 1 then
      local ok, err = pcall(dofile, autocmd_file)
      if not ok then
        vim.notify("Error loading plugin autocmds from " .. autocmd_file .. ": " .. err, vim.log.levels.ERROR)
      end
    end
  end
end

return M 
