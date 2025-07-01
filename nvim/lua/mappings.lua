require "nvchad.mappings"

local map = vim.keymap.set

map("n", "<leader>X", "<cmd>tabclose<CR>", { desc = "Close Tab" })
map("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "   Lazygit" })
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "   HOVER" })
map("n", "<leader>sr", function()
  require("ssr").open()
end)
-- Keyboard users
map("n", "<C-t>", function()
  require("menu").open "default"
end, {})

-- Terminal
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle {
    pos = "bo vsp",
    id = "vertTerm",
    size = 0.5,
  }
end, { desc = "terminal toggle vertical term" })
map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle {
    pos = "float",
    id = "floatTerm",
    float_opts = {
      row = 0.03,
      col = 0.03,
      width = 0.9,
      height = 0.9,
    },
  }
end, { desc = "terminal toggle floating term" })
--
-- mouse users + nvimtree users!
map("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})
