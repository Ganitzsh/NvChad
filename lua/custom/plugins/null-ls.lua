-- spell-checker: disable

local ok, null_ls = pcall(require, "null-ls")

if not ok then
  return
end

local formatters = require "custom.plugins.formatters"

local b = null_ls.builtins

local sources = {
  b.diagnostics.cspell,

  b.formatting.buf,
  b.diagnostics.buf,

  b.formatting.rustfmt,

  -- JS html css stuff
  b.formatting.deno_fmt.with {
    -- condition = function(utils)
    --   return utils.root_has_file_matches "deno*"
    -- end,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  },

  b.diagnostics.eslint.with {
    -- b.diagnostics.eslint_d.with {
    condition = function(utils)
      return utils.root_has_file { "package.json" }
    end,
  },
  b.diagnostics.eslint.with {
    -- b.code_actions.eslint_d.with {
    condition = function(utils)
      return utils.root_has_file { "package.json" }
    end,
  },

  -- b.diagnostics.eslint,
  -- b.code_actions.eslint,

  b.formatting.prettier.with {
    condition = function(utils)
      return utils.root_has_file { "package.json" }
    end,

    filetypes = {
      "html",
      "json",
      "markdown",
      "scss",
      "css",
      "yaml",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "javascript",
      "javascriptreact",
      "vue",
    },
  },

  -- Golang
  b.formatting.gofumpt,

  -- Lua
  b.formatting.stylua,
  b.diagnostics.luacheck.with { extra_args = { "--global vim" } },

  -- Shell
  b.formatting.shfmt,
  b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

  -- Zig
  b.formatting.zigfmt,

  -- Terraform
  b.formatting.terraform_fmt,
}

local M = {}

M.setup = function()
  null_ls.setup {
    -- on_attach = function(client, bufnr)
    --    formatters.setup(client, bufnr)
    -- end,
    on_attach = function(client, bufnr)
      formatters.setup(client, bufnr)
    end,

    sources = sources,
  }
end

return M
