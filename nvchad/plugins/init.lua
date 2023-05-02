local plugin_conf = require "custom.plugins.overrides"

return {
  { "editorconfig/editorconfig-vim" },
  { "kdheepak/lazygit.nvim" },
  { "simrat39/rust-tools.nvim" },
  { "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  { "jose-elias-alvarez/null-ls.nvim",
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },
  { "nvim-treesitter/nvim-treesitter",
    config = function()
      require "plugin_conf.treesitter"
    end,
  },
  { "kyazdani42/nvim-tree.lua",
    config = function()
      require "plugin_conf.nvimtree"
    end,
  },
  { "hrsh7th/nvim-cmp",
    config = function()
      require "plugin_conf.cmp"
    end,
  },
  { "williamboman/mason.nvim",
    config = function()
      require "plugin_conf.mason"
    end,
  },
  { "cshuaimin/ssr.nvim" },
}
