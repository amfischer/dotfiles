-- Lightweight formatter runner
-- https://github.com/stevearc/conform.nvim

return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    dependencies = {
        {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            dependencies = { "mason-org/mason.nvim" },
            opts = {
                ensure_installed = {
                    "blade-formatter",
                    "pint",
                    "prettierd",
                    "stylua",
                },
            },
        },
    },
    keys = {
        {
            "<A-p>",
            function()
                require("conform").format { async = true, lsp_format = "fallback" }
            end,
            mode = { "n", "v" },
            desc = "Conform: format buffer",
        },
    },
    opts = {
        format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
        },
        formatters_by_ft = {
            antlers = { "prettier" },
            blade = { "blade-formatter" },
            css = { "prettierd", "prettier", stop_after_first = true },
            html = { "prettierd", "prettier", stop_after_first = true },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            json = { "prettierd", "prettier", stop_after_first = true },
            jsonc = { "prettierd", "prettier", stop_after_first = true },
            lua = { "stylua" },
            php = { "pint" },
            scss = { "prettierd", "prettier", stop_after_first = true },
            vue = { "prettierd", "prettier", stop_after_first = true },
        },
    },
}
