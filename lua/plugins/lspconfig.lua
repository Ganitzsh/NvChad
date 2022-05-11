local M = {}

M.setup_lsp = function(attach, capabilities)
   local lspconfig = require "lspconfig"

   -- lspservers with default config

   local servers = { "html", "cssls", "pyright", "clangd", "yamlls", "tsserver" }

   for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
         on_attach = attach,
         capabilities = capabilities,
         flags = {
            debounce_text_changes = 150,
         },
      }
   end

   -- typescript

   lspconfig.tsserver.setup {
      init_options = require("nvim-lsp-ts-utils").init_options,
      on_attach = function(client, bufnr)
         local ts_utils = require "nvim-lsp-ts-utils"

         -- defaults
         ts_utils.setup {
            debug = false,
            disable_commands = false,
            enable_import_on_completion = false,

            -- import all
            import_all_timeout = 5000, -- ms
            -- lower numbers = higher priority
            import_all_priorities = {
               same_file = 1, -- add to existing import statement
               local_files = 2, -- git files or files with relative path markers
               buffer_content = 3, -- loaded buffer content
               buffers = 4, -- loaded buffer names
            },
            import_all_scan_buffers = 100,
            import_all_select_source = false,
            -- if false will avoid organizing imports
            always_organize_imports = true,

            -- filter diagnostics
            filter_out_diagnostics_by_severity = {},
            filter_out_diagnostics_by_code = { 80001 },

            -- inlay hints
            auto_inlay_hints = true,
            inlay_hints_highlight = "Comment",
            inlay_hints_priority = 200, -- priority of the hint extmarks
            inlay_hints_throttle = 150, -- throttle the inlay hint request
            inlay_hints_format = { -- format options for individual hint kind
               Type = {},
               Parameter = {},
               Enum = {},
               -- Example format customization for `Type` kind:
               -- Type = {
               --     highlight = "Comment",
               --     text = function(text)
               --         return "->" .. text:sub(2)
               --     end,
               -- },
            },

            -- update imports on file move
            watch_dir = nil,

            -- eslint
            eslint_enable_code_actions = true,
            eslint_enable_disable_comments = true,
            eslint_config_fallback = nil,
            eslint_bin = "eslint_d",

            -- eslint diagnostics
            -- eslint_enable_diagnostics = true,
            -- eslint_diagnostics_debounce = 250,
            -- formatting
            enable_formatting = true,
            formatter = "prettierd",
            formatter_args = { "--stdin-filepath", "$FILENAME" },
            format_on_save = false,
            no_save_after_format = false,
            -- parentheses completion
            complete_parens = false,
            signature_help_in_parens = false,

            update_imports_on_move = true,
            require_confirmation_on_move = true,
         }

         -- required to fix code action ranges and filter diagnostics
         ts_utils.setup_client(client)

         local opts = { noremap = true, silent = true }

         vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gs", ":TSLspOrganize<CR>", opts)
         vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

         client.resolved_capabilities.document_formatting = false
         client.resolved_capabilities.document_range_formatting = false
      end,
      capabilities = capabilities,
      cmd = { "typescript-language-server", "--stdio" },
      filetypes = {
         "javascript",
         "javascriptreact",
         "javascript.jsx",
         "typescript",
         "typescriptreact",
         "typescript.tsx",
      },
      -- root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json"),
   }

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

   lspconfig.sumneko_lua.setup(require "custom.plugins.lsp.sumneko_lua")
end

return M
