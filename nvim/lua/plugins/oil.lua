-- File explorer
-- https://github.com/stevearc/oil.nvim

return {
    {
        "stevearc/oil.nvim",
        enabled = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<A-o>", ":Oil<CR>", desc = "Open Oil file explorer" },
        },
        opts = {},
    },
}
