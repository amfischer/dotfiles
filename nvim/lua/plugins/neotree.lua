-- Manage the file system and other tree like structures
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    keys = {
        { "<A-o>", ":Neotree reveal float toggle<CR>", desc = "Toggle Neo-tree" },
    },
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
        default_component_configs = {
            icon = {
                folder_closed = "",
                folder_open = "",
                folder_empty = "󰉖",
                folder_empty_open = "󰷏",
                default = "*",
                use_filtered_colors = true,
            },
            git_status = {
                symbols = {
                    -- Change type
                    added = "●", -- NOTE: you can set any of these to an empty string to not show them
                    deleted = "✕",
                    modified = "○",
                    renamed = "➜",
                    -- Status type
                    untracked = "?",
                    ignored = "·",
                    unstaged = "✗",
                    staged = "✓",
                    conflict = "",
                },
            },
        },
        filesystem = {
            hijack_netrw_behavior = "open_current",
        },
    },
}
