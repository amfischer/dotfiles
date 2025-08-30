-- Colorscheme
-- https://github.com/folke/tokyonight.nvim

-- To see what colorschemes are already installed, try `:Telescope colorscheme`.

return {
    "folke/tokyonight.nvim",
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
        -- style options include 'tokyonight-storm', 'tokyonight-moon', and 'tokyonight-day'.
        vim.cmd.colorscheme("tokyonight-storm")
    end,
}
-- vim: ts=2 sts=2 sw=2 et
