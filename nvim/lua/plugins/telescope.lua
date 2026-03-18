-- Fuzzy finder
-- https://github.com/nvim-telescope/telescope.nvim

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    config = function()
        -- See `:help telescope.builtin`
        local builtin = require "telescope.builtin"
        local actions = require "telescope.actions"
        local action_state = require "telescope.actions.state"

        require("telescope").setup {
            defaults = {
                path_display = { truncate = 1 },
                selection_caret = "  ",
                layout_config = {
                    prompt_position = "top",
                },
                sorting_strategy = "ascending",
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                        ["<C-Down>"] = actions.cycle_history_next,
                        ["<C-Up>"] = actions.cycle_history_prev,
                    },
                },
                file_ignore_patterns = { ".git/" },
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
                    prompt_title = "History",
                    only_cwd = true,
                    previewer = false,
                    -- history = {
                    --     limit = 5,
                    -- },
                    layout_config = {
                        width = 80,
                    },
                },
                help_tags = {
                    previewer = false,
                },
            },
            extensions = {
                ["ui-select"] = { require("telescope.themes").get_dropdown() },
            },
        }

        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "live_grep_args")
        pcall(require("telescope").load_extension, "ui-select")

        vim.keymap.set("n", "<A-n>", builtin.find_files)
        vim.keymap.set("n", "<A-h>", builtin.oldfiles)
        vim.keymap.set("n", "<A-m>", builtin.lsp_document_symbols)
        vim.keymap.set("n", "<leader>h", builtin.help_tags)

        -- https://github.com/nvim-telescope/telescope.nvim/issues/621
        vim.keymap.set("n", "<A-b>", function()
            builtin.buffers {
                initial_mode = "normal",
                attach_mappings = function(prompt_bufnr, map)
                    local delete_buf = function()
                        local current_picker = action_state.get_current_picker(prompt_bufnr)
                        current_picker:delete_selection(function(selection) vim.api.nvim_buf_delete(selection.bufnr, { force = true }) end)
                    end

                    map("n", "<c-d>", delete_buf)

                    return true
                end,
            }
        end)

        -- find directory and open in oil.nvim, see https://github.com/stevearc/oil.nvim/issues/647
        -- make sure fd-find is installed
        vim.keymap.set("n", "<leader>fd", function()
            require("telescope.builtin").find_files {
                find_command = { "fdfind", "--type", "d", "--hidden", "--exclude", ".git" },
                previewer = false,
                attach_mappings = function(prompt_bufnr)
                    actions.select_default:replace(function()
                        local selection = action_state.get_selected_entry()
                        actions.close(prompt_bufnr)
                        if selection then require("oil").open(selection[1]) end
                    end)
                    return true
                end,
            }
        end, { desc = "Find directory and open in oil" })

        vim.keymap.set(
            "n",
            "<A-N>",
            function()
                builtin.find_files {
                    no_ignore = true,
                    prompt_title = "All Files",
                }
            end
        )

        vim.keymap.set("n", "<leader>g", function() require("telescope").extensions.live_grep_args.live_grep_args() end)
    end,
}
