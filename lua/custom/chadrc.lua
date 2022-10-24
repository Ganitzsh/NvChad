-- spell-checker: disable

local M = {}

M.options, M.ui, M.mappings, M.plugins = {}, {}, {}, {}

M.mappings = require "custom.mappings"

M.options = {
  ignorecase = false,
  noignorecase = true,
}

M.ui = {
  theme = "nightfox",
}

M.plugins = require "custom.plugins"

return M
