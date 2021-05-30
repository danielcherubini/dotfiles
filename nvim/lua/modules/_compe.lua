
-- Compe setup
require'compe'.setup {
	enabled = true;
	preselect = 'always';
	source = {
		path = true;
		nvim_lsp = true;
		vsnip = true;
		ultisnips = true;
		buffer = true;
	};
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- NOTE: Order is important. You can't lazy loading lexima.vim.
vim.g.lexima_no_default_rules = true
vim.cmd[[call lexima#set_default_rules()]]
local compeopts = {noremap=true,silent=true,expr=true}
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', compeopts)
vim.api.nvim_set_keymap("i", "<C-y>", "compe#confirm(lexima#expand('<LT>CR>', 'i'))", {expr = true})
vim.api.nvim_set_keymap("i", "<CR>", "<C-y>", {})
