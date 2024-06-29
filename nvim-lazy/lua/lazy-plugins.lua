-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
    -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).

    -- Commenting support.
    -- 'tpope/vim-commentary',

    -- Add, change, and delete surrounding text.
    'tpope/vim-surround',

    -- Useful commands like :Rename and :SudoWrite.
    'tpope/vim-eunuch',

    -- Pairs of handy bracket mappings, like [b and ]b.
    'tpope/vim-unimpaired',

    -- Indent autodetection with editorconfig support.
    'tpope/vim-sleuth',

    -- Allow plugins to enable repeating of commands.
    'tpope/vim-repeat',

    -- NOTE: Plugins can also be added by using a table,
    -- with the first argument being the link and the following
    -- keys can be used to configure plugin behavior/loading/etc.
    --
    -- Use `opts = {}` to force a plugin to be loaded.
    --
    --  This is equivalent to:
    --    require('Comment').setup({})

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },

    -- Git commands.
    {
        'tpope/vim-fugitive',
        dependencies = { 'tpope/vim-rhubarb' },
        config = function()
            -- vim.keymap.set('n', '<A-g>', ':Git<CR>')
            vim.keymap.set('n', '<A-g>', function()
                vim.cmd('Git')
                vim.cmd('execute "normal \\<C-W>o"')
            end)
        end,
    },

    -- See `:help gitsigns` to understand what the configuration keys do
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
        config = function(_, opts)
            require('gitsigns').setup(opts)

            vim.keymap.set('n', ']h', ':Gitsigns next_hunk<CR>')
            vim.keymap.set('n', '[h', ':Gitsigns prev_hunk<CR>')
            vim.keymap.set('n', 'gs', ':Gitsigns stage_hunk<CR>')
            vim.keymap.set('n', 'gu', ':Gitsigns undo_stage_hunk<CR>')
            vim.keymap.set('n', 'gp', ':Gitsigns preview_hunk<CR>')
            vim.keymap.set('n', 'gb', ':Gitsigns blame_line<CR>')
        end,
    },

    {
        'airblade/vim-rooter',
        config = function()
            -- Instead of this running every time we open a file, we'll just run it once when Vim starts.
            vim.g.rooter_manual_only = 1
            vim.cmd('Rooter')
        end
    },

    {
        'akinsho/toggleterm.nvim',
        version = "*",
        opts = {
            open_mapping = [[<F1>]],
            direction = 'float'
        }
    },

    {
        'dense-analysis/ale',
        config = function()
            vim.g.ale_fixers = {
                javascript = {'prettier'},
                vue = {'prettier'},
            }
            vim.g.ale_linters = {
              php = {},
              javascript = {'eslint'},
              vue = {'eslint'},
              css = {},
            }
            vim.g.ale_disable_lsp = 1
        end
    },

    {
        'lukas-reineke/indent-blankline.nvim',
        main = "ibl",
        opts = {
            whitespace = { highlight = { "Whitespace", "NonText" } },
        }
    },

    require 'plugins/vim-tmux-navigator',

    require 'plugins/oil',

    require 'plugins/telescope',

    require 'plugins/treesitter',

    require 'plugins/tokyonight',

    require 'plugins/lualine',

}, {
    ui = {
        -- If you are using a Nerd Font: set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            cmd = '?',
            config = '??',
            event = '??',
            ft = '??',
            init = '?',
            keys = '??',
            plugin = '??',
            runtime = '??',
            require = '??',
            source = '??',
            start = '??',
            task = '??',
            lazy = '?? ',
        },
    },
})

-- vim: ts=2 sts=2 sw=2 et
