local M = {}

M.lazygit = {
  n = {
    ["<leader>lg"] = { "<cmd>LazyGit<CR>", "   Lazygit"},
  },
}
M.lsp = {
  n = {
    ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "   HOVER"},
  },
}
M.ssr = {
   n = {
    ["<leader>sr"] = { function() require("ssr").open() end},
  },
}

return M
