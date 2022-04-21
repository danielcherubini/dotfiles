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
   status = {
      dashboard = true,
   },
   default_plugin_config_replace = {
     nvim_treesitter = plugin_conf.treesitter,
     nvim_tree = plugin_conf.nvimtree,
     nvim_cmp = plugin_conf.cmp,
   },
   install = userPlugins,
}

return M
