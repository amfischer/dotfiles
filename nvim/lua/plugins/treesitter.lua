-- Highlight, edit, and navigate code
-- https://github.com/nvim-treesitter/nvim-treesitter

return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        branch = "main",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
            { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
            "windwp/nvim-ts-autotag",
        },
        config = function()
            require("nvim-treesitter").setup {}

            require("nvim-treesitter").install {
                "bash",
                "blade",
                "caddy",
                "comment",
                "css",
                "diff",
                "dockerfile",
                "git_config",
                "git_rebase",
                "gitattributes",
                "gitcommit",
                "gitignore",
                "glimmer",
                "html",
                "http",
                "ini",
                "javascript",
                "json",
                "lua",
                "make",
                "markdown",
                "nginx",
                "markdown_inline",
                "php",
                "php_only",
                "phpdoc",
                "regex",
                "ruby",
                "scss",
                "sql",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "vue",
                "xml",
                "yaml",
            }

            -- Treesitter indentation (highlighting is automatic in Neovim 0.11+)
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })

            -- Textobjects (replaces textobjects opts)
            require("nvim-treesitter-textobjects").setup {
                select = {
                    lookahead = true,
                },
            }

            vim.keymap.set({ "x", "o" }, "if", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
            end)

            vim.keymap.set({ "x", "o" }, "af", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
            end)

            vim.keymap.set({ "x", "o" }, "ia", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
            end)

            vim.keymap.set({ "x", "o" }, "aa", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
            end)

            -- Autotag (replaces autotag opts)
            require("nvim-ts-autotag").setup()
        end,
    },
}
-- vim: ts=2 sts=2 sw=2 et
