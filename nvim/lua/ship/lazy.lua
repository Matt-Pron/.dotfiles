local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

vim.filetype.add({
    extension = {
        jsx = "javascriptreact",
        tsx = "typescriptreact",
    },
})

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- 1. Telescope
    { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },

    -- 2. Gruvbox Material (The Carrack's Paint)
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_background = 'hard' -- hard medium soft
            vim.g.gruvbox_material_foreground = 'material' -- material mix original
            vim.g.gruvbox_material_ui_contrast = 'high' -- 1 colored 0 monochrome
            vim.g.gruvbox_material_enable_italic = 1
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_transparent_background = 1
            vim.cmd.colorscheme('gruvbox-material')
        end,
    },

    -- 3. Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            local status_ok, configs = pcall(require, "nvim-treesitter.configs")
            if not status_ok then return end

            configs.setup({
                ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript",
                "html", "css", "c", "cpp" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },

    -- 4. Harpoon2
    { 'ThePrimeagen/harpoon', branch = "harpoon2", dependencies = { "nvim-lua/plenary.nvim" } },

    -- 5. Obsidian
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            workspaces = {
                {
                    name = 'logs',
                    path = "D:/matt/notas/notas",
                },
            },
            ui = { enable = false },          -- enables obsidian.nvim ui
        },
    },

    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        -- This plugin automatically picks up your headers and checkboxes
        opts = {},
    },

    -- 6. LSP Zero & Mason
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            {'neovim/nvim-lspconfig'},
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
            {'onsails/lspkind.nvim'},
        },
        config = function()
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(client, bufnr)
                local opts = {buffer = bufnr}
                vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
                vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
            end)

            -- The nvim-cmp "Dropdown" Logic
            local cmp = require('cmp')
            local cmp_select = {behavior = cmp.SelectBehavior.Select}

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Tab confirms choice
                    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Enter only confirms if you picked something
                }),

                -- formatting = lsp_zero.cmp_format(),
                formatting = {
                    format = function(entry, vim_item)
                        local ok, lspkind = pcall(require, "lspkind")
                        if ok then
                            return lspkind.cmp_format({
                                mode = 'symbol_text',
                                maxwidth = 50,
                            })(entry, vim_item)
                        end
                        return vim_item
                    end
                },

                experimental = {
                    ghost_text = true,
                },
            })

            lsp_zero.format_on_save({
                format_opts = {
                    async = false,
                    timeout_ms = 10000,
                },
                servers = {
                }
            })

            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'lua_ls',
                    'ts_ls',
                    'eslint',
                    'html',
                    'cssls',
                    'emmet_language_server',
                    'clangd'
                },
                handlers = {
                    lsp_zero.default_setup,

                    eslint = function()
                        require('lspconfig').eslint.setup({
                            -- Just the essentials for v8
                            on_attach = function(client, bufnr)
                                vim.api.nvim_create_autocmd("BufWritePre", {
                                    buffer = bufnr,
                                    command = "EslintFixAll",
                                })
                            end,
                        })
                    end,

                    stylelint = function()
                        require('lspconfig').stylelint.setup({
                            filetypes = { "css", "scss" },
                            settings = {
                                stylelint = { config = nil } -- Tells it to look for .stylelintrc.json
                            },
                            on_attach = function(client, bufnr)
                                -- Auto-fix CSS on save!
                                vim.api.nvim_create_autocmd("BufWritePre", {
                                    buffer = bufnr,
                                    callback = function()
                                        vim.cmd("silent! StylelintFixAll")
                                    end,
                                })
                            end,
                        })
                    end,

                }
            })
        end
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'gruvbox-material',
                    icons_enabled = true,
                    component_separators = '|',
                    section_separators = '',
                }
            })
        end
    },

    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },

    {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({
                filetypes = { "*" },
                user_default_options = {
                    RGB = true,
                    RRGGBB = true,
                    names = true,
                    RRGGBBAA = true,
                    rgb_fn = true,
                    hsl_fn = true,
                    css = true,
                    css_fn = true,
                    mode = "background",
                    tailwind = true,
                },
            })
        end,
    },
})

