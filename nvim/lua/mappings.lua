require "nvchad.mappings"

local map = vim.keymap.set


map("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "   Lazygit"})
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "   HOVER"})
map("n", "<leader>sr", function() require("ssr").open() end)
