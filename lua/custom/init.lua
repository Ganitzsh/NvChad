local map = nvchad.map

map("n", "<leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>")
map("n", "<leader>cc", ":Telescope <CR>")
map("n", "<leader>q", ":q <CR>")
map("n", "<leader>d", ":TroubleToggle <CR>")
map("n", "<leader>dd", "<cmd>lua vim.diagnostic.open_float()<CR>")
map("n", "<leader>x", ":BufDel <CR>")
map("v", "<leader>/", "gcc")

vim.cmd [[command! CmpStatus lua require('cmp').status()]]

vim.cmd [[ au BufRead,BufNewFile *.pug setlocal filetype=pug ]]
