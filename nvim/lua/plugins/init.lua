local plugin_conf = require "configs.overrides"

return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
    -- dependencies = {
    --   "jose-elias-alvarez/null-ls.nvim",
    --     config = function()
    --       require "configs.null-ls"
    --     end,
    -- },
  },
  { "editorconfig/editorconfig-vim" },
  { "kdheepak/lazygit.nvim", lazy = false },
  { "simrat39/rust-tools.nvim" },
  { "nvim-treesitter/nvim-treesitter", opts = plugin_conf.treesitter },
  { "nvim-tree/nvim-tree.lua", opts = plugin_conf.nvimtree },
  { "hrsh7th/nvim-cmp", opts = plugin_conf.cmp() },
  { "mfussenegger/nvim-jdtls" },
  {
    "williamboman/mason.nvim",
    opts = plugin_conf.mason,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require "configs.dap"
    end,
  },
  { "cshuaimin/ssr.nvim" },
}
