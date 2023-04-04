-- local separator = { '|', color = 'StatusLineNonText' }
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
