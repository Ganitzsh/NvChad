-- spell-checker: disable

local present, lspconfig = pcall(require, "lspconfig")

if not present then
  return
end

local neodevInstalled, neodev = pcall(require, "neodev")

if neodevInstalled then
  neodev.setup()
end

local parentConfig = require "plugins.configs.lspconfig"

local M = {}

-- Servers with default configs

local servers = {
  "html",
  "cssls",
  "pyright",
  "yamlls",
  "tsserver",
  "volar",
  "rust_analyzer",
  "zls",
  "prismals",
  "lua_ls",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = parentConfig.on_attach,
    capabilities = parentConfig.capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }
end

-- Custom configs

-- typescript

lspconfig.tsserver.setup {
  on_attach = parentConfig.on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  root_dir = lspconfig.util.root_pattern "package.json",
}

-- lspconfig.volar.setup {
--    cmd = { "vls", "--stdio" },
-- }

lspconfig.tailwindcss.setup {
  on_attach = parentConfig.on_attach,
  capabilities = parentConfig.capabilities,
  root_dir = lspconfig.util.root_pattern "tailwind.config.js",
}

lspconfig.denols.setup {
  on_attach = parentConfig.on_attach,
  root_dir = lspconfig.util.root_pattern "deno.json",
  init_options = {
    enable = true,
  },
}

-- lspconfig.vuels.setup {
--    on_attach = function(client)
--       client.resolved_capabilities.document_formatting = true
--       attach(client)
--    end,
--    capabilities = capabilities,
--    filetypes = {
--       "vue",
--    },
--    -- settings = {
--    --    vetur = {
--    --       completion = {
--    --          autoImport = true,
--    --          useScaffoldSnippets = true,
--    --       },
--    --       format = {
--    --          defaultFormatter = {
--    --             html = "none",
--    --             js = "prettier",
--    --             ts = "prettier",
--    --          },
--    --       },
--    --       validation = {
--    --          template = true,
--    --          script = true,
--    --          style = true,
--    --          templateProps = true,
--    --          interpolation = true,
--    --       },
--    --       experimental = {
--    --          templateInterpolationService = false,
--    --       },
--    --    },
--    -- },
--    root_dir = lspconfig.util.root_pattern("package.json", "vite.config.js", "tsconfig.json"),
-- }

-- golang

lspconfig.gopls.setup {
  on_attach = parentConfig.on_attach,
  capabilities = parentConfig.capabilities,
  cmd = { "gopls" },
  filetypes = { "golang", "go" },
  root_dir = lspconfig.util.root_pattern "go.mod",
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
      linksInHover = false,
      codelenses = {
        generate = true,
        gc_details = true,
        regenerate_cgo = true,
        tidy = true,
        upgrade_depdendency = true,
        vendor = true,
      },
      usePlaceholders = true,
      experimentalPostfixCompletions = true,
    },
  },
}

return M
