M = {}

M.config = function()
  vim.g.copilot_no_tab_map = true
  vim.keymap.set("i", "<S-Tab>", 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false,
  })
end

return M
