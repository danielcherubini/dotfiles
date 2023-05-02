local plugin_conf = require "custom.overrides"

return {
  { "editorconfig/editorconfig-vim" },
  { "kdheepak/lazygit.nvim", lazy = false },
  { "simrat39/rust-tools.nvim" },
  { "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.null-ls"
        end,
    },

    config = function()
      require "plugins.configs.lspconfig"
      require "custom.lspconfig"
    end,
  },
  { "nvim-treesitter/nvim-treesitter",
    opts = plugin_conf.treesitter
  },
  { "nvim-tree/nvim-tree.lua",
    opts = plugin_conf.nvimtree
  },
  { "hrsh7th/nvim-cmp",
    opts = plugin_conf.cmp
  },
  { "williamboman/mason.nvim",
    opts = plugin_conf.mason
  },
  { "cshuaimin/ssr.nvim" },
}
