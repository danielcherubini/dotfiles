local M = {}

-- overriding default plugin configs!
M.treesitter = {
   ensure_installed = {
      "lua",
      "vim",
      "html",
      "css",
      "javascript",
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

return M
