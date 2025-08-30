-- Configure and manage formatters & linters
-- https://github.com/dense-analysis/ale

return {
    "dense-analysis/ale",
    init = function()
        vim.g.ale_fixers = {
            javascript = { "prettier" },
            vue = { "prettier" },
            css = { "prettier" },
            blade = { "prettier" },
            html = { "prettier" },
            lua = { "stylua" },
        }
        vim.g.ale_linters = {
            php = {},
            javascript = { "eslint" },
            vue = {},
            css = {},
            lua = {},
        }
        vim.g.ale_disable_lsp = 1
    end,
    config = function()
        vim.keymap.set("n", "<A-p>", ":ALEFix<CR>")
    end,
}
