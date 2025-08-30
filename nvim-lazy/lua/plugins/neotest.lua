return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "V13Axel/neotest-pest",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-pest")({
                    sail_enabled = function()
                        return false
                    end,
                    -- sail_executable = { "docker", "exec", "[coid-app-laravel.test-1]" },
                    results_path = function()
                        -- return "storage/app/" .. os.date("junit-%Y%m%d-%H%M%S")
                        return vim.fn.getcwd() .. "/storage/logs/pest.xml"
                    end,
                    pest_cmd = "vendor/bin/pest",
                }),
            },
        })

        vim.keymap.set("n", "<leader>tf", function()
            require("neotest").run.run(vim.fn.expand("%"))
        end)
        vim.keymap.set("n", "<leader>tn", ":Neotest run<CR>")
        vim.keymap.set("n", "<F3>", ":Neotest output-panel<CR>")
    end,
}
