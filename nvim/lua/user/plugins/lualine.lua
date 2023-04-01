local separator = { '|', color = 'StatusLineNonText' }
local custom_oceanic = require'lualine.themes.OceanicNext'

-- custom_oceanic.insert.a.bg = '#343d46'
custom_oceanic.insert.b.bg = '#343d46'

-- custom_oceanic.normal.a.bg = '#343d46'
custom_oceanic.normal.b.bg = '#343d46'

-- custom_oceanic.inactive.a.bg = '#343d46'
custom_oceanic.inactive.b.bg = '#343d46'

-- custom_oceanic.visual.a.bg = '#343d46'
custom_oceanic.visual.b.bg = '#343d46'

-- custom_oceanic.replace.a.bg = '#343d46'
custom_oceanic.replace.b.bg = '#343d46'

require('lualine').setup({
  options = {
    section_separators = '',
    globalstatus = true,
    component_separators = '',
    theme = custom_oceanic, 
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
      separator,
    },
    lualine_b = {
      'branch',
      'diff',
      separator,
      '"🖧  " .. tostring(#vim.tbl_keys(vim.lsp.buf_get_clients()))',
      { 'diagnostics', sources = { 'nvim_diagnostic' } },
      separator,
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
      separator,
      '(vim.bo.expandtab and "␠ " or "⇥ ") .. " " .. vim.bo.shiftwidth',
      separator,
    },
    lualine_z = {
      'location',
      'progress',
    },
  },
})
