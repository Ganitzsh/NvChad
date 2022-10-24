-- spell-checker: disable

local present, cmp = pcall(require, "cmp")

local lspkind = require "lspkind"
if not present then
  return
end

vim.opt.completeopt = "menuone,noselect"
cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  -- style = {
  --    winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
  -- },
  formatting = {
    -- format = lspkind.cmp_format { with_text = true, maxwidth = 50 },
    format = function(entry, vim_item)
      if entry.source.name == "copilot" then
        vim_item.kind = "[] Copilot"
        vim_item.kind_hl_group = "CmpItemKindCopilot"
        return vim_item
      end
      return lspkind.cmp_format { with_text = true, maxwidth = 50 }(entry, vim_item)
    end,
  },
  window = {
    completion = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      scrollbar = "║",
      -- winhighlight = "Normal:CmpMenu,FloatBorder:CmpMenuBorder,CursorLine:CmpSelection,Search:None",
      autocomplete = {
        require("cmp.types").cmp.TriggerEvent.InsertEnter,
        require("cmp.types").cmp.TriggerEvent.TextChanged,
      },
    },
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      -- winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      scrollbar = "║",
    },
  },
  mapping = {
    ["<PageUp>"] = function()
      for _ = 1, 10 do
        cmp.mapping.select_prev_item()(nil)
      end
    end,
    ["<PageDown>"] = function()
      for _ = 1, 10 do
        cmp.mapping.select_next_item()(nil)
      end
    end,
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-s>"] = cmp.mapping.complete {
      config = {
        sources = {
          { name = "copilot" },
        },
      },
    },
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
      else
        fallback()
      end
    end,
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
  sources = {
    { name = "copilot", group_index = 2 },
    { name = "nvim_lsp", group_index = 2 },
    { name = "path", group_index = 2 },
    { name = "orgmode", group_index = 2 },
    { name = "neorg", group_index = 2 },
    { name = "luasnip", group_index = 2 },
    { name = "buffer", group_index = 5 },
    -- { name = "nvim_lua", group_index = 2 },
  },
  sorting = {
    comparators = {
      cmp.config.compare.recently_used,
      cmp.config.compare.offset,
      cmp.config.compare.score,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  preselect = cmp.PreselectMode.Item,
}

--set max height of items
vim.cmd [[ set pumheight=6 ]]
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
