-- Neovim's answer to the mouse
-- https://github.com/ggandor/leap.nvim

return {
    url = "https://codeberg.org/andyg/leap.nvim",
    config = function()
        require("leap").set_default_mappings()
    end,
}
