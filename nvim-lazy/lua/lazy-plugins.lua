require("lazy").setup({
    "tpope/vim-surround",
    "tpope/vim-eunuch",
    "tpope/vim-unimpaired",
    "tpope/vim-sleuth",
    "tpope/vim-repeat",
    -- 'tpope/vim-commentary',

    { "numToStr/Comment.nvim", opts = {} },
    { "windwp/nvim-autopairs", opts = {} },
    { "karb94/neoscroll.nvim", opts = {} },

    require("plugins/ale"),
    require("plugins/bufferline"),
    require("plugins/cmp"),
    require("plugins/fugitive"),
    require("plugins/gitsigns"),
    require("plugins/indent-blankline"),
    require("plugins/leap"),
    require("plugins/lspconfig"),
    require("plugins/lualine"),
    require("plugins/neotest"),
    require("plugins/oil"),
    require("plugins/rooter"),
    require("plugins/splitjoin"),
    require("plugins/telescope"),
    require("plugins/textobj-xmlattr"),
    require("plugins/toggleterm"),
    require("plugins/tokyonight"),
    require("plugins/treesitter"),
    require("plugins/vim-tmux-navigator"),
    require("plugins/web-devicons"),
}, {
    ui = {
        -- If you are using a Nerd Font: set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤",
        },
    },
})

-- vim: ts=2 sts=2 sw=2 et
