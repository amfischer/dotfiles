-- local separator = { '|', color = 'StatusLineNonText' }

require('lualine').setup({
  options = {
    section_separators = '',
    globalstatus = true,
    component_separators = '',
    theme = 'material-stealth', 
    -- theme = {
    --   normal = {
    --     a = 'StatusLine',
    --     b = 'StatusLine',
    --     c = 'StatusLine',
    --   },
    -- },
  },
  sections = {
    lualine_a = {
      'mode',
    },
    lualine_b = {
      'branch',
      'diff',
      '"🖧  " .. tostring(#vim.tbl_keys(vim.lsp.buf_get_clients()))',
      { 'diagnostics', sources = { 'nvim_diagnostic' } },
    },
    lualine_c = {
      'filename'
    },
    lualine_x = {
      'filetype',
      'encoding',
      'fileformat',
    },
    lualine_y = {
      '(vim.bo.expandtab and "␠ " or "⇥ ") .. " " .. vim.bo.shiftwidth',
    },
    lualine_z = {
      'location',
      'progress',
    },
  },
})
