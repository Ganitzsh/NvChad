-- spell-checker: disable

local methods = require "null-ls.methods"
local sources = require "null-ls.sources"

local M = {}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

M.has_nls_formatter = function(filetype)
  local available = sources.get_available(filetype, methods.FORMATTING)
  return #available > 0
end

M.setup = function(client, bufnr)
  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

  local enable = false
  if M.has_nls_formatter(filetype) then
    enable = client.name == "null-ls"
  else
    enable = not (client.name == "null-ls")
  end

  client.server_capabilities.document_formatting = enable
  client.server_capabilities.document_range_formatting = enable

  if enable then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      command = "lua vim.lsp.buf.format({ async = true })",
    })
  end
end

return M
