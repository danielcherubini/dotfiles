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
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "rcasia/neotest-java",
    init = function()
      -- override the default keymaps.
      -- needed until neotest-java is integrated in LazyVim
      require("which-key").add {
        { "<leader>t", group = "test" },
        { "<leader>tD", "<cmd>lua require('jdtls.dap').test_class()<cr>", desc = "[Neotest] Debug Test File" },
        {
          "<leader>td",
          "<cmd>lua require('jdtls.dap').test_nearest_method()<cr>",
          desc = "[Neotest] Debug Nearest File",
        },
        { "<leader>tr", "<cmd>lua require('neotest').run.run()<cr>", desc = "[Neotest] Run Nearest Test" },
        {
          "<leader>tt",
          "<cmd>lua require('neotest').run.run(vim.fn.expand '%')<cr>",
          desc = "[Neotest] Run Test File",
        },
      }
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    adapters = {
      ["neotest-java"] = {
        -- config here
      },
    },
  },
}
