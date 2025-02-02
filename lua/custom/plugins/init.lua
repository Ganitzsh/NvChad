return {
  ["f-person/git-blame.nvim"] = {},

  ["nvim-tree/nvim-tree.lua"] = {
    config = function()
      require "custom.plugins.nvimtree"
    end,
  },

  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "custom.plugins.lspconfig"
    end,
  },

  ["williamboman/mason.nvim"] = {
    ensure_installed = {
      "lua-language-server",
      "cspell",
      "deno",
      "eslint_d",
      "prettierd",
      "prisma-language-server",
      "rustfmt",
      "shellcheck",
      "shfmt",
      "stylua",
      "tailwindcss-language-server",
      "typescript-language-server",
      "vue-language-server",
      "yaml-language-server",
      "json-lsp",
      "rust-analyzer",
    },
  },

  ["williamboman/mason-lspconfig.nvim"] = {
    after = { "mason.nvim" },
    ensure_installed = {
      "lua-language-server",
      "cspell",
      "deno",
      "eslint_d",
      "prettierd",
      "prisma-language-server",
      "rustfmt",
      "shellcheck",
      "shfmt",
      "stylua",
      "tailwindcss-language-server",
      "typescript-language-server",
      "vue-language-server",
      "yaml-language-server",
      "json-lsp",
      "rust-analyzer",
    },
    automatic_installation = true,
  },

  ["folke/neodev.nvim"] = {
    config = function() end,
  },

  ["IndianBoy42/tree-sitter-just"] = {},

  ["leoluz/nvim-dap-go"] = {
    after = { "nvim-dap" },
    config = function()
      require("dap-go").setup()
    end,
  },

  ["EdenEast/nightfox.nvim"] = {},

  ["rcarriga/nvim-dap-ui"] = {
    config = function()
      require("dapui").setup()
    end,
  },

  ["theHamsta/nvim-dap-virtual-text"] = {
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },

  ["microsoft/vscode-js-debug"] = {
    opt = true,
    run = "npm install --legacy-peer-deps && npm run compile && git checkout .",
  },

  ["mfussenegger/nvim-dap"] = {
    config = function()
      require("custom.plugins.dap").setup()
    end,
  },

  ["mxsdev/nvim-dap-vscode-js"] = {
    config = function()
      require("custom.plugins.dap-vscode-js").setup()
    end,
  },

  ["David-Kunz/jester"] = {
    config = function()
      require("jester").setup {
        path_to_jest_run = "./node_modules/.bin/jest",
        dap = {
          type = "pwa-node",
          request = "launch",
          cwd = "${workspaceFolder}",
          runtimeArgs = { "--inspect-brk", "$path_to_jest", "--no-coverage", "-t", "$result", "--", "$file" },
          args = { "--no-cache" },
          sourceMaps = true,
          protocol = "inspector",
          skipFiles = { "<node_internals>/**" },
          console = "integratedTerminal",
        },
      }
    end,
  },

  ["eliba2/vim-node-inspect"] = {},

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

  ["hrsh7th/nvim-cmp"] = {
    override_options = {
      sources = {
        { name = "copilot" },
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
      },
    },
  },

  ["zbirenbaum/copilot-cmp"] = {
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
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

  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = {
      ensure_installed = {
        "lua",
        "swift",
        "rust",
        "go",
        "javascript",
        "typescript",
      },
    },
  },
}
