return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'nvim-telescope/telescope-live-grep-args.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        }
    },
    config = function()
        local actions = require('telescope.actions')

        require('telescope').setup {
            -- You can put your default mappings / updates / etc. in here
            --  All the info you're looking for is in `:help telescope.setup()`
            --
            defaults = {
                path_display = { truncate = 1 },
                selection_caret = '  ',
                layout_config = {
                    prompt_position = 'top',
                },
                sorting_strategy = 'ascending',
                mappings = {
                    i = {
                        ['<esc>'] = actions.close,
                        ['<C-Down>'] = actions.cycle_history_next,
                        ['<C-Up>'] = actions.cycle_history_prev,
                    },
                },
                file_ignore_patterns = { '.git/' },
                border = true,
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
                buffers = {
                    previewer = false,
                    sort_lastused = true,
                    layout_config = {
                        width = 80,
                    },
                },
                oldfiles = {
                    prompt_title = 'History',
                    only_cwd = true,
                    previewer = false,
                    -- history = {
                    --     limit = 5,
                    -- },
                    layout_config = {
                        width = 80,
                    },
                },
                lsp_references = {
                    previewer = false,
                },
            },
            -- extensions = {},
        }
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'live_grep_args')

        -- See `:help telescope.builtin`
        local builtin = require 'telescope.builtin'
        local action_state = require 'telescope.actions.state'
        vim.keymap.set('n', '<A-n>', builtin.find_files)
        vim.keymap.set('n', '<A-h>', builtin.oldfiles)
        vim.keymap.set('n', '<A-m>', builtin.lsp_document_symbols)

        -- https://github.com/nvim-telescope/telescope.nvim/issues/621
        vim.keymap.set('n', '<A-b>', function()
            builtin.buffers {
                initial_mode = 'normal',
                attach_mappings = function(prompt_bufnr, map)
                    local delete_buf = function()
                        local current_picker = action_state.get_current_picker(prompt_bufnr)
                            current_picker:delete_selection(function(selection)
                                vim.api.nvim_buf_delete(selection.bufnr, { force = true })
                        end)
                    end

                    map('n', '<c-d>', delete_buf)

                    return true
                end
            }
        end)

        vim.keymap.set('n', '<A-N>', function()
            builtin.find_files { 
                no_ignore = true,
                prompt_title = 'All Files' 
            }
        end)

        vim.keymap.set('n', '<leader>g', function()
            require('telescope').extensions.live_grep_args.live_grep_args()
        end)

    end,
}
