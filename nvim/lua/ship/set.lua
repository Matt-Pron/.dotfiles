-- Line Numbers: Absolute for current, relative for others (crucial for jumping)
vim.opt.nu = true
vim.opt.relativenumber = true

-- Tabs & Indentation (The 4-space standard)
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

-- Search behavior
vim.opt.hlsearch = false -- Don't keep words highlighted after searching
vim.opt.incsearch = true -- Show matches while typing

-- UI Comfort
vim.opt.termguicolors = true -- 24-bit colors (essential for Gruvbox Material)

vim.opt.scrolloff = 20        -- Keep 8 lines visible above/below cursor
vim.opt.signcolumn = "yes"   -- Always show the column for LSP icons (prevents "shaking")
vim.opt.isfname:append("@-@") -- Handle file names better

-- The "Safety Net"
vim.opt.updatetime = 50      -- Faster completion and faster diagnostic triggers

--vim.opt.colorcolumn = '80'

vim.g.mapleader = ' '

-- For obsidian
vim.opt.conceallevel = 1
