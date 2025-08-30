-- File explorer
-- https://github.com/stevearc/oil.nvim

return {
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup()
            vim.keymap.set("n", "<A-o>", ":Oil<CR>")
        end,
    },
}
