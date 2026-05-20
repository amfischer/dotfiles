vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#FFFFFF' })

-- Brighten window split separator using the current theme's Function fg
local function set_winseparator()
    local fn = vim.api.nvim_get_hl(0, { name = 'Function', link = false })
    if fn.fg then
        vim.api.nvim_set_hl(0, 'WinSeparator', { fg = string.format('#%06x', fn.fg), bold = true })
    end
end

vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('user_winseparator', { clear = true }),
    callback = set_winseparator,
})

set_winseparator()
