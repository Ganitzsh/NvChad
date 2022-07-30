local M = {}

M.nvimtree = {
   n = {
      ["<leader>tm"] = { "<cmd> NvimTreeResize -5 <CR>", "?   resizes -5" },
      ["<leader>tp"] = { "<cmd> NvimTreeResize +5 <CR>", "?   resizes -5" },
   },
}

M.global = {
   n = {
      ["gd"] = { "<cmd> lua vim.lsp.buf.definition() <CR>", "?   trigger LSP formatting" },
      ["<leader>fm"] = { "<cmd> lua vim.lsp.buf.formatting() <CR>", "?   trigger LSP formatting" },
      ["<leader>cc"] = { "<cmd> Telescope <CR>", "?   runs Telescope" },
      ["<leader>q"] = { "<cmd> q <CR>", "?   quits current window" },
      ["<leader>d"] = { "<cmd> TroubleToggle <CR>", "?   toggles Trouble" },
      ["<leader>dd"] = { "<cmd> lua vim.diagnostic.open_float() <CR>", "?   toggles local troubleshoot" },
      ["<leader>x"] = { "<cmd> BufDel <CR>", "?   closes the current buffer" },
      ["<leader>/"] = { "gcc", "?   comments selection" },
   },
}

return M
