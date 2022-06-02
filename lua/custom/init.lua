vim.cmd [[command! CmpStatus lua require('cmp').status()]]

vim.cmd [[ au BufRead,BufNewFile *.pug setlocal filetype=pug ]]

vim.g.markdown_fenced_languages = {
   "ts=typescript",
}
