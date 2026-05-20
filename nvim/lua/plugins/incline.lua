-- Floating statusline in upper-right of each window
-- https://github.com/b0o/incline.nvim

return {
    "b0o/incline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
        local devicons = require "nvim-web-devicons"
        require("incline").setup {
            window = {
                placement = { horizontal = "right", vertical = "top" },
                margin = { horizontal = 0, vertical = 0 },
                padding = 0,
            },
            render = function(props)
                local full = vim.api.nvim_buf_get_name(props.buf)
                local filename = vim.fn.fnamemodify(full, ":t")
                if filename == "" then filename = "[No Name]" end

                -- If another listed buffer shares this filename, prefix the parent dir
                for _, b in ipairs(vim.api.nvim_list_bufs()) do
                    if b ~= props.buf and vim.bo[b].buflisted then
                        local other = vim.api.nvim_buf_get_name(b)
                        if other ~= "" and vim.fn.fnamemodify(other, ":t") == filename then
                            filename = vim.fn.fnamemodify(full, ":~:.")
                            break
                        end
                    end
                end

                local ft_icon, ft_color = devicons.get_icon_color(filename)
                local modified = vim.bo[props.buf].modified
                local cursorline = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false })
                local bg = cursorline.bg and string.format("#%06x", cursorline.bg) or "NONE"
                return {
                    ft_icon and { " ", ft_icon, " ", guifg = ft_color } or "",
                    " ",
                    { filename, gui = modified and "bold,italic" or "bold" },
                    " ",
                    guibg = bg,
                }
            end,
        }
    end,
}
