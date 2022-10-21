-- spell-checker: disable

vim.cmd "command! CmpStatus lua require('cmp').status()"
vim.cmd "command! JestRun lua require('jester').debug()"

vim.cmd "au BufRead,BufNewFile *.pug setlocal filetype=pug"

vim.g.markdown_fenced_languages = {
  "ts=typescript",
}
