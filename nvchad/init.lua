local map = require("core.utils").map

 map("n", "<leader>lg", ":LazyGit<CR>")
 map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
