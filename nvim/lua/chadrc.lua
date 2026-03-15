---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "chadracula",
  hl_override = require "configs.highlights",
}

M.mason = { cmd = true, pkgs = require("configs.overrides").mason.pkgs }

return M
