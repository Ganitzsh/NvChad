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

   local hasFormatter = M.has_nls_formatter(filetype)
   local enable = false
   if M.has_nls_formatter(filetype) then
      enable = client.name == "null-ls"
   else
      enable = not (client.name == "null-ls")
   end

   vim.notify(
      "Client = " .. client.name .. ", enabled = " .. tostring(enable) .. ", has null-ls formatter = " .. tostring(hasFormatter),
      vim.log.levels.INFO
   )

   client.resolved_capabilities.document_formatting = enable
   client.resolved_capabilities.document_range_formatting = enable

   if client.resolved_capabilities.document_formatting then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
         group = augroup,
         buffer = bufnr,
         callback = function()
            -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
            vim.lsp.buf.formatting_sync()
         end,
      })
   end
end

return M
