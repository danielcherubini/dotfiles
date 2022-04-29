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

local status, cmp = pcall(require, "cmp")
if (status) then
  M.cmp = {
    mapping = {
      ["<Up>"] = cmp.mapping.select_prev_item(),
      ["<Down>"] = cmp.mapping.select_next_item(),
    },
  }
else
  M.cmp = {}
end

return M
