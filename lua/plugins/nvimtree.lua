local map = require("core.utils").map

local present, nvimtree = pcall(require, "nvim-tree")
if not present then
   return
end

local g = vim.g

vim.o.termguicolors = true

g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
g.nvim_tree_git_hl = 1
g.nvim_tree_highlight_opened_files = 0
g.nvim_tree_root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }
--
g.nvim_tree_show_icons = {
   folders = 1,
   folder_arrows = 1,
   files = 1,
   git = 1,
}

g.nvim_tree_icons = {
   default = "",
   symlink = "",
   git = {
      deleted = "",
      ignored = "◌",
      renamed = "➜",
      staged = "✓",
      unmerged = "",
      unstaged = "✗",
      untracked = "★",
   },
   folder = {
      arrow_open = "",
      arrow_closed = "",
      default = "",
      empty = "", -- 
      empty_open = "",
      open = "",
      symlink = "",
      symlink_open = "",
   },
}

nvimtree.setup {
   auto_reload_on_write = true,
   disable_netrw = false,
   hijack_cursor = false,
   hijack_netrw = true,
   hijack_unnamed_buffer_when_opening = false,
   ignore_buffer_on_setup = false,
   open_on_setup = false,
   open_on_setup_file = false,
   open_on_tab = false,
   sort_by = "name",
   update_cwd = false,
   view = {
      width = 40,
      height = 30,
      hide_root_folder = false,
      side = "left",
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = "yes",
      mappings = {
         custom_only = false,
         list = {
            -- user mappings go here
         },
      },
   },
   renderer = {
      indent_markers = {
         enable = false,
         icons = {
            corner = "└ ",
            edge = "│ ",
            none = "  ",
         },
      },
      icons = {
         webdev_colors = true,
      },
   },
   hijack_directories = {
      enable = true,
      auto_open = true,
   },
   update_focused_file = {
      enable = false,
      update_cwd = false,
      ignore_list = {},
   },
   ignore_ft_on_setup = {},
   system_open = {
      cmd = "",
      args = {},
   },
   diagnostics = {
      enable = false,
      show_on_dirs = false,
      icons = {
         hint = "",
         info = "",
         warning = "",
         error = "",
      },
   },
   filters = {
      dotfiles = false,
      custom = {},
      exclude = {},
   },
   git = {
      enable = true,
      ignore = false,
      timeout = 400,
   },
   actions = {
      use_system_clipboard = true,
      change_dir = {
         enable = true,
         global = false,
         restrict_above_cwd = false,
      },
      open_file = {
         quit_on_open = false,
         resize_window = false,
         window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
               filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
               buftype = { "nofile", "terminal", "help" },
            },
         },
      },
   },
   trash = {
      cmd = "trash",
      require_confirm = true,
   },
   log = {
      enable = false,
      truncate = false,
      types = {
         all = false,
         config = false,
         copy_paste = false,
         diagnostics = false,
         git = false,
         profile = false,
      },
   },
}

map("n", "<leader>tm", ":NvimTreeResize -5<CR>")
map("n", "<leader>tp", ":NvimTreeResize +5<CR>")
