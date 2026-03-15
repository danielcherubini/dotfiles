local plugin_conf = require "configs.overrides"

return {
  { "nvchad/volt", lazy = true },
  { "nvchad/menu", lazy = true },
  {
    "olimorris/codecompanion.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      strategies = {
        chat = { adapter = "claude_code" },
        inline = { adapter = "claude_code" },
      },
      adapters = {
        claude_code = function()
          return require("codecompanion.adapters").extend "claude_code"
        end,
      },
      opts = {
        log_level = "ERROR",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "schrieveslaach/sonarlint.nvim",
    url = "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    lazy = false,
  },
  { "nvimdev/lspsaga.nvim", lazy = true },
  { "kdheepak/lazygit.nvim", lazy = false },
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
  },
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
    opts = {},
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
      ["neotest-java"] = {},
    },
  },
}
