-- Faster LuaLS setup for Neovim config and plugin development.
-- https://github.com/folke/lazydev.nvim

return {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
        library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            { path = "laravel.nvim", words = { "Laravel" } },
        },
    },
}
