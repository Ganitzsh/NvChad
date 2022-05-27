local ok, null_ls = pcall(require, "null-ls")

if not ok then
   return
end

local b = null_ls.builtins

local sources = {
   b.formatting.protolint.with {
      filetypes = { "proto" },
      command = { "protolint" },
   },

   -- JS html css stuff
   b.diagnostics.eslint_d, -- eslint or eslint_d
   b.code_actions.eslint_d,
   b.formatting.prettierd.with {
      filetypes = {
         "html",
         "json",
         "markdown",
         "scss",
         "css",
         "typescript",
         "javascript",
         "javascriptreact",
         "yaml",
      },
   },

   -- Golang
   -- b.formatting.gofumpt,

   -- Lua
   b.formatting.stylua,
   b.diagnostics.luacheck.with { extra_args = { "--global vim" } },

   -- Shell
   b.formatting.shfmt,
   b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

   -- Terraform
   b.formatting.terraform_fmt,
}

local M = {}
M.setup = function()
   null_ls.setup {
      sources = sources,
   }
end

return M
