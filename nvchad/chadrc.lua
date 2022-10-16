local M = {}

M.ui = {
   theme = "chadracula",
   hl_override = require "custom.highlights",
}

M.plugins = require "custom.plugins"
M.mappings = require "custom.mappings"

return M
