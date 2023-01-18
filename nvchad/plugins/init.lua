local plugin_conf = require "custom.plugins.overrides"

return {
  ["editorconfig/editorconfig-vim"] = {},
  ["kdheepak/lazygit.nvim"] = {},
  ["simrat39/rust-tools.nvim"] = {},
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  [ "jose-elias-alvarez/null-ls.nvim" ] = {
      after = "nvim-lspconfig",
      config = function()
        require "custom.plugins.null-ls"
      end,
  },
  ["nvim-treesitter/nvim-treesitter"] = plugin_conf.treesitter,
  ["kyazdani42/nvim-tree.lua"] = plugin_conf.nvimtree,
  ["hrsh7th/nvim-cmp"] = plugin_conf.cmp,
  ["williamboman/mason.nvim"] = plugin_conf.mason,
  ["cshuaimin/ssr.nvim"] = {},
}
