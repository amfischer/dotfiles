return {
    "akinsho/bufferline.nvim",
    enabled = true,
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
        options = {
            separator_style = "slant",
            mode = "tabs",
        },
    },
    config = function(_, opts)
        require("bufferline").setup(opts)

        vim.keymap.set("n", "<A-9>", ":BufferLineCyclePrev<CR>")
        vim.keymap.set("n", "<A-0>", ":BufferLineCycleNext<CR>")
        vim.keymap.set("n", "<A-(>", ":BufferLineMovePrev<CR>")
        vim.keymap.set("n", "<A-)>", ":BufferLineMoveNext<CR>")
    end,
}
