local M = {}

M.lazygit {
  n = {
    ["<leader>lg"] = { "<cmd>LazyGit<CR>" }
  }
}

M.lsp {
  n = {
    ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>" }
  }
}
