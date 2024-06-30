return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "b0o/schemastore.nvim",

            -- Useful status updates for LSP.
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            -- { 'j-hui/fidget.nvim', opts = {} },

            { "folke/lazydev.nvim", opts = {} },
        },
        config = function()
            -- Jump to the definition of the word under your cursor.
            --  This is where a variable was first declared, or where a function is defined, etc.
            --  To jump back, press <C-t>.
            vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions)

            -- Find references for the word under your cursor.
            vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references)

            -- Jump to the implementation of the word under your cursor.
            --  Useful when your language has ways of declaring types without an actual implementation.
            vim.keymap.set("n", "gI", require("telescope.builtin").lsp_implementations)

            -- Jump to the type of the word under your cursor.
            --  Useful when you're not sure what type a variable is and you want to see
            --  the definition of its *type*, not where it was *defined*.
            vim.keymap.set("n", "<leader>D", require("telescope.builtin").lsp_type_definitions)

            -- Fuzzy find all the symbols in your current document.
            --  Symbols are things like variables, functions, types, etc.
            vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols)

            -- Fuzzy find all the symbols in your current workspace.
            --  Similar to document symbols, except searches over your entire project.
            vim.keymap.set("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols)

            -- Rename the variable under your cursor.
            --  Most Language Servers support renaming across files, etc.
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)

            -- Execute a code action, usually your cursor needs to be on top of an error
            -- or a suggestion from your LSP for this to activate.
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

            -- Opens a popup that displays documentation about the word under your cursor
            --  See `:help K` for why this keymap.
            vim.keymap.set("n", "K", vim.lsp.buf.hover)

            -- WARN: This is not Goto Definition, this is Goto Declaration.
            --  For example, in C this would take you to the header.
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration)

            -- LSP servers and clients are able to communicate to each other what features they support.
            --  By default, Neovim doesn't support everything that is in the LSP specification.
            --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
            --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            -- Enable the following language servers
            --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
            --
            --  Add any additional override configuration in the following tables. Available keys are:
            --  - cmd (table): Override the default command used to start the server
            --  - filetypes (table): Override the default list of associated filetypes for the server
            --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
            --  - settings (table): Override the default settings passed when initializing the server.
            --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
            local servers = {

                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                            diagnostics = { disable = { "missing-fields" }, globals = { "vim" } },
                        },
                    },
                },

                intelephense = {
                    settings = {
                        init_options = {
                            licenseKey = "/home/aaron/intelephense/licence.txt",
                        },
                    },
                },

                volar = {
                    filetypes = { "vue", "javascript" },
                },

                tailwindcss = {},

                jsonls = {
                    settings = {
                        json = {
                            schemas = require("schemastore").json.schemas(),
                        },
                    },
                },
            }

            require("mason").setup()

            -- You can add other tools here that you want Mason to install
            -- for you, so that they are available from within Neovim.
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                "stylua", -- Used to format Lua code
            })

            require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        -- This handles overriding only values explicitly passed
                        -- by the server configuration above. Useful when disabling
                        -- certain features of an LSP (for example, turning off formatting for tsserver)
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            })
        end,
    },
}
-- vim: ts=2 sts=2 sw=2 et
