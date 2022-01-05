local hooks = require "core.hooks"

hooks.add("setup_mappings", function(map)
   map("n", "<leader>lg", ":LazyGit<CR>")
   map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
end)

hooks.add("install_plugins", function(use)
  use {
    'kdheepak/lazygit.nvim',
  }
  use {
    "williamboman/nvim-lsp-installer",   
  }
  use {
    "jose-elias-alvarez/null-ls.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("custom.plugins.null-ls").setup()
    end,
  }
  use {
    "simrat39/rust-tools.nvim",
    after = "nvim-lspconfig",
  }
end)
