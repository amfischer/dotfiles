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

            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    local buf, filetype = args.buf, args.match

                    local language = vim.treesitter.language.get_lang(filetype)
                    if not language then return end

                    -- check if parser exists and load it
                    if not vim.treesitter.language.add(language) then return end
                    -- enables syntax highlighting and other treesitter features
                    vim.treesitter.start(buf, language)

                    -- enables treesitter based folds, see `:help folds`
                    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    vim.wo.foldmethod = "expr"
                    vim.wo.foldlevel = 99

                    -- enables treesitter based indentation
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
                -- inside function
                require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
            end)

            vim.keymap.set({ "x", "o" }, "af", function()
                -- around function
                require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
            end)

            vim.keymap.set({ "x", "o" }, "ia", function()
                -- inside parameter
                require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
            end)

            vim.keymap.set({ "x", "o" }, "aa", function()
                -- around parameter
                require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
            end)

            -- Show treesitter log messages
            -- vim.api.nvim_create_user_command("TSLog", function() require("nvim-treesitter.log").show() end, { desc = "Show nvim-treesitter log messages" })

            -- Autotag (replaces autotag opts)
            require("nvim-ts-autotag").setup()
        end,
    },
}
-- vim: ts=2 sts=2 sw=2 et
