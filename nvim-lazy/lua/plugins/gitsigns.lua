-- Git integration
-- https://github.com/lewis6991/gitsigns.nvim

return {
    "lewis6991/gitsigns.nvim",
    opts = {
        signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
        },
    },
    config = function(_, opts)
        require("gitsigns").setup(opts)

        vim.keymap.set("n", "]h", ":Gitsigns next_hunk<CR>")
        vim.keymap.set("n", "[h", ":Gitsigns prev_hunk<CR>")
        vim.keymap.set("n", "gs", ":Gitsigns stage_hunk<CR>")
        vim.keymap.set("n", "gu", ":Gitsigns undo_stage_hunk<CR>")
        vim.keymap.set("n", "gp", ":Gitsigns preview_hunk<CR>")
        vim.keymap.set("n", "gb", ":Gitsigns blame_line<CR>")
    end,
}
