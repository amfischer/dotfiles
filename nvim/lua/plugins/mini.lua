-- Mini Plugins
-- https://github.com/nvim-mini/mini.nvim

return {
    {
        "echasnovski/mini.nvim",
        version = false, -- use latest
        config = function()
            -- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-bufremove.md
            require("mini.bufremove").setup()
            -- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-misc.md
            require("mini.misc").setup()
        end,
        keys = {
            {
                "<A-w>",
                function()
                    require("mini.bufremove").delete(0, false)
                end,
                desc = "Delete buffer",
            },
            {
                "<leader>bD",
                function()
                    require("mini.bufremove").delete(0, true)
                end,
                desc = "Force delete buffer",
            },
            {
                "<leader>z",
                function()
                    require("mini.misc").zoom()
                end,
                desc = "Zoom window",
            },
        },
    },
}
