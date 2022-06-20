vim.cmd [[command! CmpStatus lua require('cmp').status()]]

vim.cmd [[ au BufRead,BufNewFile *.pug setlocal filetype=pug ]]
-- vim.cmd [[ au BufWritePre *.ts lua vim.lsp.buf.formatting_sync() ]]

vim.g.markdown_fenced_languages = {
   "ts=typescript",
}
