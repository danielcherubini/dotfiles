local M = {}

-- overriding default plugin configs!
M.treesitter = {
   ensure_installed = {
      "lua",
      "vim",
      "html",
      "css",
      "javascript",
      "java",
      "json",
      "toml",
      "markdown",
      "c",
      "go",
      "rust",
   },
}

M.nvimtree = {
   git = {
      enable = true,
   },
}

M.cmp = function()
local cmp = require "cmp"
  return {
    mapping = {
      ["<Up>"] = cmp.mapping.select_prev_item(),
      ["<Down>"] = cmp.mapping.select_next_item(),
    },
  }
end

return M
