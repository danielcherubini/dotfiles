local map = require("core.utils").map

 map("n", "<leader>lg", ":LazyGit<CR>")
 map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")

-- WSL yank support
vim.cmd([[
  let s:clip = '/mnt/c/Windows/System32/clip.exe'
  if executable(s:clip)
      augroup WSLYank
          autocmd!
          autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
      augroup END
  endif
]])
