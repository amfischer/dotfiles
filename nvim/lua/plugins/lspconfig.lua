-- Language Server Protocol
-- https://github.com/neovim/nvim-lspconfig

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "b0o/SchemaStore.nvim",
    },
    config = function()
        -- Setup Mason to automatically install LSP servers
        require("mason").setup()
        require("mason-lspconfig").setup { automatic_installation = true }

        local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

        -- PHP
        vim.lsp.enable "intelephense"
        vim.lsp.config("intelephense", {
            capabilities = capabilities,
            init_options = {
                licenceKey = "/home/aaron/intelephense/licence.txt",
            },
            settings = {
                intelephense = {
                    files = {
                        exclude = { "**/vendor/_laravel_ide" },
                    },
                },
            },
        })

        -- Vue, JavaScript, TypeScript

        local vue_language_server_path = vim.fn.expand "$MASON/packages" .. "/vue-language-server" .. "/node_modules/@vue/language-server"

        local tsserver_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }

        local vue_plugin = {
            name = "@vue/typescript-plugin",
            location = vue_language_server_path,
            languages = { "vue" },
            configNamespace = "typescript",
        }

        local vtsls_config = {
            settings = {
                vtsls = {
                    tsserver = {
                        globalPlugins = {
                            vue_plugin,
                        },
                    },
                },
            },
            filetypes = tsserver_filetypes,
        }

        local ts_ls_config = {
            init_options = {
                plugins = {
                    vue_plugin,
                },
            },
            filetypes = tsserver_filetypes,
        }

        local vue_ls_config = {
            capabilities = capabilities,
        }

        vim.lsp.config("vtsls", vtsls_config)
        vim.lsp.config("vue_ls", vue_ls_config)
        vim.lsp.config("ts_ls", ts_ls_config)
        vim.lsp.enable { "vtsls", "vue_ls" }

        -- Tailwind CSS
        vim.lsp.enable "tailwindcss"
        vim.lsp.config("tailwindcss", {
            capabilities = capabilities,
            filetypes = { "html", "vue", "typescript" },
            settings = {
                tailwindCSS = {
                    files = {
                        exclude = { "**/vendor/**" },
                    },
                },
            },
        })

        -- JSON
        vim.lsp.enable "jsonls"
        vim.lsp.config("jsonls", {
            capabilities = capabilities,
            settings = {
                json = {
                    schemas = require("schemastore").json.schemas(),
                    validate = { enable = true },
                },
            },
        })

        -- Lua
        vim.lsp.enable "lua_ls"
        vim.lsp.config("lua_ls", {
            capabilities = capabilities,
            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if path ~= vim.fn.stdpath "config" and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc")) then return end
                end

                client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most
                        -- likely LuaJIT in the case of Neovim)
                        version = "LuaJIT",
                        -- Tell the language server how to find Lua modules same way as Neovim
                        -- (see `:h lua-module-load`)
                        path = {
                            "lua/?.lua",
                            "lua/?/init.lua",
                        },
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME,
                            -- Depending on the usage, you might want to add additional paths
                            -- here.
                            -- '${3rd}/luv/library'
                            -- '${3rd}/busted/library'
                        },
                        -- Or pull in all of 'runtimepath'.
                        -- NOTE: this is a lot slower and will cause issues when working on
                        -- your own configuration.
                        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                        -- library = {
                        --   vim.api.nvim_get_runtime_file('', true),
                        -- }
                    },
                })
            end,
            settings = {
                Lua = {},
            },
        })

        -- Keymaps
        vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions)
        vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references)
        vim.keymap.set("n", "gI", require("telescope.builtin").lsp_implementations)
        vim.keymap.set("n", "<leader>D", require("telescope.builtin").lsp_type_definitions)
        vim.keymap.set("n", "<leader>s", require("telescope.builtin").lsp_document_symbols)
        vim.keymap.set("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols)
        vim.keymap.set("n", "<F2>", vim.lsp.buf.rename)
        vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action)
        vim.keymap.set("n", "K", vim.lsp.buf.hover)
    end,
}
-- vim: ts=2 sts=2 sw=2 et
