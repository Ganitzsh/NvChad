local M = {}

M.setup_lsp = function(attach, capabilities)
   local lspconfig = require "lspconfig"
   local formatters = require "custom.plugins.formatters"

   -- lspservers with default config

   local servers = {
      "html",
      "cssls",
      "pyright",
      "clangd",
      "yamlls",
      "tsserver",
      "volar",
   }

   for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
         on_attach = function(client, bufnr)
            attach(client, bufnr)
            formatters.setup(client, bufnr)
         end,
         capabilities = capabilities,
         flags = {
            debounce_text_changes = 150,
         },
      }
   end

   -- typescript

   -- lspconfig.volar.setup {
   --    cmd = { "vls", "--stdio" },
   -- }

   lspconfig.tailwindcss.setup {
      on_attach = attach,
      root_dir = lspconfig.util.root_pattern "tailwind.config.js",
   }

   lspconfig.denols.setup {
      on_attach = attach,
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
      on_attach = attach,
      capabilities = capabilities,
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
end

return M
