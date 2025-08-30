return {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    config = function()
        vim.keymap.set("n", "<A-g>", function()
            vim.cmd("Git")
            -- expand split to full screen
            -- vim.cmd('execute "normal \\<C-W>o"')
        end)
    end,
}
