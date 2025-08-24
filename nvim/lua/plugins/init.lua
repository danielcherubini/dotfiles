local plugin_conf = require "configs.overrides"
local gemini_code = require "configs.geminicode"
local copilot_config = require "configs.copilotcode"

-- Determine the 'lazy' status for gemini.nvim based on GEMINI_API_KEY
local is_gemini_api_key_present = not (os.getenv "GEMINI_API_KEY" == nil or os.getenv "GEMINI_API_KEY" == "")

return {
  { "nvchad/volt", lazy = true },
  { "nvchad/menu", lazy = true },
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
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
    dependencies = {
      "https://gitlab.com/schrieveslaach/sonarlint.nvim",
      "nvimdev/lspsaga.nvim",
    },
    -- dependencies = {
    --    "jose-elias-alvarez/null-ls.nvim",
    --      config = function()
    --        require "configs.null-ls"
    --      end,
    -- },
  },
  { "editorconfig/editorconfig-vim" },
  { "kdheepak/lazygit.nvim", lazy = false },
  -- { "simrat39/rust-tools.nvim" },
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false, -- This plugin is already lazy}
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
