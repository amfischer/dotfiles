local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').reset()
require('packer').init({
  compile_path = vim.fn.stdpath('data')..'/site/plugin/packer_compiled.lua',
  -- display = {
  --   open_fn = function()
  --     return require('packer.util').float({ border = 'solid' })
  --   end,
  -- },
})

local use = require('packer').use

-- Packer can manage itself.
use('wbthomason/packer.nvim')

-- vim.api.nvim_create_autocmd("ColorScheme", {
--   pattern = "*",
--   callback = function()
--     vim.api.nvim_set_hl(0, 'FloatBorder', {
--       fg = vim.api.nvim_get_hl_by_name('StatusLine', true).background,
--       bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background,
--     })
--   end,
-- })

-- Color scheme: catppuccin
-- use('catppuccin/nvim')
-- vim.cmd.colorscheme "catppuccin"

-- use ('Yazeed1s/minimal.nvim')
-- use ('tanvirtin/monokai.nvim')
-- use ('mhartington/oceanic-next')
-- use ('marko-cerovac/material.nvim')

-- Color scheme 
use({
  'marko-cerovac/material.nvim',
  setup = function()
    lualine_style = "stealth"
    plugins = {
      "nvim-tree",
      "nvim-web-devicons",
      "telescope"
    }
    -- contrast = {
    --   floating_windows = true
    -- }
  end,
  config = function()
    vim.g.material_style = "oceanic" 
    vim.cmd('colorscheme material')

    vim.api.nvim_set_hl(0, 'NormalFloat', {
      -- fg = vim.api.nvim_get_hl_by_name('NonText', true).foreground,
      bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background,
    })

    vim.api.nvim_set_hl(0, 'FloatBorder', {
      fg = vim.api.nvim_get_hl_by_name('StatusLine', true).background,
      bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background,
    })

    vim.cmd('highlight FloatBorder guifg=#b0bec5 guibg=#314549')
    -- Make the cursor line background invisible
    -- vim.api.nvim_set_hl(0, 'CursorLineBg', {
    --   fg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
    --   bg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
    -- })

    -- vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = '#30323E' })
    vim.api.nvim_set_hl(0, 'DiffAdd', { cterm = none })
    vim.api.nvim_set_hl(0, 'DiffDelete', { cterm = none })

    vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#2F313C' })
  end
})

use('tpope/vim-eunuch')

-- Commenting support.
use('tpope/vim-commentary')

-- Add, change, and delete surrounding text.
use('tpope/vim-surround')

-- Useful commands like :Rename and :SudoWrite.
-- use('tpope/vim-eunuch')

-- Pairs of handy bracket mappings, like [b and ]b.
use('tpope/vim-unimpaired')

-- Indent autodetection with editorconfig support.
use('tpope/vim-sleuth')

-- Allow plugins to enable repeating of commands.
use('tpope/vim-repeat')

-- Add more languages.
use('sheerun/vim-polyglot')

-- Navigate seamlessly between Vim windows and Tmux panes.
use('christoomey/vim-tmux-navigator')

-- Jump to the last location when opening a file.
use('farmergreg/vim-lastplace')

-- Enable * searching with visually selected text.
use('nelstrom/vim-visual-star-search')

-- Automatically create parent dirs when saving.
use('jessarcher/vim-heritage')

-- Text objects for HTML attributes.
use({
  'whatyouhide/vim-textobj-xmlattr',
  requires = 'kana/vim-textobj-user',
})

-- Automatically set the working directory to the project root.
use({
  'airblade/vim-rooter',
  setup = function()
    -- Instead of this running every time we open a file, we'll just run it once when Vim starts.
    vim.g.rooter_manual_only = 1
  end,
  config = function()
    vim.cmd('Rooter')
  end,
})

-- Automatically add closing brackets, quotes, etc.
use({
  'windwp/nvim-autopairs',
  config = function()
    require('nvim-autopairs').setup()
  end,
})

-- Add smooth scrolling to avoid jarring jumps
use({
  'karb94/neoscroll.nvim',
  config = function()
    require('neoscroll').setup()
    -- local t = {}
    -- t['<A-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '250'}}
    -- t['<A-d>'] = {'scroll', {'vim.wo.scroll', 'true', '250'}}
    -- require('neoscroll.config').set_mappings(t)
  end,
})

-- All closing buffers without closing the split window.
-- use({
--   'famiu/bufdelete.nvim',
--   config = function()
--     vim.keymap.set('n', '<Leader>q', ':Bdelete<CR>')
--   end,
-- })

-- Split arrays and methods onto multiple lines, or join them back up.
use({
  'AndrewRadev/splitjoin.vim',
  config = function()
    vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
    vim.g.splitjoin_trailing_comma = 1
    vim.g.splitjoin_php_method_chain_full = 1
  end,
})

-- Automatically fix indentation when pasting code.
use({
  'sickill/vim-pasta',
  config = function()
    vim.g.pasta_disabled_filetypes = { 'fugitive' }
  end,
})

-- Fuzzy finder
use({
  'nvim-telescope/telescope.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope-live-grep-args.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
  },
  config = function()
    require('user/plugins/telescope')
  end,
})

-- File tree sidebar
use({
  'nvim-tree/nvim-tree.lua',
  requires = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('user/plugins/nvim-tree')
  end,
})

-- A Status line.
use({
  'nvim-lualine/lualine.nvim',
  requires = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('user/plugins/lualine')
  end,
})

-- Display buffers as tabs.
-- use({
--   'akinsho/bufferline.nvim',
--   tag = "v3.*",
--   requires = 'nvim-tree/nvim-web-devicons',
  -- after = 'material.nvim',
  -- config = function()
  --   require('user/plugins/bufferline')
  -- end,
-- })

-- Git integration.
use({
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup()
    vim.keymap.set('n', ']h', ':Gitsigns next_hunk<CR>')
    vim.keymap.set('n', '[h', ':Gitsigns prev_hunk<CR>')
    vim.keymap.set('n', 'gs', ':Gitsigns stage_hunk<CR>')
    vim.keymap.set('n', 'gu', ':Gitsigns undo_stage_hunk<CR>')
    vim.keymap.set('n', 'gp', ':Gitsigns preview_hunk<CR>')
    vim.keymap.set('n', 'gb', ':Gitsigns blame_line<CR>')

    -- vim.cmd([[
    --   highlight DiffAdd cterm=none gui=none
    --   highlight DiffDelete cterm=none gui=none
    -- ]])
    --
    -- vim.cmd('highlight DiffDelete cterm=none gui=none')
    -- vim.api.nvim_set_hl(0, 'DiffAdd', { ctermfg = 'none', ctermbg = 'none', fg = '#c3e88d' })
    -- vim.api.nvim_set_hl(0, 'DiffDelete', { cterm = 'none', fg = '#f07178' })
  end,
})

-- Git commands.
use({
  'tpope/vim-fugitive',
  requires = 'tpope/vim-rhubarb',
  config = function()
    vim.keymap.set('n', '<A-g>', ':Git<CR>')
  end,
})

-- Floating terminal
use({
  'voldikss/vim-floaterm',
  config = function()
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
    -- vim.g.floaterm_wintype = 'split'
    vim.keymap.set('n', '<F1>', ':FloatermToggle<CR>')
    vim.keymap.set('t', '<F1>', '<C-\\><C-n>:FloatermToggle<CR>')
    vim.cmd([[
      highlight link Floaterm StatusLine
      " highlight link FloatermBorder StatusLine
    ]])

    vim.api.nvim_set_hl(0, 'FloatermBorder', {
      fg = vim.api.nvim_get_hl_by_name('StatusLine', true).background,
      bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background,
    })
  end
})

-- Improved syntax highlighting
use({
  'nvim-treesitter/nvim-treesitter',
  run = function()
    require('nvim-treesitter.install').update({ with_sync = true })
  end,
  requires = {
    'JoosepAlviste/nvim-ts-context-commentstring',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'windwp/nvim-ts-autotag',
  },
  config = function()
    require('user/plugins/treesitter')
  end,
})

-- Language Server Protocol
use({
  'neovim/nvim-lspconfig',
  requires = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'b0o/schemastore.nvim',
  },
  config = function()
    require('user/plugins/lspconfig')
  end,
})

-- Completion
use({
  'hrsh7th/nvim-cmp',
  requires = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'onsails/lspkind-nvim',
  },
  config = function()
    require('user/plugins/cmp')
  end,
})

-- Line indentation
use({
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    require('ibl').setup({
      -- config = {

        indent = { char = "│" }
      -- }
    })
    show_current_context = true
    show_current_context_start = true
    indent = { char = "│" }
  end,
})

use { 'otavioschwanck/arrow.nvim', config = function()
  require('arrow').setup({
    show_icons = true,
    leader_key = ';' -- Recommended to be a single key
  })
end }


-- use({
--   'dense-analysis/ale',
--   setup = function()
--     vim.g.ale_fixers = {
--       javascript = {'prettier'},
--       vue = {'prettier'},
--       php = {'pint'},
--     }

--     vim.g.ale_lint_on_enter = 0
--     vim.g.ale_lint_on_filetype_changed = 0
--     vim.g.ale_lint_on_insert_leave = 0
--     vim.g.ale_lint_on_save = 0

--     -- can't get pint to use the executable in the docker image
--     -- vim.g.ale_php_pint_use_global = 1
--     -- vim.g.ale_php_pint_executable = '/home/aaron/projects/coid-app/vendor/bin/pint'
--     -- vim.g.ale_filename_mappings = {
--     --   pint = {
--     --     '/home/aaron/projects/coid-app',
--     --     '/var/www/html'
--     --   }
--     -- }
--   end,
--   config = function()
--     vim.keymap.set('n', '<A-p>', ':ALEFix<CR>')
--   end,
-- })


-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if packer_bootstrap then
    require('packer').sync()
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile>
  augroup end
]])
