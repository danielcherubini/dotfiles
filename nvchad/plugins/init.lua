return {
  [ "kdheepak/lazygit.nvim" ] = {},
  [ "williamboman/nvim-lsp-installer" ] = {},
  [ "jose-elias-alvarez/null-ls.nvim" ] = {
      after = "nvim-lspconfig",
      config = function()
        require("custom.plugins.null-ls").setup()
      end,
  },
  ["simrat39/rust-tools.nvim"] = { after = "nvim-lspconfig" },
}
