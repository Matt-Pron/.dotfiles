vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move highlighted lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in middle during jumps
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Greatest remap ever (Paste over without losing yank)
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Next/Previous search results stay centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Telescope: Find files, search strings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {}) -- Find Files
vim.keymap.set('n', '<C-p>', builtin.git_files, {})        -- Git Files
vim.keymap.set('n', '<leader>ps', function()              -- Project Search (Live Grep)
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- Obsidian vault
vim.keymap.set('n', '<leader>vps', function()              -- Project Search (Live Grep)
    require('telescope.builtin').live_grep({
        search_dirs = { "D:/matt/notas/notas" }
    })
end)
vim.keymap.set('n', '<leader>vpf', function()              -- Project Search (Live Grep)
    require('telescope.builtin').find_files({
        search_dirs = { "D:/matt/notas/notas" }
    })
end)

-- Harpoon: The Anchor (Quick jump between files)
-- Harpoon2: The Modern Anchor
local harpoon = require("harpoon")

-- REQUIRED: Initialize harpoon
harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

-- Telescope integration (Optional, but very Primeagen-style)
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<C-S-E>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })

