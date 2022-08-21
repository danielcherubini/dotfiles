local M = {}

local plugin_conf = require "custom.plugins.configs"
local userPlugins = require "custom.plugins"
local highlights = require "custom.highlights"
local mappings = require "custom.mappings"

M.ui = {
   theme = "chadracula",
   hl_override = highlights,
}

M.plugins = {
   override = {
     ["nvim-treesitter/nvim-treesitter"] = plugin_conf.treesitter,
     ["kyazdani42/nvim-tree.lua"] = plugin_conf.nvimtree,
     ["hrsh7th/nvim-cmp"] = plugin_conf.cmp,
     ["williamboman/mason.nvim"] = {
       ensure_installed = plugin_conf.mason
     },
   },
   user = userPlugins,
}

M.mappings = mappings

return M
