local M = {}

local plugin_conf = require "custom.plugins.configs"
local userPlugins = require "custom.plugins"

M.ui = {
   theme = "chadracula",
   hl_override = "custom.highlights",
}

M.plugins = {
   options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig",
      },
   },
   override = {
     ["nvim-treesitter/nvim-treesitter"] = plugin_conf.treesitter,
     ["kyazdani42/nvim-tree.lua"] = plugin_conf.nvimtree,
     ["hrsh7th/nvim-cmp"] = plugin_conf.cmp,
   },
   user = userPlugins,
}

return M
