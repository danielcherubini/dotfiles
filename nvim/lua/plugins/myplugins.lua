local plugin_conf = require "configs.overrides"

return {
  { "editorconfig/editorconfig-vim" },
  { "kdheepak/lazygit.nvim", lazy = false },
  { "simrat39/rust-tools.nvim" },
  { "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "configs.null-ls"
        end,
    },

    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  { "nvim-treesitter/nvim-treesitter",
    opts = plugin_conf.treesitter
  },
  { "nvim-tree/nvim-tree.lua",
    opts = plugin_conf.nvimtree
  },
  { "hrsh7th/nvim-cmp",
    opts = plugin_conf.cmp()
  },
  { "williamboman/mason.nvim",
    opts = plugin_conf.mason
  },
  { "cshuaimin/ssr.nvim" },
}
