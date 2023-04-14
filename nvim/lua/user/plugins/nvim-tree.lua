require('nvim-tree').setup({
  git = {
    ignore = false,
  },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        folder_arrow = true,
      },
    },
    indent_markers = {
      enable = true,
    },
  },
  hijack_directories = {
    enable = true,
    auto_open = false,
  },
})

vim.keymap.set('n', '<Leader>n', ':NvimTreeToggle<CR>')
