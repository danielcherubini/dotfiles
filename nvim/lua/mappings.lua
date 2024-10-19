require "nvchad.mappings"

local map = vim.keymap.set

map("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "   Lazygit" })
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "   HOVER" })
map("n", "<leader>sr", function()
  require("ssr").open()
end)
-- Keyboard users
map("n", "<C-t>", function()
  require("menu").open "default"
end, {})

-- mouse users + nvimtree users!
map("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})
