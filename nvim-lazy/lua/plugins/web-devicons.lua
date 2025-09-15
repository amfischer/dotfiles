-- Nerd Font icons
-- https://github.com/nvim-tree/nvim-web-devicons

return {
    "nvim-tree/nvim-web-devicons",
    opts = {
        override = {
            ["blade.php"] = {
                icon = "󰫐",
                color = "#f05340",
                cterm_color = "203",
                name = "Blade",
            },
            ["css"] = {
                icon = "",
                color = "#663399",
                cterm_color = "91",
                name = "Css",
            },
        },
    },
}
