local M = {}

M.options, M.ui, M.mappings, M.plugins = {}, {}, {}, {}

M.options = {
   ignorecase = false,
   noignorecase = true,
}

M.ui = {
   theme = "gruvchad",
}


-- NvChad included plugin options & overrides
M.plugins = {
   user = {
      ["onsails/lspkind.nvim"] = {},

      ["ojroques/nvim-bufdel"] = {
         config = function()
            require("bufdel").setup {
               next = "cycle", -- or 'alternate'
               quit = false,
            }
         end,
      },

      ["digitaltoad/vim-pug"] = {},

      ["jparise/vim-graphql"] = {},

      ["hashivim/vim-terraform"] = {},

      ["jose-elias-alvarez/nvim-lsp-ts-utils"] = {},

      -- ["github/copilot.vim"] = {},

      ["zbirenbaum/copilot-cmp"] = {
         after = { "copilot.lua", "nvim-cmp" },
      },

      ["zbirenbaum/copilot.lua"] = {
         event = { "VimEnter" },
         config = function()
            vim.defer_fn(function()
               require("copilot").setup()
            end, 100)
         end,
      },

      ["jose-elias-alvarez/null-ls.nvim"] = {
         after = "nvim-lspconfig",
         config = function()
            require("custom.plugins.null-ls").setup()
         end,
      },

      ["folke/trouble.nvim"] = {
         after = "nvim-lspconfig",
         requires = "kyazdani42/nvim-web-devicons",
         config = function()
            require("trouble").setup()
         end,
      },

      ["kyazdani42/nvim-tree.lua"] = {
         config = function()
            require "custom.plugins.nvimtree"
         end,
      },

      ["hrsh7th/nvim-cmp"] = {
         config = function()
            require "custom.plugins.cmp"
         end,
      },
   },

   options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig",
      },
   },
}

return M
