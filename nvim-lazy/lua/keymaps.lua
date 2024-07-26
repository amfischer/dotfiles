-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- open diagnositc float
vim.keymap.set("n", "J", vim.diagnostic.open_float)

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided.
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Reselect visual selection after indenting.
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Maintain the cursor position when yanking a visual selection.
vim.keymap.set("v", "y", "myy`y")

-- Disable annoying command line typo.
-- vim.keymap.set('n', 'q:', ':q')

-- Paste replace visual selection without copying it.
-- vim.keymap.set('v', 'p', '"_dP')
--
-- Easy insertion of a trailing ; or , from insert mode.
vim.keymap.set("i", ";;", "<Esc>A;")
vim.keymap.set("i", ",,", "<Esc>A,")

-- Quickly clear search highlighting.
vim.keymap.set("n", "<Leader>k", ":nohlsearch<CR>")

-- Open the current file in the default program (on Mac this should just be `open`).
-- vim.keymap.set('n', '<Leader>x', '!xdg-open %<CR><CR>')

-- Move lines up and down.
-- vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR> == gi')
-- vim.keymap.set('i', '<A-k>', '<Esc>:move .-2<CR> == gi')

vim.keymap.set("n", "<A-j>", ":move .+1<CR> ==")
vim.keymap.set("n", "<A-k>", ":move .-2<CR> ==")

vim.keymap.set("v", "<A-j>", ":move '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":move '<-2<CR>gv=gv")

-- Open and close window splits
vim.keymap.set("n", "<Leader>s", ":split<CR>")
vim.keymap.set("n", "<Leader>v", ":vs<CR>")
-- vim.keymap.set('n', '<Leader>Q', '<C-w>q')
vim.keymap.set("n", "<Leader>cs", ":close<CR>")
vim.keymap.set("n", "<Leader>db", ":bdelete<CR>")

-- Switch between buffers
vim.keymap.set("n", "<A-9>", ":bprevious<CR>")
vim.keymap.set("n", "<A-0>", ":bnext<CR>")

-- Save file more easily
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>")

-- Switch windows more easily
-- vim.keymap.set('n', '<C-H>', '<C-W><C-H>')
-- vim.keymap.set('n', '<C-L>', '<C-W><C-L>')
-- vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
-- vim.keymap.set('n', '<C-K>', '<C-W><C-K>')

vim.keymap.set("n", "<A-d>", ":t.<CR>")
vim.keymap.set("n", "<A-y>", ":d<CR>")

-- vim.keymap.set('n', 'fp', ':silent %!vendor/laravel/sail/bin/sail npx prettier --write --stdin-filepath %<CR>')
