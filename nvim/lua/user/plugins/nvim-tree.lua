local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  -- vim.keymap.set('n', '<LeftRelease>', api.node.open.preview, opts('Open Preview'))
  vim.keymap.set('n', '<LeftRelease>', api.node.open.edit, opts('Open'))
end



require('nvim-tree').setup({
  on_attach = my_on_attach,
  git = {
    ignore = false,
  },
  view = {
    -- float = {
    --   enable = true,
    --   open_win_config = {
    --     width = 60,
    --   },
    -- },
  },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        folder_arrow = true,
        git = false,
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

vim.keymap.set('n', '<Leader>f', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<Leader>F', ':NvimTreeFindFile<CR>')
vim.keymap.set('n', '<Leader>c', ':NvimTreeCollapse<CR>')
-- vim.keymap.set('n', '<LeftRelease>', '[[<cmd>lua require('nvim-tree.api').node.open.edit()<CR>]]')

