-- Display buffers or tabs as visual tabs in TUI
-- https://github.com/akinsho/bufferline.nvim

return {
    "akinsho/bufferline.nvim",
    enabled = true,
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
        options = {
            separator_style = "slant",
            mode = "tabs",
            -- Customize the label shown on each tab.
            -- Single window in the tab  -> show the active buffer's filename.
            -- Multiple windows (splits) -> show the tab's working directory basename,
            --                              treating the tab as a project workspace.
            name_formatter = function(buf)
                -- buf.tabnr is the 1-indexed display number; convert to the tab handle.
                local handle = vim.api.nvim_list_tabpages()[buf.tabnr]

                -- Count only "real" splits, ignoring floating windows (e.g. incline,
                -- which would otherwise inflate the count and trigger cwd mode).
                local wincount = 0
                if handle then
                    for _, w in ipairs(vim.api.nvim_tabpage_list_wins(handle)) do
                        local cfg = vim.api.nvim_win_get_config(w)
                        if cfg.relative == "" then wincount = wincount + 1 end
                    end
                end

                local label
                if wincount > 1 then
                    -- getcwd(-1, tabnr) respects per-tab :tcd; :t strips to basename.
                    label = vim.fn.fnamemodify(vim.fn.getcwd(-1, buf.tabnr), ":t")
                else
                    label = buf.name ~= "" and buf.name or "[No Name]"
                end
                return buf.tabnr .. ": " .. label
            end,
            -- Replace the per-filetype devicon with a single colored dot for every tab.
            -- Color is driven by the BufferLineTab highlight group (theme-aware,
            -- automatically brightens for selected/visible tabs).
            get_element_icon = function()
                return "●", "BufferLineTab"
            end,
        },
    },
    config = function(_, opts)
        require("bufferline").setup(opts)

        vim.api.nvim_create_autocmd({ "WinNew", "WinClosed" }, {
            group = vim.api.nvim_create_augroup("bufferline_refresh", { clear = true }),
            callback = function()
                vim.cmd "redrawtabline"
            end,
        })

        -- vim.keymap.set("n", "<A-9>", ":BufferLineCyclePrev<CR>")
        -- vim.keymap.set("n", "<A-0>", ":BufferLineCycleNext<CR>")
        -- vim.keymap.set("n", "<A-(>", ":BufferLineMovePrev<CR>")
        -- vim.keymap.set("n", "<A-)>", ":BufferLineMoveNext<CR>")
    end,
}
