-- Configure and manage formatters & linters
-- https://github.com/dense-analysis/ale

return {
    "dense-analysis/ale",
    keys = {
        { "<A-p>", ":ALEFix<CR>", desc = "ALE: fix file" },
    },
    init = function()
        vim.g.ale_fixers = {
            javascript = { "prettier" },
            vue = { "prettier" },
            css = { "prettier" },
            scss = { "prettier" },
            blade = { "prettier" },
            html = { "prettier" },
            lua = { "stylua" },
        }
        vim.g.ale_linters = {
            php = {},
            javascript = { "eslint" },
            vue = {},
            css = {},
            scss = {},
            html = {},
            lua = {},
            markdown = {},
        }
        vim.g.ale_disable_lsp = 1
        vim.g.ale_linters_explicit = 1
    end,
}
