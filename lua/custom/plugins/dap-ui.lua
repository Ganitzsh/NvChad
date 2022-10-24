local present, dapui = pcall(require, "dapui")

if not present then
  return
end

local nt_api = require "nvim-tree.api"
local nt_view = require "nvim-tree.view"

local M = {}

local opened = false

M.toggle = function()
  if opened == false and nt_view.is_visible() then
    nt_api.tree.close()
  else
    nt_api.tree.open()
  end

  dapui.toggle()

  opened = not opened
end

return M
