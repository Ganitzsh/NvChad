-- spell-checker: disable

local present, nvimtree = pcall(require, "nvim-tree")
if not present then
  return
end

vim.o.termguicolors = true

nvimtree.setup {
  git = {
    ignore = false,
  },
}
