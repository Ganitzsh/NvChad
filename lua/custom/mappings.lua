-- spell-checker: disable

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
    ["<leader>fm"] = { "<cmd> lua vim.lsp.buf.format({ async = true }) <CR>", "?   trigger LSP formatting" },
    ["<leader>cc"] = { "<cmd> Telescope <CR>", "?   runs Telescope" },
    ["<leader>q"] = { "<cmd> q <CR>", "?   quits current window" },
    ["<leader>d"] = { "<cmd> TroubleToggle <CR>", "?   toggles Trouble" },
    ["<leader>dd"] = { "<cmd> lua vim.diagnostic.open_float() <CR>", "?   toggles local troubleshoot" },
    ["<leader>x"] = { "<cmd> BufDel <CR>", "?   closes the current buffer" },
    ["<leader>/"] = { "gcc", "?   comments selection" },
    ["<leader>bp"] = {
      "<cmd> lua require'dap'.toggle_breakpoint() <CR>",
      "?   dap: toggles breakpoint at current line",
    },
    ["<leader>so"] = { "<cmd> lua require'dap'.step_over() <CR>", "?   dap: steps over" },
    ["<leader>si"] = { "<cmd> lua require'dap'.step_into() <CR>", "?   dap: steps into" },
    ["<leader>db"] = { "<cmd> lua require'dap'.continue() <CR>", "?   dap: start/stop debugging session" },
    ["<leader>dbui"] = {
      "<cmd> lua require'custom.plugins.dap-ui'.toggle() <CR>",
      "?   toggles dap-ui",
    },
  },
}

return M
