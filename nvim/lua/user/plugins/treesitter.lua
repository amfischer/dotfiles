require('nvim-treesitter.configs').setup({
  ensure_installed = 'all',
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['if'] = '@function.inner',
        ['af'] = '@function.outer',
        ['ia'] = '@parameter.inner',
        ['aa'] = '@parameter.outer',
      },
    }
  },
  autotag = {
    enable = true,
  }
})

vim.g.skip_ts_context_commentstring_module = true

-- add handlebars support for .html files
vim.treesitter.language.register("glimmer", "html")
