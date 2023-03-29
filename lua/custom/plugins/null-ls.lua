-- spell-checker: disable

local ok, null_ls = pcall(require, "null-ls")

if not ok then
  return
end

local formatters = require "custom.plugins.formatters"

local b = null_ls.builtins

local eslint_files = {
  ".eslintrc",
  ".eslintrc.json",
  ".eslintrc.yaml",
  ".eslintrc.yml",
  ".eslintrc.js",
  ".eslintrc.cjs",
  ".eslintrc.mjs",
  ".eslintrc.ts",
}

local cspell_files = {
  ".cspell.json",
  ".cspell.yaml",
  ".cspell.yml",
}

local prettier_files = {
  ".prettierrc",
  ".prettierrc.json",
  ".prettierrc.yaml",
  ".prettierrc.yml",
  ".prettierrc.js",
  ".prettierrc.cjs",
  ".prettierrc.mjs",
  ".prettierrc.ts",
  "prettier.config.js",
  "prettier.config.cjs",
  "prettier.config.mjs",
  "prettier.config.ts",
}

local sources = {
  b.diagnostics.cspell.with {
    condition = function(utils)
      return utils.root_has_file(cspell_files)
    end,
  },

  b.formatting.buf,
  b.diagnostics.buf,

  b.formatting.rustfmt,

  -- JS html css stuff
  b.formatting.deno_fmt.with {
    -- condition = function(utils)
    --   return utils.root_has_file_matches "deno*"
    -- end,

    filetypes = { "typescript", "typescriptreact", "typescript.tsx", "markdown" },
  },

  -- b.diagnostics.eslint.with {
  b.diagnostics.eslint_d.with {
    condition = function(utils)
      return utils.root_has_file(eslint_files)
    end,
  },
  -- b.diagnostics.eslint.with {
  b.code_actions.eslint_d.with {
    condition = function(utils)
      return utils.root_has_file(eslint_files)
    end,
  },

  b.formatting.prettierd.with {
    condition = function(utils)
      return utils.root_has_file(prettier_files)
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
