-- Better folding
-- https://github.com/kevinhwang91/nvim-ufo

return {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufReadPost",
    init = function()
        -- UFO needs folds open by default; it provides the closing behavior
        vim.o.foldcolumn = "0"
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
    end,
    opts = {
        provider_selector = function()
            return { "treesitter", "indent" }
        end,
    },
    config = function(_, opts)
        require("ufo").setup(opts)
        vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "UFO: open all folds" })
        vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "UFO: close all folds" })
        vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "UFO: open folds except kinds" })
        vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "UFO: close folds with" })
    end,
}
